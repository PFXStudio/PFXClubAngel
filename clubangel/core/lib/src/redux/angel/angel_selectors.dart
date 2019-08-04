import 'package:core/src/models/board.dart';
import 'package:core/src/models/angel.dart';
import 'package:core/src/models/show_cache.dart';
import 'package:core/src/redux/app/app_state.dart';
import 'package:kt_dart/collection.dart';
import 'package:memoize/memoize.dart';
import 'package:reselect/reselect.dart';

Angel showByIdSelector(AppState state, String id) {
  return showsSelector(state).firstOrNull((show) => show.id == id) ??
      _findFromAllAngels(state, id);
}

/// Selects a list of shows based on the currently selected date and theater.
///
/// If the current AppState contains a search query, returns only shows that match
/// that search query. Otherwise returns all matching shows for current theater
/// and date.
final showsSelector = createSelector3<AppState, DateTheaterPair,
    KtMap<DateTheaterPair, KtList<Angel>>, String, KtList<Angel>>(
  (state) => DateTheaterPair.fromState(state),
  (state) => state.showState.shows,
  (state) => state.searchQuery,
  (key, KtMap<DateTheaterPair, KtList<Angel>> shows, searchQuery) {
    KtList<Angel> matchingAngels = shows.getOrDefault(key, emptyList<Angel>());
    if (searchQuery == null) {
      return matchingAngels;
    } else {
      return _showsWithSearchQuery(matchingAngels, searchQuery);
    }
  },
);

final showsForEventSelector =
    memo2<KtList<Angel>, Board, KtList<Angel>>((shows, board) {
  return shows.filter((show) => show.originalTitle == board.originalTitle);
});

KtList<Angel> _showsWithSearchQuery(KtList<Angel> shows, String searchQuery) {
  final searchQueryPattern = new RegExp(searchQuery, caseSensitive: false);

  return shows.filter((show) =>
      show.title.contains(searchQueryPattern) ||
      show.originalTitle.contains(searchQueryPattern));
}

/// Goes through the list of showtimes for every single theater.
///
/// Skips all memoization and searches for correct show time through all shows
/// instead of shows specific to current theater and date. Used as a fallback
/// when [showByIdSelector] fails.
Angel _findFromAllAngels(AppState state, String id) {
  final allAngels = state.showState.shows.values;
  return allAngels
      .firstOrNull(
          (shows) => shows.firstOrNull((show) => show.id == id) != null)
      ?.firstOrNull();
}
