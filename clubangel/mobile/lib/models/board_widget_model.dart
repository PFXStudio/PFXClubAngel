import 'package:core/core.dart';
import 'package:kt_dart/collection.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class BoardWidgetModel {
  BoardWidgetModel({
    @required this.status,
    @required this.boards,
    @required this.refreshBoards,
  });

  final LoadingStatus status;
  final KtList<Event> boards;
  final Function refreshBoards;

  static BoardWidgetModel fromStore(
    Store<AppState> store,
    EventListType type,
  ) {
    return BoardWidgetModel(
      status: type == EventListType.nowInTheaters
          ? store.state.eventState.nowInTheatersStatus
          : store.state.eventState.comingSoonStatus,
      boards: type == EventListType.comingSoon
          ? nowInTheatersSelector(store.state)
          : comingSoonSelector(store.state),
      refreshBoards: () => store.dispatch(RefreshEventsAction(type)),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BoardWidgetModel &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          boards == other.boards;

  @override
  int get hashCode => status.hashCode ^ boards.hashCode;
}
