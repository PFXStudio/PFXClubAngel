import 'package:core/src/models/board.dart';
import 'package:kt_dart/collection.dart';

class BoardEventsAction {
  BoardEventsAction(this.type);
  final BoardListType type;
}

class RequestingBoardsAction {
  RequestingBoardsAction(this.type);
  final BoardListType type;
}

class ReceivedInTheatersEventsAction {
  ReceivedInTheatersEventsAction(this.boards);
  final KtList<Board> boards;
}

class ReceivedComingSoonEventsAction {
  ReceivedComingSoonEventsAction(this.boards);
  final KtList<Board> boards;
}

class ErrorLoadingBoardsAction {
  ErrorLoadingBoardsAction(this.type);
  final BoardListType type;
}
