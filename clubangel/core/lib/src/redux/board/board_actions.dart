import 'package:core/src/models/board.dart';
import 'package:kt_dart/collection.dart';

class RefreshBoardsAction {
  RefreshBoardsAction(this.type);
  final BoardListType type;
}

class RequestingBoardsAction {
  RequestingBoardsAction(this.type);
  final BoardListType type;
}

class ErrorLoadingBoardsAction {
  ErrorLoadingBoardsAction(this.type);
  final BoardListType type;
}
