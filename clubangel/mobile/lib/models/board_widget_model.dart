import 'package:core/core.dart';
import 'package:kt_dart/collection.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class BoardWidgetModel {
  BoardWidgetModel({
    @required this.status,
    @required this.boards,
    @required this.refreshEvents,
  });

  final LoadingStatus status;
  final KtList<Board> boards;
  final Function refreshEvents;

  static BoardWidgetModel fromStore(
    Store<AppState> store,
    BoardListType type,
  ) {
    return BoardWidgetModel(
      status: type == BoardListType.realTime
          ? store.state.eventState.nowInTheatersStatus
          : store.state.eventState.comingSoonStatus,
      boards: type == BoardListType.gallery
          ? nowInTheatersSelector(store.state)
          : comingSoonSelector(store.state),
      refreshEvents: () => store.dispatch(RefreshBoardsAction(type)),
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
