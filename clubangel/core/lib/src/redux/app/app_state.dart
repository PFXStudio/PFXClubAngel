import 'package:core/src/models/actor.dart';
import 'package:core/src/redux/board/board_state.dart';
import 'package:core/src/redux/angel/angel_state.dart';
import 'package:core/src/redux/theater/theater_state.dart';
import 'package:kt_dart/collection.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  AppState({
    @required this.searchQuery,
    @required this.actorsByName,
    @required this.theaterState,
    @required this.showState,
    @required this.boardState,
  });

  final String searchQuery;
  final KtMap<String, Actor> actorsByName;
  final TheaterState theaterState;
  final AngelState showState;
  final BoardState boardState;

  factory AppState.initial() {
    return AppState(
      searchQuery: null,
      actorsByName: emptyMap(),
      theaterState: TheaterState.initial(),
      showState: AngelState.initial(),
      boardState: BoardState.initial(),
    );
  }

  AppState copyWith({
    String searchQuery,
    KtMap<String, Actor> actorsByName,
    TheaterState theaterState,
    AngelState showState,
    BoardState boardState,
  }) {
    return AppState(
      searchQuery: searchQuery ?? this.searchQuery,
      actorsByName: actorsByName ?? this.actorsByName,
      theaterState: theaterState ?? this.theaterState,
      showState: showState ?? this.showState,
      boardState: boardState ?? this.boardState,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          searchQuery == other.searchQuery &&
          actorsByName == other.actorsByName &&
          theaterState == other.theaterState &&
          showState == other.showState &&
          boardState == other.boardState;

  @override
  int get hashCode =>
      searchQuery.hashCode ^
      actorsByName.hashCode ^
      theaterState.hashCode ^
      showState.hashCode ^
      boardState.hashCode;
}
