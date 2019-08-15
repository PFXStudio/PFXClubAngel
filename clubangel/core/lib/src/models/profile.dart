import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class Profile {
  Profile({
    this.userID,
    this.nickname,
    this.phoneNumber,
    this.description,
    this.thumbnailUrl,
    this.created,
    this.isFollowing,
    this.followersCount,
  });

  String userID;
  String nickname;
  String phoneNumber;
  String description;
  String thumbnailUrl;
  int created;
  // other database.
  bool isFollowing = false;
  int followersCount = 0;

  void initialize(DocumentSnapshot snapshot) {
    this.userID = snapshot.documentID;
    this.nickname = snapshot["nickname"];
    this.phoneNumber = snapshot["phoneNumber"];
    this.description = snapshot["description"];
    this.thumbnailUrl = snapshot["thumbnailUrl"];
    this.created = snapshot["created"];
  }

  Object data() {
    return {
      "userID": userID,
      "nickname": nickname,
      "phoneNumber": phoneNumber,
      "description": description,
      "thumbnailUrl": thumbnailUrl,
      'created': created,
      'lastUpdate': DateTime.now().millisecondsSinceEpoch,
    };
  }

  Profile copyWith(
      {String userID,
      String nickname,
      String phoneNumber,
      String description,
      String thumbnailUrl,
      int created,
      // other database.
      bool isFollowing,
      int followersCount}) {
    return Profile(
      userID: userID ?? this.userID,
      nickname: nickname ?? this.nickname,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      description: description ?? this.description,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      created: created ?? this.created,
      isFollowing: isFollowing ?? this.isFollowing,
      followersCount: followersCount ?? this.followersCount,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Profile &&
          runtimeType == other.runtimeType &&
          userID == other.userID;

  @override
  int get hashCode => userID.hashCode;
}
