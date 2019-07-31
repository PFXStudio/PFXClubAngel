import 'package:core/src/models/actor.dart';
import 'package:core/src/models/board.dart';
import 'package:core/src/redux/app/app_state.dart';
import 'package:kt_dart/collection.dart';

KtList<Actor> actorsForEventSelector(AppState state, Board board) {
  return state.actorsByName.values
      .filter((actor) => board.actors.contains(actor));
}
