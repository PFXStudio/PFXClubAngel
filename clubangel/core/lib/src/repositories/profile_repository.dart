import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/models/profile.dart';
import 'package:core/src/networking/target_server.dart';
import 'package:meta/meta.dart';

class ProfileRepository {
  // final Firestore _firestore;
  final CollectionReference _profileCollection;
  final FieldValue _firestoreTimestamp;
  static final String target = TargetServer().root();

  ProfileRepository()
      : _profileCollection =
            Firestore.instance.collection(target + "/account/profiles"),
        _firestoreTimestamp = FieldValue.serverTimestamp();

  Future<DocumentSnapshot> hasProfile({@required String userID}) async {
    return _profileCollection.document(userID).get();
  }

  Future<QuerySnapshot> getProfileFollowers({@required String userID}) {
    return _profileCollection
        .document(userID)
        .collection('followers')
        .getDocuments();
  }

  Future<QuerySnapshot> getProfileFollowing({@required String userID}) {
    return _profileCollection
        .document(userID)
        .collection('following')
        .getDocuments();
  }

  Future<DocumentSnapshot> fetchProfile({@required String userID}) {
    return _profileCollection.document(userID).get();
  }

  Future<bool> isLikeed(
      {@required String postID, @required String userID}) async {
    final DocumentSnapshot snapshot = await _profileCollection
        .document(userID)
        .collection('likes')
        .document(postID)
        .get();

    return snapshot.exists;
  }

  Future<void> addToLike({@required String postID, @required String userID}) {
    return _profileCollection
        .document(userID)
        .collection('likes')
        .document(postID)
        .setData({
      'isLikeed': true,
      'lastUpdate': _firestoreTimestamp,
    });
  }

  Future<void> removeFromLike(
      {@required String postID, @required String userID}) {
    return _profileCollection
        .document(userID)
        .collection('likes')
        .document(postID)
        .delete();
  }

  Future<bool> isFollowing(
      {@required String postUserId, @required String userID}) async {
    final DocumentSnapshot snapshot = await _profileCollection
        .document(userID)
        .collection('following')
        .document(postUserId)
        .get();

    return snapshot.exists;
  }

  Future<void> addToFollowing(
      {@required String postUserId, @required String userID}) {
    return _profileCollection
        .document(userID)
        .collection('following')
        .document(postUserId)
        .setData({'isFollowing': true});
  }

  Future<void> removeFromFollowing(
      {@required String postUserId, @required String userID}) {
    return _profileCollection
        .document(userID)
        .collection('following')
        .document(postUserId)
        .delete();
  }

  Future<bool> isFollower(
      {@required String postUserId, @required String userID}) async {
    final DocumentSnapshot snapshot = await _profileCollection
        .document(postUserId)
        .collection('followers')
        .document(userID)
        .get();

    return snapshot.exists;
  }

  Future<void> addToFollowers(
      {@required String postUserId, @required String userID}) {
    return _profileCollection
        .document(postUserId)
        .collection('followers')
        .document(userID)
        .setData({'isFollowing': true});
  }

  Future<void> removeFromFollowers(
      {@required String postUserId, @required String userID}) {
    return _profileCollection
        .document(postUserId)
        .collection('followers')
        .document(userID)
        .delete();
  }

  Future<QuerySnapshot> fetchLikedPosts({@required String userID}) {
    return _profileCollection
        .document(userID)
        .collection('likes')
        .orderBy('lastUpdate', descending: true)
        .getDocuments();
  }

  Future<void> updateProfile({
    @required String userID,
    @required Object data,
  }) {
    return _profileCollection.document(userID).setData(data, merge: true);
  }

  Future<QuerySnapshot> selectProfile({
    @required String nickname,
  }) async {
    Query query =
        _profileCollection.where('nickname', isEqualTo: nickname).limit(1);
    final QuerySnapshot querySnapshot = await query.getDocuments();
    if (querySnapshot.documents.length <= 0) {
      return null;
    }

    return querySnapshot;
  }
}
