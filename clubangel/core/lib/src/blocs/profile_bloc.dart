import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/blocs/import.dart';
import 'package:core/src/models/profile.dart';
import 'package:core/src/repositories/import.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

enum ProfileState { Default, Loading, Success, Failure }

class ProfileBloc with ChangeNotifier {
  final ProfileRepository _profileRepository;
  final ImageRepository _imageRepository;
  final AuthBloc _authBloc;

  Asset _profileImage;

  ProfileState _profileState = ProfileState.Default;

  ProfileBloc.instance()
      : _profileRepository = ProfileRepository(),
        _imageRepository = ImageRepository(),
        _authBloc = AuthBloc.instance();

  // getters
  Future<bool> get hasProfile async {
    final String documentID = await _authBloc.getUser;
    final DocumentSnapshot snapshot =
        await _profileRepository.hasProfile(documentID: documentID);

    if (snapshot.data == null) {
      return false;
    }
    String nickname = snapshot.data["nickname"];
    return nickname.length > 0 ? true : false;
  }

  Asset get profileImage => _profileImage;

  ProfileState get profileState => _profileState;

  // setters
  void setProfileImage({@required Asset profileImage}) {
    _profileImage = profileImage;
    notifyListeners();
  }

  Future<bool> createProfile({
    @required Profile profile,
  }) async {
    try {
      _profileState = ProfileState.Loading;
      notifyListeners();

      profile.documentID = await _authBloc.getUser;
      profile.thumbnailPath = await _imageRepository.saveProfileImage(
          userId: profile.documentID, asset: profileImage);

      await _profileRepository.createProfile(profile: profile);

      // await Future.delayed(Duration(seconds: 5));

      _profileState = ProfileState.Success;
      notifyListeners();

      return true;
    } catch (e) {
      print(e.toString());

      _profileState = ProfileState.Failure;
      notifyListeners();
      return false;
    }
  }
}
