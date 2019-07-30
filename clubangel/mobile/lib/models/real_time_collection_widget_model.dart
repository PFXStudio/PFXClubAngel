import 'package:core/core.dart';
import 'package:kt_dart/collection.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class RealTimeCollectionWidgetModel {
  RealTimeCollectionWidgetModel({
    @required this.status,
    @required this.events,
    @required this.refreshEvents,
  });

  final LoadingStatus status;
  final KtList<Event> events;
  final Function refreshEvents;

  static RealTimeCollectionWidgetModel fromStore(
    Store<AppState> store,
    EventListType type,
  ) {
    return RealTimeCollectionWidgetModel(
      status: type == EventListType.nowInTheaters
          ? store.state.eventState.nowInTheatersStatus
          : store.state.eventState.comingSoonStatus,
      events: type == EventListType.nowInTheaters
          ? nowInTheatersSelector(store.state)
          : comingSoonSelector(store.state),
      refreshEvents: () => store.dispatch(RefreshEventsAction(type)),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RealTimeCollectionWidgetModel &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          events == other.events;

  @override
  int get hashCode => status.hashCode ^ events.hashCode;
}
