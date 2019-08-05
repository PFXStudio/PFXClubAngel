import 'package:meta/meta.dart';

class Comment {
  Comment({
    @required this.identifier,
    @required this.memberIdentifier,
    this.message,
    this.messageThumbnailUrl,
    this.messageImageUrl,
    this.replyMessage,
    this.warningCount,
    this.likeCount,
    this.dateTime,
  });

  final String identifier;
  final String memberIdentifier;
  final String message;
  final String messageThumbnailUrl;
  final String messageImageUrl;
  final String replyMessage;
  final int warningCount;
  final int likeCount;
  final DateTime dateTime;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Comment &&
              runtimeType == other.runtimeType &&
              identifier == other.identifier;

  @override
  int get hashCode =>
      identifier.hashCode ^
      memberIdentifier.hashCode;
}
