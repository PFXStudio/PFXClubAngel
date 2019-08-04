import 'package:core/src/models/board.dart';
import 'package:core/src/models/angel.dart';
import 'package:core/src/redux/app/app_state.dart';
import 'package:kt_dart/collection.dart';
import 'package:reselect/reselect.dart';

final nowInTheatersSelector = createSelector2(
  (AppState state) => state.boardState.nowInTheatersEvents,
  (AppState state) => state.searchQuery,
  _eventsOrEventSearch,
);

final comingSoonSelector = createSelector2(
  (AppState state) => state.boardState.comingSoonEvents,
  (AppState state) => state.searchQuery,
  _eventsOrEventSearch,
);

Board boardByIdSelector(AppState state, String id) {
  final predicate = (board) => board.id == id;
  return nowInTheatersSelector(state).firstOrNull(predicate) ??
      comingSoonSelector(state).firstOrNull(predicate);
}

Board boardForShowSelector(AppState state, Angel show) {
  return state.boardState.nowInTheatersEvents
      .filter((board) => board.id == show.eventId)
      .first();
}

KtList<Board> _eventsOrEventSearch(KtList<Board> boards, String searchQuery) {
  return searchQuery == null
      ? _uniqueEvents(boards)
      : _eventsWithSearchQuery(boards, searchQuery);
}

/// Since Finnkino XML API considers "The Grinch" and "The Grinch 2D" to be two
/// completely different events, we might get a lot of duplication. We have to
/// do this hack because it is quite boring to display four movie posters that
/// are exactly the same.
KtList<Board> _uniqueEvents(KtList<Board> original) {
  return original
      // reverse because last unique key wins
      .reversed()
      .associateBy((board) => board.originalTitle)
      .values
      .reversed();
}

KtList<Board> _eventsWithSearchQuery(
    KtList<Board> original, String searchQuery) {
  final searchQueryPattern = RegExp(searchQuery, caseSensitive: false);

  return original.filter((board) {
    return board.title.contains(searchQueryPattern) ||
        board.originalTitle.contains(searchQueryPattern);
  });
}
