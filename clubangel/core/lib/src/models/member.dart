import 'package:meta/meta.dart';

class Member {
  Member({
    @required this.identifier,
    @required this.nickname,
    this.avatarThumbnailUrl,
    this.avatarUrl,
  });

  final String identifier;
  final String nickname;
  final String avatarThumbnailUrl;
  final String avatarUrl;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Member &&
              runtimeType == other.runtimeType &&
              identifier == other.identifier;

  @override
  int get hashCode =>
      identifier.hashCode ^
      nickname.hashCode;
}
