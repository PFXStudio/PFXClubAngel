import 'package:core/src/redux/_common/search.dart';
import 'package:core/src/redux/actor/actor_reducer.dart';
import 'package:core/src/redux/app/app_state.dart';
import 'package:core/src/redux/board/board_reducer.dart';
import 'package:core/src/redux/angel/angel_reducer.dart';
import 'package:core/src/redux/theater/theater_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return new AppState(
    searchQuery: searchQueryReducer(state.searchQuery, action),
    actorsByName: actorReducer(state.actorsByName, action),
    theaterState: theaterReducer(state.theaterState, action),
    showState: showReducer(state.showState, action),
    boardState: boardReducer(state.boardState, action),
  );
}
