import 'package:core/src/models/loading_status.dart';
import 'package:core/src/redux/_common/common_actions.dart';
import 'package:core/src/redux/angel/angel_actions.dart';
import 'package:core/src/redux/angel/angel_state.dart';

AngelState showReducer(AngelState state, dynamic action) {
  if (action is ChangeCurrentTheaterAction) {
    return state.copyWith(selectedDate: state.dates.first());
  } else if (action is ChangeCurrentDateAction) {
    return state.copyWith(selectedDate: action.date);
  } else if (action is RequestingAngelsAction) {
    return state.copyWith(loadingStatus: LoadingStatus.loading);
  } else if (action is ReceivedAngelsAction) {
    final newAngels = state.shows.toMutableMap();
    newAngels[action.cacheKey] = action.shows;

    return state.copyWith(
      loadingStatus: LoadingStatus.success,
      shows: newAngels,
    );
  } else if (action is ErrorLoadingAngelsAction) {
    return state.copyWith(loadingStatus: LoadingStatus.error);
  } else if (action is AngelDatesUpdatedAction) {
    return state.copyWith(
      availableDates: action.dates,
      selectedDate: action.dates.first(),
    );
  }

  return state;
}
