import 'package:clubangel/loaders/localizable_loader.dart';
import 'package:clubangel/models/board_widget_model.dart';
import 'package:clubangel/widgets/board_details/board_details_widget.dart';
import 'package:clubangel/widgets/commons/info_message_widget.dart';
import 'package:clubangel/widgets/commons/loading_widget.dart';
import 'package:clubangel/widgets/commons/platform_adaptive_progress_indicator.dart';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:kt_dart/collection.dart';
import 'dash_board_list_item_widget.dart';

const linearColor = LinearGradient(
    colors: [Colors.white24, Colors.transparent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight);

const protectionMsgs = [
  "3 year protection plan for custom PC Build with super fast services",
  "2 year protection plan for Alienware Monitors with cheap fixings"
];

class DashBoardWidget extends StatelessWidget {
  DashBoardWidget(this.listType);
  final BoardListType listType;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BoardWidgetModel>(
      distinct: true,
      onInit: (store) =>
          store.dispatch(FetchComingSoonEventsIfNotLoadedAction()),
      converter: (store) => BoardWidgetModel.fromStore(store, listType),
      builder: (_, viewModel) => DashBoardWidgetContent(viewModel, listType),
    );
  }
}

class WhiteText extends StatelessWidget {
  final String text;
  final double size;

  const WhiteText({Key key, this.text, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
          color: Colors.white,
          fontSize: size,
          fontWeight: FontWeight.bold,
        ));
  }
}

class ProtectionSection extends StatelessWidget {
  ProtectionSection({
    @required this.listType,
    @required this.boards,
    @required this.onReloadCallback,
  });

  final BoardListType listType;
  final KtList<Board> boards;
  final VoidCallback onReloadCallback;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 330.0,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: boards.count(),
            itemBuilder: (context, index) {
              return DashBoardListItemWidget(
                board: boards[index],
                onTapped: () => _openBoardDetails(context, boards[index]),
                showReleaseDateInformation: listType == BoardListType.clubInfo,
              );
            }));
  }

  void _openBoardDetails(BuildContext context, Board board) {
    print("tab!!" + board.title);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BoardDetailsWidget(board),
      ),
    );
  }
}

class DashBoardWidgetContent extends StatelessWidget {
  DashBoardWidgetContent(this.viewModel, this.listType);
  final BoardWidgetModel viewModel;
  final BoardListType listType;

  @override
  Widget build(BuildContext context) {
    var headers = ["Real Time", "Free", "Gallery"];
    return LoadingWidget(
        status: viewModel.status,
        loadingContent: const PlatformAdaptiveProgressIndicator(),
        errorContent: ErrorView(
          description: LocalizableLoader.of(context).text("error_load"),
          onRetry: viewModel.refreshBoards,
        ),
        successContent: Scrollbar(
            child: ListView.builder(
                itemCount: headers.length * 2,
                itemBuilder: (context, index) => index % 2 == 0
                    ? Container(
                        color: Colors.black38,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(headers[(index ~/ 2).toInt()],
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                        padding: EdgeInsets.only(
                            top: 10.0, left: 10.0, bottom: 10.0),
                      )
                    : ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ProtectionSection(
                              boards: viewModel.boards,
                              listType: listType,
                              onReloadCallback: () {},
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                      ))));
  }
}
