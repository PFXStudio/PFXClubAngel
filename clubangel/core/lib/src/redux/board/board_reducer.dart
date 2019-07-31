import 'package:core/src/models/board.dart';
import 'package:core/src/models/loading_status.dart';
import 'package:core/src/redux/_common/common_actions.dart';
import 'package:core/src/redux/board/board_actions.dart';
import 'package:core/src/redux/board/board_state.dart';
import 'package:kt_dart/collection.dart';

BoardState boardReducer(BoardState state, dynamic action) {
  if (action is RequestingBoardsAction) {
    return _requestingEvents(state, action.type);
  } else if (action is ReceivedInTheatersEventsAction) {
    return state.copyWith(
      nowInTheatersStatus: LoadingStatus.success,
      nowInTheatersEvents: action.boards,
    );
  } else if (action is ReceivedComingSoonEventsAction) {
    return state.copyWith(
      comingSoonStatus: LoadingStatus.success,
      comingSoonEvents: action.boards,
    );
  } else if (action is ErrorLoadingBoardsAction) {
    return _errorLoadingEvents(state, action.type);
  } else if (action is UpdateActorsForEventAction) {
    return _updateActorsForEvent(state, action);
  }

  return state;
}

BoardState _requestingEvents(BoardState state, BoardListType type) {
  final status = LoadingStatus.loading;

  if (type == BoardListType.realTime) {
    return state.copyWith(nowInTheatersStatus: status);
  }

  return state.copyWith(comingSoonStatus: status);
}

BoardState _errorLoadingEvents(BoardState state, BoardListType type) {
  final status = LoadingStatus.error;

  if (type == BoardListType.realTime) {
    return state.copyWith(nowInTheatersStatus: status);
  }

  return state.copyWith(comingSoonStatus: status);
}

BoardState _updateActorsForEvent(
    BoardState state, UpdateActorsForEventAction action) {
  final board = action.board;
  board.actors = action.actors;

  return state.copyWith(
    nowInTheatersEvents:
        _addActorImagesToEvent(state.nowInTheatersEvents, board),
    comingSoonEvents: _addActorImagesToEvent(state.comingSoonEvents, board),
  );
}

KtList<Board> _addActorImagesToEvent(
    KtList<Board> originalEvents, Board replacement) {
  final positionToReplace = originalEvents
      .indexOfFirst((candidate) => candidate.id == replacement.id);

  if (positionToReplace > -1) {
    final newEvents = originalEvents.toMutableList();
    newEvents[positionToReplace] = replacement;
    return newEvents;
  }

  return originalEvents;
}
