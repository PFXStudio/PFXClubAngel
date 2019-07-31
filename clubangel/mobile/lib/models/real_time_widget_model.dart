import 'package:core/core.dart';
import 'package:kt_dart/collection.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class RealTimeWidgetModel {
  RealTimeWidgetModel({
    @required this.status,
    @required this.boards,
    @required this.refreshEvents,
  });

  final LoadingStatus status;
  final KtList<Board> boards;
  final Function refreshEvents;

  static RealTimeWidgetModel fromStore(
    Store<AppState> store,
    BoardListType type,
  ) {
    return RealTimeWidgetModel(
      status: type == BoardListType.realTime
          ? store.state.boardState.nowInTheatersStatus
          : store.state.boardState.comingSoonStatus,
      boards: type == BoardListType.realTime
          ? nowInTheatersSelector(store.state)
          : comingSoonSelector(store.state),
      refreshEvents: () => store.dispatch(BoardEventsAction(type)),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RealTimeWidgetModel &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          boards == other.boards;

  @override
  int get hashCode => status.hashCode ^ boards.hashCode;
}
