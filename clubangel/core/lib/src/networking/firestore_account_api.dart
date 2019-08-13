import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/models/member.dart';
import 'package:core/src/networking/target_server.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:kt_dart/kt.dart';

class FirestoreAccountApi {
  static final ddMMyyyy = DateFormat('dd.MM.yyyy');
  static final String target = TargetServer().root();
  FirestoreAccountApi();

  Firestore firestore = Firestore.instance;
  void selectMemeber(String phoneNumber, Function(Member) successCallback,
      Function(FlutterError) errorCallback) async {
    firestore
        .collection(target + "/account/members")
        .where("phoneNumber", isEqualTo: phoneNumber)
        .snapshots()
        .listen((data) async {
      if (data.documents.length <= 0) {
        successCallback(null);
        return;
      }

      if (data.documents.length != 1) {
        // duplicate member
        errorCallback(FlutterError("E00000"));
        return;
      }

      Member member = Member();
      member.initialize(data.documents.first);
      successCallback(member);
    }).onError((error) {
      errorCallback(FlutterError("E00000"));
    });
  }

  void selectNickname(String nickname, Function(Member) successCallback,
      Function(FlutterError) errorCallback) async {
    firestore
        .collection(target + "/account/members")
        .where("nickname", isEqualTo: nickname)
        .snapshots()
        .listen((data) async {
      if (data.documents.length <= 0) {
        successCallback(null);
        return;
      }

      Member member = Member();
      member.initialize(data.documents.first);
      successCallback(member);
    }).onError((error) {
      errorCallback(FlutterError("E00000"));
    });
  }

  void updateMember(Member member, Function() successCallback,
      Function(FlutterError) errorCallback) async {
    firestore
        .collection(target + "/account/members")
        .document(Member.signedInstance.documentID)
        .updateData(member.data())
        .then((result) {
      successCallback();
    }).catchError((error) {
      errorCallback(FlutterError("E00000"));
    });
  }

  void insertMember(
      String phoneNumber,
      Function(DocumentReference) successCallback,
      Function(FlutterError) errorCallback) async {
    firestore.collection(target + "/account/members").add({
      "phoneNumber": phoneNumber,
      "timestamp": DateTime.now().millisecondsSinceEpoch
    }).then((result) {
      successCallback(result);
    }).catchError((error) {
      errorCallback(FlutterError("E00000"));
    });
  }
}
