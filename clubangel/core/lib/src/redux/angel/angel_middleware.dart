import 'dart:async';

import 'package:core/src/models/loading_status.dart';
import 'package:core/src/models/angel.dart';
import 'package:core/src/models/show_cache.dart';
import 'package:core/src/models/theater.dart';
import 'package:core/src/networking/finnkino_api.dart';
import 'package:core/src/redux/_common/common_actions.dart';
import 'package:core/src/redux/app/app_state.dart';
import 'package:core/src/redux/angel/angel_actions.dart';
import 'package:core/src/utils/clock.dart';
import 'package:kt_dart/collection.dart';
import 'package:redux/redux.dart';

class AngelMiddleware extends MiddlewareClass<AppState> {
  AngelMiddleware(this.api);

  final FinnkinoApi api;

  @override
  Future<Null> call(
      Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);

    if (action is InitCompleteAction || action is UpdateAngelDatesAction) {
      await _updateAngelDates(action, next);
    }

    if (action is ChangeCurrentTheaterAction ||
        action is RefreshAngelsAction ||
        action is ChangeCurrentDateAction) {
      await _updateCurrentAngels(store, action, next);
    }

    if (action is FetchAngelsIfNotLoadedAction) {
      if (store.state.showState.loadingStatus == LoadingStatus.idle) {
        await _updateCurrentAngels(store, action, next);
      }
    }
  }

  void _updateAngelDates(dynamic action, NextDispatcher next) {
    final now = Clock.getCurrentTime();
    var dates =
        listFrom(List.generate(7, (index) => now.add(Duration(days: index))));

    next(new AngelDatesUpdatedAction(dates));
  }

  Future<void> _updateCurrentAngels(
      Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(RequestingAngelsAction());

    try {
      final theater = _getCorrectTheater(store, action);
      final date = _getCorrectDate(store, action);
      final cacheKey = DateTheaterPair(date, theater);

      var shows = store.state.showState.shows[cacheKey];

      if (shows == null) {
        shows = await _fetchAngels(date, theater, next);
      }

      next(ReceivedAngelsAction(DateTheaterPair(date, theater), shows));
    } catch (e) {
      next(ErrorLoadingAngelsAction());
    }
  }

  Future<KtList<Angel>> _fetchAngels(
      DateTime currentDate, Theater newTheater, NextDispatcher next) async {
    final shows = await api.getSchedule(newTheater, currentDate);
    final now = Clock.getCurrentTime();

    // Return only show times that haven't started yet.
    return shows.filter((show) => show.start.isAfter(now));
  }

  Theater _getCorrectTheater(Store<AppState> store, dynamic action) {
    return action is InitCompleteAction || action is ChangeCurrentTheaterAction
        ? action.selectedTheater
        : store.state.theaterState.currentTheater;
  }

  DateTime _getCorrectDate(Store<AppState> store, dynamic action) {
    return action is ChangeCurrentDateAction
        ? action.date
        : store.state.showState.selectedDate;
  }
}
