import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class GalleryWidget extends StatefulWidget {
  @override
  _GalleryWidgetState createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

typedef PhotoViewGalleryPageChangedCallback = void Function(int index);

/// A type definition for a [Function] that defines a page in [PhotoViewGallery.build]
typedef PhotoViewGalleryBuilder = PhotoViewGalleryPageOptions Function(
    BuildContext context, int index);

class PhotoViewGalleryPageOptions {
  PhotoViewGalleryPageOptions({
    Key key,
    @required this.imageProvider,
    this.heroTag,
    this.minScale,
    this.maxScale,
    this.initialScale,
    this.controller,
    this.scaleStateController,
    this.basePosition,
    this.scaleStateCycle,
    // this.onTapUp,
    // this.onTapDown
  })  : child = null,
        childSize = null,
        assert(imageProvider != null);

  PhotoViewGalleryPageOptions.customChild({
    @required this.child,
    @required this.childSize,
    this.heroTag,
    this.minScale,
    this.maxScale,
    this.initialScale,
    this.controller,
    this.scaleStateController,
    this.basePosition,
    this.scaleStateCycle,
    // this.onTapUp,
    // this.onTapDown
  })  : imageProvider = null,
        assert(child != null),
        assert(childSize != null);

  /// Mirror to [PhotoView.imageProvider]
  final ImageProvider imageProvider;

  /// Mirror to [PhotoView.heroTag
  final Object heroTag;

  /// Mirror to [PhotoView.minScale]
  final dynamic minScale;

  /// Mirror to [PhotoView.maxScale]
  final dynamic maxScale;

  /// Mirror to [PhotoView.initialScale]
  final dynamic initialScale;

  /// Mirror to [PhotoView.controller]
  final PhotoViewController controller;

  /// Mirror to [PhotoView.scaleStateController]
  final PhotoViewScaleStateController scaleStateController;

  /// Mirror to [PhotoView.basePosition]
  final Alignment basePosition;

  /// Mirror to [PhotoView.child]
  final Widget child;

  /// Mirror to [PhotoView.childSize]
  final Size childSize;

  /// Mirror to [PhotoView.scaleStateCycle]
  final ScaleStateCycle scaleStateCycle;

  // /// Mirror to [PhotoView.onTapUp]
  // final PhotoViewImageTapUpCallback onTapUp;

  // /// Mirror to [PhotoView.onTapDown]
  // final PhotoViewImageTapDownCallback onTapDown;
}
