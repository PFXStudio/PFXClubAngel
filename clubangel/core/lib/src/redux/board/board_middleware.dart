import 'dart:async';

import 'package:core/src/models/board.dart';
import 'package:core/src/models/loading_status.dart';
import 'package:core/src/models/theater.dart';
import 'package:core/src/networking/finnkino_api.dart';
import 'package:core/src/redux/_common/common_actions.dart';
import 'package:core/src/redux/app/app_state.dart';
import 'package:core/src/redux/board/board_actions.dart';
import 'package:redux/redux.dart';

class BoardMiddleware extends MiddlewareClass<AppState> {
  BoardMiddleware(this.api);
  final FinnkinoApi api;

  @override
  Future<void> call(
      Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);

    final theater = _determineTheater(action, store);

    if (action is InitCompleteAction) {
      await _fetchNowPlayingEvents(theater, next);
    } else if (action is BoardEventsAction) {
      await _refreshEvents(theater, action, next);
    } else if (action is ChangeCurrentTheaterAction) {
      await _fetchAllEvents(theater, next);
    } else if (action is FetchComingSoonEventsIfNotLoadedAction) {
      if (store.state.boardState.comingSoonStatus == LoadingStatus.idle) {
        await _fetchComingSoonEvents(next);
      }
    }
  }

  Future<void> _fetchAllEvents(Theater theater, NextDispatcher next) async {
    await _fetchNowPlayingEvents(theater, next);
    return _fetchComingSoonEvents(next);
  }

  Future<void> _fetchNowPlayingEvents(
      Theater theater, NextDispatcher next) async {
    if (theater != null) {
      next(RequestingBoardsAction(BoardListType.realTime));

      try {
        final inTheatersEvents = await api.getNowInTheatersEvents(theater);
        next(ReceivedInTheatersEventsAction(inTheatersEvents));
      } catch (e) {
        next(ErrorLoadingBoardsAction(BoardListType.realTime));
      }
    }
  }

  Future<void> _fetchComingSoonEvents(NextDispatcher next) async {
    next(RequestingBoardsAction(BoardListType.clubInfo));

    try {
      final comingSoonEvents = await api.getUpcomingEvents();
      next(ReceivedComingSoonEventsAction(comingSoonEvents));
    } catch (e) {
      print(e.toString());
      next(ErrorLoadingBoardsAction(BoardListType.clubInfo));
    }
  }

  Theater _determineTheater(dynamic action, Store<AppState> store) {
    try {
      return action is BoardEventsAction
          ? store.state.theaterState.currentTheater
          : action.selectedTheater;
    } catch (e) {
      /// FIXME: Ugly hack because rush to release before Christmas rush.
      return null;
    }
  }

  Future<void> _refreshEvents(
      Theater theater, BoardEventsAction action, NextDispatcher next) {
    if (action.type == BoardListType.realTime) {
      return _fetchNowPlayingEvents(theater, next);
    } else {
      return _fetchComingSoonEvents(next);
    }
  }
}
