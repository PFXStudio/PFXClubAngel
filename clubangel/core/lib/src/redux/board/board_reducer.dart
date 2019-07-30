import 'package:core/src/models/board.dart';
import 'package:core/src/models/loading_status.dart';
import 'package:core/src/redux/_common/common_actions.dart';
import 'package:core/src/redux/board/board_actions.dart';
import 'package:core/src/redux/board/board_state.dart';
import 'package:kt_dart/collection.dart';

import '../../../core.dart';

BoardState eventReducer(BoardState state, dynamic action) {
  if (action is RequestingEventsAction) {
    return _requestingEvents(state, action.type);
  } else if (action is ReceivedInTheatersEventsAction) {
    return state.copyWith(
      nowInTheatersStatus: LoadingStatus.success,
      nowInTheatersEvents: action.events,
    );
  } else if (action is ReceivedComingSoonEventsAction) {
    return state.copyWith(
      comingSoonStatus: LoadingStatus.success,
      comingSoonEvents: action.events,
    );
  } else if (action is ErrorLoadingEventsAction) {
    return _errorLoadingEvents(state, action.type);
  } else if (action is UpdateActorsForEventAction) {
    return _updateActorsForEvent(state, action);
  }

  return state;
}

BoardState _requestingEvents(BoardState state, EventListType type) {
  final status = LoadingStatus.loading;

  if (type == EventListType.nowInTheaters) {
    return state.copyWith(nowInTheatersStatus: status);
  }

  return state.copyWith(comingSoonStatus: status);
}

BoardState _errorLoadingEvents(BoardState state, EventListType type) {
  final status = LoadingStatus.error;

  if (type == EventListType.nowInTheaters) {
    return state.copyWith(nowInTheatersStatus: status);
  }

  return state.copyWith(comingSoonStatus: status);
}

BoardState _updateActorsForEvent(
    BoardState state, UpdateActorsForEventAction action) {
  final event = action.event;
  event.actors = action.actors;

  return state.copyWith(
    nowInTheatersEvents:
        _addActorImagesToEvent(state.nowInTheatersEvents, event),
    comingSoonEvents: _addActorImagesToEvent(state.comingSoonEvents, event),
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
