import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class Member {
  Member({
    this.documentID,
    this.nickname,
    this.phoneNumber,
  });

  String documentID;
  String nickname;
  String phoneNumber;

  void initialize(DocumentSnapshot snapshot) {
    this.documentID = snapshot.documentID;
    this.nickname = snapshot["nickname"];
    this.phoneNumber = snapshot["phoneNumber"];
  }

  Object data() {
    return {
      "nickname": nickname,
      "phoneNumber": phoneNumber,
      "timestamp": DateTime.now().millisecondsSinceEpoch,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Member &&
          runtimeType == other.runtimeType &&
          documentID == other.documentID;

  @override
  int get hashCode => documentID.hashCode ^ nickname.hashCode;

  static Member memberInstance = new Member();
}
