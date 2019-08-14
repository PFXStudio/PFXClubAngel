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

  Future<DocumentSnapshot> hasProfile({@required String documentID}) async {
    return _profileCollection.document(documentID).get();
  }

  Future<void> createProfile({
    @required Profile profile,
  }) {
    return _profileCollection
        .document(profile.documentID)
        .setData(profile.data(), merge: true);
  }
}
