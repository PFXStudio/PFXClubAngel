import 'dart:ui' as ui;

import 'package:clubangel/defines/define_images.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'angel_detail_scroll_effects.dart';
import 'angel_detail_scroll_effects.dart';

class AngelDetailBackdropPhotoWidget extends StatelessWidget {
  const AngelDetailBackdropPhotoWidget({
    @required this.angel,
    @required this.scrollEffects,
  });

  final Angel angel;
  final AngelDetailScrollEffects scrollEffects;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
        children: [
          _BackdropPhoto(angel, scrollEffects),
          _BlurOverlay(scrollEffects),
          _InsetShadow(),
        ],
      ),
    );
  }
}

class _BackdropPhoto extends StatelessWidget {
  _BackdropPhoto(this.angel, this.scrollEffects);
  final Angel angel;
  final AngelDetailScrollEffects scrollEffects;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _PlaceholderBackground(scrollEffects.backdropHeight),
        _BackdropImage(angel, scrollEffects),
      ],
    );
  }
}

class _PlaceholderBackground extends StatelessWidget {
  _PlaceholderBackground(this.height);
  final double height;

  @override
  Widget build(BuildContext context) {
    final decoration = const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          Color(0xFF222222),
          Color(0xFF424242),
        ],
      ),
    );

    return Container(
      width: MediaQuery.of(context).size.width,
      height: height,
      decoration: decoration,
      child: const Center(
        child: Icon(
          Icons.theaters,
          color: Colors.white30,
          size: 96.0,
        ),
      ),
    );
  }
}

class _BackdropImage extends StatelessWidget {
  _BackdropImage(this.angel, this.scrollEffects);
  final Angel angel;
  final AngelDetailScrollEffects scrollEffects;

  String get photoUrl =>
      angel.images.landscapeBig ?? angel.images.landscapeSmall;

  @override
  Widget build(BuildContext context) {
    if (photoUrl == null) {
      return const SizedBox.shrink();
    }

    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth,
      height: scrollEffects.backdropHeight,
      child: FadeInImage.assetNetwork(
        fadeInDuration: const Duration(milliseconds: 300),
        placeholder: DefineImages.bgnd_main_path,
        image: photoUrl,
        width: screenWidth,
        height: scrollEffects.backdropHeight,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _BlurOverlay extends StatelessWidget {
  _BlurOverlay(this.scrollEffects);
  final AngelDetailScrollEffects scrollEffects;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ui.ImageFilter.blur(
        sigmaX: scrollEffects.backdropOverlayBlur,
        sigmaY: scrollEffects.backdropOverlayBlur,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: scrollEffects.backdropHeight,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(
            scrollEffects.backdropOverlayOpacity * 0.4,
          ),
        ),
      ),
    );
  }
}

class _InsetShadow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Positioned(
      bottom: -8.0,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 5.0,
              spreadRadius: 3.0,
            ),
          ],
        ),
        child: SizedBox(
          width: screenWidth,
          height: 10.0,
        ),
      ),
    );
  }
}
