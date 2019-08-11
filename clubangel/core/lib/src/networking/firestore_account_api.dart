import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/models/member.dart';
import 'package:intl/intl.dart';
import 'package:kt_dart/kt.dart';

class FirestoreAccountApi {
  static final ddMMyyyy = DateFormat('dd.MM.yyyy');
  FirestoreAccountApi();

  Firestore firestore = Firestore.instance;
  Future<Member> selectMemeber(String phoneNumber) async {
    firestore
        .collection("dev/account/members")
        .where("phoneNumber", isEqualTo: phoneNumber)
        .snapshots()
        .listen((data) async {
      if (data.documents.length <= 0) {
        return null;
      }

      Member member = Member();
      member.initialize(data.documents.first);
      return member;
    });

    return null;
  }

  Future<Member> selectNickname(String nickname) async {
    firestore
        .collection("dev/account/members")
        .where("nickname", isEqualTo: nickname)
        .snapshots()
        .listen((data) async {
      if (data.documents.length <= 0) {
        return null;
      }

      Member member = Member();
      member.initialize(data.documents.first);
      return member;
    });

    return null;
  }

  Future<Member> updateMember(Member member) {
    firestore
        .collection("dev/account/members")
        .document(Member.memberInstance.documentID)
        .updateData(member.data());
  }

  Future<DocumentReference> insertMember(String phoneNumber) async {
    firestore.collection("dev/account/members").add({
      "phoneNumber": phoneNumber,
      "timestamp": DateTime.now().millisecondsSinceEpoch
    }).then((result) {
      String documentID = result.documentID;
      if (documentID == null) {
        return null;
      }

      return result;
    });

    return null;
  }
}
