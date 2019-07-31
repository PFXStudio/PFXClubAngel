import 'package:core/src/models/actor.dart';
import 'package:core/src/models/board.dart';
import 'package:kt_dart/collection.dart';

class FetchActorAvatarsAction {
  FetchActorAvatarsAction(this.board);
  final Board board;
}

class ActorsUpdatedAction {
  ActorsUpdatedAction(this.actors);
  final KtList<Actor> actors;
}

class ReceivedActorAvatarsAction {
  ReceivedActorAvatarsAction(this.actors);
  final KtList<Actor> actors;
}
