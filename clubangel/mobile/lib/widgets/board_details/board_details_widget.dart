import 'package:clubangel/defines/define_images.dart';
import 'package:clubangel/themes/main_theme.dart';
import 'package:clubangel/widgets/angels/angel_list_tile_widget.dart';
import 'package:clubangel/widgets/boards/board_poster.dart';
import 'package:clubangel/widgets/comments/comment_widget.dart';
import 'package:clubangel/widgets/commons/widget_utils.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

import 'board_details_backdrop_photo.dart';
import 'board_details_contents_widget.dart';
import 'board_details_gallery_grid_widget.dart';
import 'board_details_member_scroller_widget.dart';
import 'board_details_scroll_effects.dart';

class BoardDetailsWidget extends StatefulWidget {
  BoardDetailsWidget(
    this.event, {
    this.show,
  });

  final Board event;
  final Angel show;

  @override
  _BoardDetailsWidgetState createState() => _BoardDetailsWidgetState();
}

class _BoardDetailsWidgetState extends State<BoardDetailsWidget> {
  ScrollController _scrollController;
  BoardDetailsScrollEffects _scrollEffects;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _scrollEffects = BoardDetailsScrollEffects();
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
    if (widget.event.hasSynopsis) {
      return Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          top: widget.show == null ? 12.0 : 0.0,
          bottom: 16.0,
        ),
        child: BoardDetailsContentsWidget(widget.event),
      );
    }

    return null;
  }

  Widget _buildGallery() => widget.event.galleryImages.isNotEmpty()
      ? BoardDetailsGalleryGridWidget(widget.event)
      : Container(color: Colors.white, height: 500.0);

  Widget _buildEventBackdrop() {
    return Positioned(
      top: _scrollEffects.headerOffset,
      child: BoardDetailsBackdropPhotoWidget(
        event: widget.event,
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
      _Header(widget.event),
    ];

    addIfNonNull(_buildSynopsis(), content);
    addIfNonNull(_buildGallery(), content);

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
  _Header(this.event);
  final Board event;

  @override
  Widget build(BuildContext context) {
    final moviePoster = Padding(
      padding: const EdgeInsets.all(6.0),
      child: BoardPoster(
        event: event,
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
                padding: EdgeInsets.only(left: 10), child: _EventInfo(event)),
          ]))
    ]);
  }
}

class _BackButton extends StatelessWidget {
  _BackButton(this.scrollEffects);
  final BoardDetailsScrollEffects scrollEffects;

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
  _EventInfo(this.event);
  final Board event;

  List<Widget> _buildTitleAndLengthInMinutes() {
    final length = '${event.lengthInMinutes} min';
    final genres = event.genres.split(', ').take(4).join(', ');

    return [
      Text(
        event.title,
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

    if (event.directors.isNotEmpty()) {
      content.add(Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: _DirectorInfo(event.director),
      ));
    }

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
