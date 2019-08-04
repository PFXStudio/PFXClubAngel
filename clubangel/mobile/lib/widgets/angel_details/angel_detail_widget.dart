import 'package:clubangel/defines/define_images.dart';
import 'package:clubangel/themes/main_theme.dart';
import 'package:clubangel/widgets/angels/angel_list_tile_widget.dart';
import 'package:clubangel/widgets/boards/board_poster.dart';
import 'package:clubangel/widgets/comments/comment_widget.dart';
import 'package:clubangel/widgets/commons/widget_utils.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

import 'angel_detail_backdrop_photo.dart';
import 'angel_detail_contents_widget.dart';
import 'angel_detail_gallery_grid_widget.dart';
import 'angel_detail_member_scroller_widget.dart';
import 'angel_detail_poster.dart';
import 'angel_detail_scroll_effects.dart';

class AngelDetailWidget extends StatefulWidget {
  AngelDetailWidget(this.angel);

  final Angel angel;

  @override
  _AngelDetailWidgetState createState() => _AngelDetailWidgetState();
}

class _AngelDetailWidgetState extends State<AngelDetailWidget> {
  ScrollController _scrollController;
  AngelDetailScrollEffects _scrollEffects;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _scrollEffects = AngelDetailScrollEffects();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    setState(() {
      _scrollEffects.updateScrollOffset(context, _scrollController.offset);
    });
  }

  Widget _buildSynopsis() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        top: widget.angel == null ? 12.0 : 0.0,
        bottom: 16.0,
      ),
      child: AngelDetailContentsWidget(widget.angel),
    );
  }

  Widget _buildGallery() => widget.angel.galleryImages.isNotEmpty()
      ? AngelDetailGalleryGridWidget(widget.angel)
      : Container(color: Colors.white, height: 500.0);

  Widget _buildEventBackdrop() {
    return Positioned(
      top: _scrollEffects.headerOffset,
      child: AngelDetailBackdropPhotoWidget(
        angel: widget.angel,
        scrollEffects: _scrollEffects,
      ),
    );
  }

  Widget _buildStatusBarBackground() {
    final statusBarColor = Theme.of(context).primaryColor;

    return Container(
      height: _scrollEffects.statusBarHeight,
      color: statusBarColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final content = <Widget>[
      _Header(widget.angel),
    ];

    addIfNonNull(_buildSynopsis(), content);
    // TODO : Gallery
    // addIfNonNull(_buildGallery(), content);

    // Some padding for the bottom.
    content.add(const SizedBox(height: 32.0));

    final backgroundImage = Positioned.fill(
      child: Image.asset(
        DefineImages.bgnd_main_path,
        fit: BoxFit.cover,
      ),
    );

    final slivers = CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverList(delegate: SliverChildListDelegate(content)),
      ],
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: Stack(
        children: [
          backgroundImage,
          _buildEventBackdrop(),
          slivers,
          _BackButton(_scrollEffects),
          _buildStatusBarBackground(),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  _Header(this.angel);
  final Angel angel;

  @override
  Widget build(BuildContext context) {
    final moviePoster = Padding(
      padding: const EdgeInsets.all(6.0),
      child: AngelDetailPoster(
        angel: angel,
        size: const Size(125.0, 187.5),
        displayPlayButton: true,
      ),
    );

    return Stack(children: [
      // Transparent container that makes the space for the backdrop photo.
      Container(
        height: 225.0,
        margin: const EdgeInsets.only(bottom: 132.0),
      ),
      // Makes for the white background in poster and event information.
      Positioned(
        bottom: 0.0,
        left: 0.0,
        right: 0.0,
        child: Container(
          color: Colors.white,
          height: 132.0,
        ),
      ),
      Positioned(
        left: 10.0,
        bottom: 0.0,
        child: moviePoster,
      ),
      Positioned(
          top: 218.0,
          left: 146.0,
          right: 0,
          child: Column(children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              FlatButton(
                padding: EdgeInsets.only(top: 5),
                onPressed: () => {},
                child: Row(
                  // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Icon(
                      Icons.visibility,
                      color: MainTheme.disabledColor,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                    ),
                    Text(sprintf("%d", [128]),
                        style: TextStyle(
                            color: MainTheme.disabledColor,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              FlatButton(
                padding: EdgeInsets.only(top: 5),
                onPressed: () => {},
                child: Row(
                  // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Icon(
                      Icons.thumb_up,
                      color: MainTheme.enabledButtonColor,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                    ),
                    Text(sprintf("%d", [15]),
                        style: TextStyle(
                            color: MainTheme.enabledButtonColor,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              FlatButton(
                padding: EdgeInsets.only(top: 5),
                onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CommentWidget(),
                      )),
                },
                child: Row(
                  // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Icon(
                      Icons.message,
                      color: MainTheme.enabledButtonColor,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                    ),
                    Text(sprintf("%d", [15]),
                        style: TextStyle(
                            color: MainTheme.enabledButtonColor,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold)),
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                    ),
                  ],
                ),
              ),
            ]),
            Padding(
                padding: EdgeInsets.only(left: 10), child: _EventInfo(angel)),
          ]))
    ]);
  }
}

class _BackButton extends StatelessWidget {
  _BackButton(this.scrollEffects);
  final AngelDetailScrollEffects scrollEffects;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top,
      left: 4.0,
      child: IgnorePointer(
        ignoring: scrollEffects.backButtonOpacity == 0.0,
        child: Material(
          type: MaterialType.circle,
          color: Colors.transparent,
          child: BackButton(
            color: Colors.white.withOpacity(
              scrollEffects.backButtonOpacity * 0.9,
            ),
          ),
        ),
      ),
    );
  }
}

class _EventInfo extends StatelessWidget {
  _EventInfo(this.angel);
  final Angel angel;

  List<Widget> _buildTitleAndLengthInMinutes() {
    final length = "";
    final genres = "";

    return [
      Text(
        angel.title,
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
      const SizedBox(height: 8.0),
      Text(
        '$length | $genres',
        style: const TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final content = <Widget>[]..addAll(
        _buildTitleAndLengthInMinutes(),
      );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: content,
    );
  }
}

class _DirectorInfo extends StatelessWidget {
  _DirectorInfo(this.director);
  final String director;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "director",
          style: const TextStyle(
            fontSize: 12.0,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 4.0),
        Expanded(
          child: Text(
            director,
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
