import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class Profile {
  Profile({
    this.documentID,
    this.nickname,
    this.phoneNumber,
    this.description,
    this.thumbnailPath,
  });

  String documentID;
  String nickname;
  String phoneNumber;
  String description;
  String thumbnailPath;
  Timestamp created;

  void initialize(DocumentSnapshot snapshot) {
    this.documentID = snapshot.documentID;
    this.nickname = snapshot["nickname"];
    this.phoneNumber = snapshot["phoneNumber"];
    this.description = snapshot["description"];
    this.thumbnailPath = snapshot["thumbnailPath"];
    this.created = snapshot["created"];
  }

  Object data() {
    return {
      "documentID": documentID,
      "nickname": nickname,
      "phoneNumber": phoneNumber,
      "description": description,
      "thumbnailPath": thumbnailPath,
      'created': created,
      'lastUpdate': DateTime.now().millisecondsSinceEpoch,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Profile &&
          runtimeType == other.runtimeType &&
          documentID == other.documentID;

  @override
  int get hashCode => documentID.hashCode;

// Signed member.
  static Profile signedInstance = new Profile();
}
