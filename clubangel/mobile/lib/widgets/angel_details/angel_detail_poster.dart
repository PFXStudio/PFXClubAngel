import 'package:clubangel/defines/define_images.dart';
import 'package:clubangel/widgets/commons/widget_utils.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

@visibleForTesting
Function(String) launchTrailerVideo = (url) async {
  if (await canLaunch(url)) {
    await launch(url);
  }
};

class AngelDetailPoster extends StatelessWidget {
  static const Key playButtonKey = const Key('playButton');

  AngelDetailPoster({
    @required this.angel,
    this.size,
    this.displayPlayButton = false,
  });

  final Angel angel;
  final Size size;
  final bool displayPlayButton;

  Widget _buildPlayButton() =>
      displayPlayButton && angel.youtubeTrailers.isNotEmpty()
          ? _PlayButton(angel)
          : null;

  Widget _buildPosterImage() => angel.images.portraitMedium != null
      ? FadeInImage.assetNetwork(
          placeholder: DefineImages.bgnd_main_220_path,
          image: angel.images.portraitMedium,
          width: size?.width,
          height: size?.height,
          fadeInDuration: const Duration(milliseconds: 300),
          fit: BoxFit.cover,
        )
      : null;

  @override
  Widget build(BuildContext context) {
    final content = <Widget>[
      const Icon(
        Icons.image,
        color: Colors.white24,
        size: 44.0,
      ),
    ];

    addIfNonNull(_buildPosterImage(), content);
    // TODO : youtube
    // addIfNonNull(_buildPlayButton(), content);

    return Container(
      decoration: _buildDecorations(),
      width: size?.width,
      height: size?.height,
      child: Stack(
        alignment: Alignment.center,
        children: content,
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  _PlayButton(this.angel);
  final Angel angel;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black38,
      ),
      child: Material(
        type: MaterialType.circle,
        color: Colors.transparent,
        child: IconButton(
          key: AngelDetailPoster.playButtonKey,
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.play_circle_outline),
          iconSize: 42.0,
          color: Colors.white.withOpacity(0.8),
          onPressed: () {
            final url = angel.youtubeTrailers.first();
            launchTrailerVideo(url);
          },
        ),
      ),
    );
  }
}

BoxDecoration _buildDecorations() {
  return const BoxDecoration(
    boxShadow: [
      BoxShadow(
        offset: Offset(1.0, 1.0),
        spreadRadius: 1.0,
        blurRadius: 2.0,
        color: Colors.black38,
      ),
    ],
    gradient: LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [
        Color(0xFF222222),
        Color(0xFF424242),
      ],
    ),
  );
}
