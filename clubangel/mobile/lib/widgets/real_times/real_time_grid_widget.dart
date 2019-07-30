import 'package:clubangel/loaders/localizable_loader.dart';
import 'package:clubangel/singletons/keyboard_singleton.dart';
import 'package:clubangel/themes/main_theme.dart';
import 'package:clubangel/widgets/commons/info_message_widget.dart';
import 'package:clubangel/widgets/real_times/real_time_grid_item_widget.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:meta/meta.dart';

class RealTimeGridWidget extends StatelessWidget {
  static const emptyViewKey = const Key('emptyView');
  static const contentKey = const Key('content');

  RealTimeGridWidget({
    @required this.listType,
    @required this.events,
    @required this.onReloadCallback,
  });

  final EventListType listType;
  final KtList<Event> events;
  final VoidCallback onReloadCallback;

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty()) {
      return InfoMessageWidget(
        key: emptyViewKey,
        title: LocalizableLoader.of(context).text("empty"),
        description: LocalizableLoader.of(context).text("empty"),
        onActionButtonTapped: onReloadCallback,
      );
    }

    return _Content(events, listType);
  }
}

class _Content extends StatelessWidget {
  _Content(this.events, this.listType);
  final KtList<Event> events;
  final EventListType listType;

  void _openEventDetails(BuildContext context, Event event) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (_) => EventDetailsPage(event),
    //   ),
    // );
  }

  Widget _buildItem(BuildContext context, int index) {
    final event = events[index];

    return RealTimeGridItemWidget(
      event: event,
      onTapped: () => _openEventDetails(context, event),
      showReleaseDateInformation: listType == EventListType.comingSoon,
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
          key: RealTimeGridWidget.contentKey,
          child: Scaffold(
            body: Scrollbar(
              child: GridView.builder(
                padding: const EdgeInsets.only(bottom: 50.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisChildCount,
                  childAspectRatio: 2 / 3,
                ),
                itemCount: events.size,
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
