import 'package:core/src/models/board.dart';
import 'package:core/src/models/loading_status.dart';
import 'package:kt_dart/collection.dart';
import 'package:meta/meta.dart';

@immutable
class BoardState {
  BoardState({
    @required this.nowInTheatersStatus,
    @required this.nowInTheatersEvents,
    @required this.comingSoonStatus,
    @required this.comingSoonEvents,
  });

  final LoadingStatus nowInTheatersStatus;
  final KtList<Board> nowInTheatersEvents;
  final LoadingStatus comingSoonStatus;
  final KtList<Board> comingSoonEvents;

  factory BoardState.initial() {
    return BoardState(
      nowInTheatersStatus: LoadingStatus.idle,
      nowInTheatersEvents: emptyList(),
      comingSoonStatus: LoadingStatus.idle,
      comingSoonEvents: emptyList(),
    );
  }

  BoardState copyWith({
    LoadingStatus nowInTheatersStatus,
    KtList<Board> nowInTheatersEvents,
    LoadingStatus comingSoonStatus,
    KtList<Board> comingSoonEvents,
  }) {
    return BoardState(
      nowInTheatersStatus: nowInTheatersStatus ?? this.nowInTheatersStatus,
      comingSoonStatus: comingSoonStatus ?? this.comingSoonStatus,
      nowInTheatersEvents: nowInTheatersEvents ?? this.nowInTheatersEvents,
      comingSoonEvents: comingSoonEvents ?? this.comingSoonEvents,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BoardState &&
          runtimeType == other.runtimeType &&
          nowInTheatersStatus == other.nowInTheatersStatus &&
          comingSoonStatus == other.comingSoonStatus &&
          nowInTheatersEvents == other.nowInTheatersEvents &&
          comingSoonEvents == other.comingSoonEvents;

  @override
  int get hashCode =>
      nowInTheatersStatus.hashCode ^
      comingSoonStatus.hashCode ^
      nowInTheatersEvents.hashCode ^
      comingSoonEvents.hashCode;
}
