import 'package:clubangel/loaders/localizable_loader.dart';
import 'package:clubangel/singletons/keyboard_singleton.dart';
import 'package:clubangel/themes/main_theme.dart';
import 'package:clubangel/widgets/board_details/board_details_widget.dart';
import 'package:clubangel/widgets/commons/info_message_widget.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:meta/meta.dart';

import 'board_grid_item_widget.dart';

class BoardGridWidget extends StatelessWidget {
  static const emptyViewKey = const Key('emptyView');
  static const contentKey = const Key('content');

  BoardGridWidget({
    @required this.listType,
    @required this.boards,
    @required this.onReloadCallback,
  });

  final BoardListType listType;
  final KtList<Board> boards;
  final VoidCallback onReloadCallback;

  @override
  Widget build(BuildContext context) {
    if (boards.isEmpty()) {
      return InfoMessageWidget(
        key: emptyViewKey,
        title: LocalizableLoader.of(context).text("empty"),
        description: LocalizableLoader.of(context).text("empty"),
        onActionButtonTapped: onReloadCallback,
      );
    }

    return _Content(boards, listType);
  }
}

class _Content extends StatelessWidget {
  _Content(this.boards, this.listType);
  final KtList<Board> boards;
  final BoardListType listType;

  void _openEventDetails(BuildContext context, Board board) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BoardDetailsWidget(board),
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    final board = boards[index];

    return BoardGridItemWidget(
      board: board,
      onTapped: () => _openEventDetails(context, board),
      showReleaseDateInformation: listType == BoardListType.clubInfo,
    );
  }

  void _incrementCounter() {}
  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final crossAxisChildCount = isPortrait ? 2 : 4;

    return Scaffold(
      body: Container(
          key: BoardGridWidget.contentKey,
          child: Scaffold(
            body: Scrollbar(
              child: GridView.builder(
                padding: const EdgeInsets.only(bottom: 50.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisChildCount,
                  childAspectRatio: 2 / 3,
                ),
                itemCount: boards.size,
                itemBuilder: _buildItem,
              ),
            ),
          )),
      floatingActionButton: KeyboardSingleton().isKeyboardVisible()
          ? Container()
          : Container(
              child: FloatingActionButton(
                onPressed: _incrementCounter,
                tooltip: 'Add',
                backgroundColor: MainTheme.defaultColor,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              padding: EdgeInsets.only(bottom: 70),
            ),
    );
  }
}
