import 'package:core/src/models/angel.dart';
import 'package:core/src/models/show_cache.dart';
import 'package:kt_dart/collection.dart';

class UpdateAngelDatesAction {}

class AngelDatesUpdatedAction {
  AngelDatesUpdatedAction(this.dates);
  final KtList<DateTime> dates;
}

class FetchAngelsIfNotLoadedAction {}

class RequestingAngelsAction {}

class RefreshAngelsAction {}

class ReceivedAngelsAction {
  ReceivedAngelsAction(this.cacheKey, this.shows);
  final DateTheaterPair cacheKey;
  final KtList<Angel> shows;
}

class ErrorLoadingAngelsAction {}

class ChangeCurrentDateAction {
  ChangeCurrentDateAction(this.date);
  final DateTime date;
}
