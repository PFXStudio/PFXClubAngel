import 'package:core/src/models/show.dart';
import 'package:core/src/redux/app/app_state.dart';
import 'package:kt_dart/collection.dart';
import 'package:reselect/reselect.dart';

import '../../../core.dart';

final nowInTheatersSelector = createSelector2(
  (AppState state) => state.eventState.nowInTheatersEvents,
  (AppState state) => state.searchQuery,
  _eventsOrEventSearch,
);

final comingSoonSelector = createSelector2(
  (AppState state) => state.eventState.comingSoonEvents,
  (AppState state) => state.searchQuery,
  _eventsOrEventSearch,
);

Board eventByIdSelector(AppState state, String id) {
  final predicate = (event) => event.id == id;
  return nowInTheatersSelector(state).firstOrNull(predicate) ??
      comingSoonSelector(state).firstOrNull(predicate);
}

Board eventForShowSelector(AppState state, Show show) {
  return state.eventState.nowInTheatersEvents
      .filter((event) => event.id == show.eventId)
      .first();
}

KtList<Board> _eventsOrEventSearch(KtList<Board> events, String searchQuery) {
  return searchQuery == null
      ? _uniqueEvents(events)
      : _eventsWithSearchQuery(events, searchQuery);
}

/// Since Finnkino XML API considers "The Grinch" and "The Grinch 2D" to be two
/// completely different events, we might get a lot of duplication. We have to
/// do this hack because it is quite boring to display four movie posters that
/// are exactly the same.
KtList<Board> _uniqueEvents(KtList<Board> original) {
  return original
      // reverse because last unique key wins
      .reversed()
      .associateBy((event) => event.originalTitle)
      .values
      .reversed();
}

KtList<Board> _eventsWithSearchQuery(
    KtList<Board> original, String searchQuery) {
  final searchQueryPattern = RegExp(searchQuery, caseSensitive: false);

  return original.filter((event) {
    return event.title.contains(searchQueryPattern) ||
        event.originalTitle.contains(searchQueryPattern);
  });
}
