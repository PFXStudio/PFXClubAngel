import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/blocs/import.dart';
import 'package:core/src/models/import.dart';
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
  Profile _postProfile;
  Profile _userProfile;
  List<Profile> _profileFollowing;

  ProfileState _profileState = ProfileState.Default;
  ProfileState _profileFollowingState = ProfileState.Default;
  ProfileState _postProfileState = ProfileState.Default;

  ProfileBloc.instance()
      : _profileRepository = ProfileRepository(),
        _imageRepository = ImageRepository(),
        _authBloc = AuthBloc.instance() {
    fetchUserProfile();
  }

  // getters
  Future<bool> get hasProfile async {
    final String _userID = await _authBloc.getUser;
    final DocumentSnapshot _snapshot =
        await _profileRepository.hasProfile(userID: _userID);

    if (_snapshot.exists == false) {
      return false;
    }

    String nickname = _snapshot.data["nickname"];
    if (nickname == null || nickname.length <= 0) {
      return false;
    }

    return true;
  }

  Asset get profileImage => _profileImage;
  Profile get postProfile => _postProfile;
  Profile get userProfile => _userProfile;
  List<Profile> get profileFollowing => _profileFollowing;

  ProfileState get profileState => _profileState;
  ProfileState get profileFollowingState => _profileFollowingState;
  ProfileState get postProfileState => _postProfileState;

  // setters
  void setProfileImage({@required Asset profileImage}) {
    _profileImage = profileImage;
    notifyListeners();
  }

  void setProfile({@required Profile postProfile}) {
    _postProfile = postProfile;
    notifyListeners();
  }

  void setUserProfile({@required Profile userProfile}) {
    _userProfile = userProfile;
    notifyListeners();
  }

  Future<void> togglePostLikeStatus(
      {@required Post post, @required String userID}) async {
    final bool _likeStatus = post.isLiked;
    final bool _newLikeStatus = !_likeStatus;

    final String _postID = post.postID;

    try {
      if (_newLikeStatus) {
        await _profileRepository.addToLike(postID: _postID, userID: userID);
        print('Likeed user');
      } else {
        await _profileRepository.removeFromLike(
            postID: _postID, userID: userID);
        print('Not Likeed user');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> toggleFollowProfilePageStatus(
      {@required Profile profile}) async {
    // final String _profileId = profile.userID;
    final String _userID = await _authBloc.getUser;

    final String _postUserId = profile.userID;

    final bool _followingStatus = profile.isFollowing;
    final bool _newFollowingStatus = !_followingStatus;

    // final Profile _updatedProfile =
    //     profile.copyWith(isFollowing: _newFollowingStatus);

    // if (_newFollowingStatus) {
    //   _profileFollowing.insert(0, _updatedProfile);
    // } else {
    //   _profileFollowing
    //       .removeWhere((Profile following) => following.userID == _profileId);
    // }
    // notifyListeners();

    try {
      if (_newFollowingStatus) {
        await _profileRepository.addToFollowing(
            postUserId: _postUserId, userID: _userID);
        print('Following user');
      } else {
        await _profileRepository.removeFromFollowing(
            postUserId: _postUserId, userID: _userID);
        print('Not Following user');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Profile> _fetchFollowingProfile(
      {@required String postUserId, @required String currentUserId}) async {
    DocumentSnapshot _snapshot =
        await _profileRepository.fetchProfile(userID: postUserId);

    final Profile _postProfile = Profile();
    _postProfile.initialize(_snapshot);

    // get post user following status for current user
    final bool _isFollowing = await _profileRepository.isFollowing(
        postUserId: postUserId, userID: currentUserId);

    // get follower count
    final QuerySnapshot snapshot =
        await _profileRepository.getProfileFollowers(userID: postUserId);
    final int _profileFollowersCount = snapshot.documents.length;
    return _postProfile.copyWith(
        followersCount: _profileFollowersCount, isFollowing: _isFollowing);
  }

  Future<void> fetchUserProfileFollowing() async {
    try {
      _profileFollowingState = ProfileState.Loading;
      notifyListeners();

      final String _userID = await _authBloc.getUser;

      final QuerySnapshot _snapshot =
          await _profileRepository.getProfileFollowing(userID: _userID);

      final List<Profile> profile = [];

      print('Snapshot lenght ${_snapshot.documents.length}');

      for (int i = 0; i < _snapshot.documents.length; i++) {
        final DocumentSnapshot document = _snapshot.documents[i];
        final String _profileId = document.documentID;
        final Profile _profile = await _fetchFollowingProfile(
            postUserId: _profileId, currentUserId: _userID);

        profile.add(_profile);
      }

      _profileFollowing = profile;
      _profileFollowingState = ProfileState.Success;
      notifyListeners();

      return;
    } catch (e) {
      print(e.toString());

      _profileFollowingState = ProfileState.Failure;
      notifyListeners();
      return;
    }
  }

  Future<void> fetchUserProfile() async {
    try {
      // _userProfileState = ProfileState.Loading;
      // notifyListeners();

      final String _userID = await _authBloc.getUser;
      DocumentSnapshot _snapshot =
          await _profileRepository.fetchProfile(userID: _userID);

      if (!_snapshot.exists) {
        print('UserId do not exit');
        return;
      }

      final Profile _userProfile = Profile();
      _userProfile.initialize(_snapshot);

      final QuerySnapshot snapshot =
          await _profileRepository.getProfileFollowers(userID: _userID);
      final int _userProfileFollowersCount = snapshot.documents.length;
      setUserProfile(
          userProfile: _userProfile.copyWith(
              followersCount: _userProfileFollowersCount));

      return;
    } catch (e) {
      print(e.toString());

      // _userProfileState = ProfileState.Failure;
      // notifyListeners();
      return;
    }
  }

  Future<bool> fetchProfile({@required String userID}) async {
    try {
      _postProfileState = ProfileState.Loading;
      notifyListeners();

      DocumentSnapshot _snapshot =
          await _profileRepository.fetchProfile(userID: userID);

      if (!_snapshot.exists) {
        print('UserId do not exit');
        return true;
      }

      final Profile _postProfile = Profile();
      _postProfile.initialize(_snapshot);
      // get follower count
      final QuerySnapshot snapshot =
          await _profileRepository.getProfileFollowers(userID: userID);
      final int _profileFollowersCount = snapshot.documents.length;
      setProfile(
          postProfile:
              _postProfile.copyWith(followersCount: _profileFollowersCount));

      _postProfileState = ProfileState.Success;
      notifyListeners();
      return true;
    } catch (e) {
      print(e.toString());

      _postProfileState = ProfileState.Failure;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateProfile(
      {@required Profile profile, Asset thumbnailImage}) async {
    try {
      _profileState = ProfileState.Loading;
      notifyListeners();

      final String _userID = await _authBloc.getUser;

      final String _thumbnailUrl = await _imageRepository.saveProfileImage(
          userID: _userID, asset: thumbnailImage);

      profile.thumbnailUrl = _thumbnailUrl;

      await _profileRepository.updateProfile(
          userID: _userID, data: profile.data());

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

  Future<Profile> selectProfile({@required String nickname}) async {
    var querySnapshot =
        await _profileRepository.selectProfile(nickname: nickname);
    if (querySnapshot == null) {
      return null;
    }

    Profile profile = Profile();
    profile.initialize(querySnapshot.documents.first);

    return profile;
  }
}
