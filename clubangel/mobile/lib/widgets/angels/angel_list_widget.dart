import 'dart:async';

import 'package:clubangel/loaders/localizable_loader.dart';
import 'package:clubangel/widgets/angels/angel_list_tile_widget.dart';
import 'package:clubangel/widgets/commons/info_message_widget.dart';
import 'package:clubangel/widgets/commons/loading_widget.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';

class AngelListWidget extends StatefulWidget {
  static const Key emptyViewKey = Key('emptyView');
  static const Key contentKey = Key('content');

  AngelListWidget(this.status, this.shows);
  final LoadingStatus status;
  final KtList<Angel> shows;

  @override
  _AngelListWidgetState createState() => _AngelListWidgetState();
}

class _AngelListWidgetState extends State<AngelListWidget> {
  KtList<Angel> _shows = emptyList();
  bool _showEmptyView = false;

  @override
  void initState() {
    super.initState();
    _shows = widget.shows;
    _showEmptyView = _shows.isEmpty() && widget.status == LoadingStatus.success;
  }

  @override
  void didUpdateWidget(AngelListWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    /// We do this dance here since we want to "freeze" the content until
    /// the [LoadingView] hides us completely.
    if (oldWidget.status != widget.status) {
      /// Loading status changed and shows got updated; update them after the
      /// animation finishes.
      if (widget.status == LoadingStatus.success) {
        Timer(
          LoadingWidget.successContentAnimationDuration,
          () => _shows = widget.shows,
        );
      }
    } else if (widget.status == LoadingStatus.success) {
      /// Loading status didn't change, so update the shows instantly.
      _shows = widget.shows;
    }

    _showEmptyView =
        widget.shows.isEmpty() && widget.status == LoadingStatus.success;
  }

  @override
  Widget build(BuildContext context) {
    if (_showEmptyView) {
      return InfoMessageWidget(
        key: AngelListWidget.emptyViewKey,
        title: LocalizableLoader.of(context).text("try_again"),
        description: LocalizableLoader.of(context).text("try_again"),
      );
    }

    return Scrollbar(
      key: AngelListWidget.contentKey,
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 50.0),
        itemCount: _shows.size,
        itemBuilder: (BuildContext context, int index) {
          final show = _shows[index];
          return AngelListTileWidget(show);
        },
      ),
    );
  }
}
