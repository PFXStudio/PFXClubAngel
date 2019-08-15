import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/models/import.dart';
import 'package:core/src/networking/target_server.dart';
import 'package:meta/meta.dart';

class FreeRepository {
  // final Firestore _firestore;
  final CollectionReference _postCollection;
  final FieldValue _firestoreTimestamp;
  static final String target = TargetServer().root();

  FreeRepository()
      : _postCollection = Firestore.instance.collection(target + "/free/posts"),
        _firestoreTimestamp = FieldValue.serverTimestamp();

  Future<bool> isLiked(
      {@required String postID, @required String userID}) async {
    final DocumentSnapshot snapshot = await _postCollection
        .document(postID)
        .collection('likes')
        .document(userID)
        .get();

    return snapshot.exists;
  }

  Future<void> addToLike({@required String postID, @required String userID}) {
    return _postCollection
        .document(postID)
        .collection('likes')
        .document(userID)
        .setData({
      'isBookmarked': true,
    });
  }

  Future<void> removeFromLike(
      {@required String postID, @required String userID}) {
    return _postCollection
        .document(postID)
        .collection('likes')
        .document(userID)
        .delete();
  }

  Future<DocumentSnapshot> getPost({@required String postID}) {
    return _postCollection.document(postID).get();
  }

  Future<QuerySnapshot> getPostLikes({@required String postID}) {
    return _postCollection.document(postID).collection('likes').getDocuments();
  }

  Future<QuerySnapshot> fetchPosts({@required Post lastVisiblePost}) {
    return lastVisiblePost == null
        ? _postCollection
            .orderBy('lastUpdate', descending: true)
            .limit(5)
            .getDocuments()
        : _postCollection
            .orderBy('lastUpdate', descending: true)
            .startAfter([lastVisiblePost.lastUpdate])
            .limit(5)
            .getDocuments();
  }

  Future<QuerySnapshot> fetchProfilePosts(
      {@required Post lastVisiblePost, @required String userID}) {
    return lastVisiblePost == null
        ? _postCollection
            .where('userID', isEqualTo: userID)
            .orderBy('lastUpdate', descending: true)
            .limit(5)
            .getDocuments()
        : _postCollection
            .where('userID', isEqualTo: userID)
            .orderBy('lastUpdate', descending: true)
            .startAfter([lastVisiblePost.lastUpdate])
            .limit(5)
            .getDocuments();
  }

  Future<DocumentReference> createPost({@required Post post}) {
    return _postCollection.add(post.data());
  }
}
