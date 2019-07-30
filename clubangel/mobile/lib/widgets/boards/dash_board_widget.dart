import 'package:clubangel/loaders/localizable_loader.dart';
import 'package:clubangel/models/dash_board_widget_model.dart';
import 'package:clubangel/widgets/commons/info_message_widget.dart';
import 'package:clubangel/widgets/commons/loading_widget.dart';
import 'package:clubangel/widgets/commons/platform_adaptive_progress_indicator.dart';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

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
  final EventListType listType;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, DashBoardWidgetModel>(
      distinct: true,
      onInit: (store) =>
          store.dispatch(FetchComingSoonEventsIfNotLoadedAction()),
      converter: (store) => DashBoardWidgetModel.fromStore(store, listType),
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

class PlanCard extends StatelessWidget {
  const PlanCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10.0),
      padding: EdgeInsets.all(12.0),
      width: 140.0,
      decoration: BoxDecoration(
          gradient: linearColor, borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              protectionMsgs[0],
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w200),
            ),
          ),
          Spacer(),
          Align(
              alignment: Alignment.bottomRight,
              child: Text(
                "\$99.99",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w200,
                    fontSize: 16.0),
                textAlign: TextAlign.left,
              )),
        ],
      ),
    );
  }
}

class PlanCardGrey extends StatelessWidget {
  const PlanCardGrey({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      padding: EdgeInsets.all(12.0),
      width: 140.0,
      decoration: BoxDecoration(
          gradient: linearColor, borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              protectionMsgs[1],
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w200),
            ),
          ),
          Spacer(),
          Align(
              alignment: Alignment.bottomRight,
              child: Text("Add".toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w200,
                      fontSize: 16.0))),
        ],
      ),
    );
  }
}

class ProtectionSection extends StatelessWidget {
  const ProtectionSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          PlanCard(),
          PlanCardGrey(),
          PlanCardGrey(),
        ],
      ),
    );
  }
}

class DashBoardWidgetContent extends StatelessWidget {
  DashBoardWidgetContent(this.viewModel, this.listType);
  final DashBoardWidgetModel viewModel;
  final EventListType listType;

  @override
  Widget build(BuildContext context) {
    // final messages = MessageProvider.of(context);
    var headers = ["Real Time", "Free", "Gallery"];
    return LoadingWidget(
        status: viewModel.status,
        loadingContent: const PlatformAdaptiveProgressIndicator(),
        errorContent: ErrorView(
          description: LocalizableLoader.of(context).text("error_load"),
          onRetry: viewModel.refreshEvents,
        ),
        successContent: Scrollbar(
            child: ListView.builder(
                itemCount: headers.length * 2,
                itemBuilder: (context, index) => index % 2 == 0
                    ? Container(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(headers[(index ~/ 2).toInt()],
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                        padding: EdgeInsets.all(10.0),
                      )
                    : ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ProtectionSection(),
                            SizedBox(
                              height: 30.0,
                            ),
                          ],
                        ),
                      ))));

    /*
        Container(
          margin: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              WhiteText(
                text: "Real Time",
                size: 24.0,
              ),
              SizedBox(
                height: 20.0,
              ),
              ProtectionSection(),
              SizedBox(
                height: 30.0,
              ),
              WhiteText(
                text: "Protection Plans",
                size: 24.0,
              ),
              SizedBox(
                height: 20.0,
              ),
              ProtectionSection(),
              SizedBox(
                height: 30.0,
              ),
              WhiteText(
                text: "Gallery",
                size: 24.0,
              ),
              SizedBox(
                height: 20.0,
              ),
              ProtectionSection(),
            ],
          ),
        ));
        */
  }
}
