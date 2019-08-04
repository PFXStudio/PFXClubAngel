import 'package:core/src/models/loading_status.dart';
import 'package:core/src/models/angel.dart';
import 'package:core/src/redux/app/app_state.dart';
import 'package:core/src/redux/angel/angel_actions.dart';
import 'package:core/src/redux/angel/angel_selectors.dart';
import 'package:kt_dart/collection.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class AngeltimesPageViewModel {
  AngeltimesPageViewModel({
    @required this.status,
    @required this.dates,
    @required this.selectedDate,
    @required this.shows,
    @required this.changeCurrentDate,
    @required this.refreshAngeltimes,
  });

  final LoadingStatus status;
  final KtList<DateTime> dates;
  final DateTime selectedDate;
  final KtList<Angel> shows;
  final Function(DateTime) changeCurrentDate;
  final Function refreshAngeltimes;

  static AngeltimesPageViewModel fromStore(Store<AppState> store) {
    return AngeltimesPageViewModel(
      selectedDate: store.state.showState.selectedDate,
      dates: store.state.showState.dates,
      status: store.state.showState.loadingStatus,
      shows: showsSelector(store.state),
      changeCurrentDate: (newDate) {
        store.dispatch(ChangeCurrentDateAction(newDate));
      },
      refreshAngeltimes: () => store.dispatch(RefreshAngelsAction()),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AngeltimesPageViewModel &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          dates == other.dates &&
          selectedDate == other.selectedDate &&
          shows == other.shows;

  @override
  int get hashCode =>
      status.hashCode ^ dates.hashCode ^ selectedDate.hashCode ^ shows.hashCode;
}
