import 'package:core/src/models/board.dart';
import 'package:core/src/models/loading_status.dart';
import 'package:core/src/redux/app/app_state.dart';
import 'package:core/src/redux/board/board_actions.dart';
import 'package:core/src/redux/board/board_selectors.dart';
import 'package:kt_dart/collection.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class EventsPageViewModel {
  EventsPageViewModel({
    @required this.status,
    @required this.boards,
    @required this.refreshEvents,
  });

  final LoadingStatus status;
  final KtList<Board> boards;
  final Function refreshEvents;

  static EventsPageViewModel fromStore(
    Store<AppState> store,
    BoardListType type,
  ) {
    return EventsPageViewModel(
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
      other is EventsPageViewModel &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          boards == other.boards;

  @override
  int get hashCode => status.hashCode ^ boards.hashCode;
}
