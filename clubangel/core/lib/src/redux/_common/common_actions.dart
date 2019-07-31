import 'package:core/core.dart';
import 'package:core/src/models/actor.dart';
import 'package:core/src/models/board.dart';
import 'package:core/src/models/theater.dart';
import 'package:kt_dart/collection.dart';

class InitAction {}

class InitCompleteAction {
  InitCompleteAction(
    this.theaters,
    this.selectedTheater,
  );

  final KtList<Theater> theaters;
  final Theater selectedTheater;
}

class FetchComingSoonEventsIfNotLoadedAction {}

class ChangeCurrentTheaterAction {
  ChangeCurrentTheaterAction(this.selectedTheater);
  final Theater selectedTheater;
}

class UpdateActorsForEventAction {
  UpdateActorsForEventAction(this.board, this.actors);

  final Board board;
  final KtList<Actor> actors;
}
