import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/blocs/import.dart';
import 'package:core/src/models/import.dart';
import 'package:core/src/models/profile.dart';
import 'package:core/src/repositories/import.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

enum PostState { Default, Loading, Success, Failure }

class FreeBloc with ChangeNotifier {
  final AuthBloc _authBloc;
  final FreeRepository _postRepository;
  final ProfileRepository _profileRepository;
  final ProfileBloc _profileBloc;
  final ImageRepository _imageRepository;

  PostState _postState = PostState.Default;
  PostState _likePostState = PostState.Default;
  PostState _profilePostState = PostState.Default;

  List<Post> _posts = [];
  List<Post> _likedPosts = [];
  List<Post> _profilePosts = [];

  bool _morePostsAvailable = true;
  bool _fetchingMorePosts = false;

  bool _moreProfilePostsAvailable = true;
  bool _fetchingMoreProfilePosts = false;

  FreeBloc.instance()
      : _postRepository = FreeRepository(),
        _profileRepository = ProfileRepository(),
        _profileBloc = ProfileBloc.instance(),
        _imageRepository = ImageRepository(),
        _authBloc = AuthBloc.instance() {
    fetchPosts();
  }

  PostState get postState => _postState;
  PostState get likePostState => _likePostState;
  PostState get profilePostState => _profilePostState;

  List<Post> get posts => _posts;
  List<Post> get profilePosts => _profilePosts;

  bool get morePostsAvailable => _morePostsAvailable;
  bool get fetchingMorePosts => _fetchingMorePosts;

  bool get moreProfilePostsAvailable => _moreProfilePostsAvailable;
  bool get fetchingMoreProfilePosts => _fetchingMoreProfilePosts;

  // methods
  Future<List<String>> _uploadPostImage(
      {@required String userID, @required List<Asset> assets}) async {
    try {
      final String fileLocation = '$userID/posts';

      final List<String> imageUrls = await _imageRepository.uploadPostImages(
          fileLocation: fileLocation, assets: assets);

      print('Image uploaded ${imageUrls.toList()}');
      return imageUrls;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Post> _getLikePost({String postID}) async {
    final String _currentUserId = await _authBloc.getUser; // get current-user

    DocumentSnapshot _document = await _postRepository.getPost(postID: postID);

    print('Get likePost');

    final String _postID = _document.documentID;
    final String _userID = _document.data['userID'];

    await _profileBloc.fetchProfile(userID: _userID);

    final Profile _profile =
        _profileBloc.postProfile; // fetch user for current post

    final Post _post = Post();
    _post.initialize(_document);

    // get post like status for current user
    final bool _isLiked =
        await _postRepository.isLiked(postID: _postID, userID: _currentUserId);

    // get post user following status for current user
    final bool _isFollowing = await _profileRepository.isFollowing(
        postUserId: _userID, userID: _currentUserId);

    // get post like count
    QuerySnapshot _snapshot =
        await _postRepository.getPostLikes(postID: _postID);
    final int _postLikeCount = _snapshot.documents.length;
    return _post.copyWith(
        isLiked: _isLiked,
        likeCount: _postLikeCount,
        profile: _profile.copyWith(isFollowing: _isFollowing));
  }

  Future<Post> _getPost({DocumentSnapshot document}) async {
    final String _currentUserId = await _authBloc.getUser; // get current-user

    DocumentSnapshot _document = document;

    final String _postID = _document.documentID;
    final String _userID = _document.data['userID'];

    await _profileBloc.fetchProfile(
        userID: _userID); // fetch user for current post

    final Profile _profile = _profileBloc.postProfile;

    final Post _post = Post();
    _post.initialize(document);

    // get post like status for current user
    final bool _isLiked =
        await _postRepository.isLiked(postID: _postID, userID: _currentUserId);

    // get post user following status for current user
    final bool _isFollowing = await _profileRepository.isFollowing(
        postUserId: _userID, userID: _currentUserId);

    // get post like count
    QuerySnapshot _snapshot =
        await _postRepository.getPostLikes(postID: _postID);
    final int _postLikeCount = _snapshot.documents.length;
    return _post.copyWith(
        isLiked: _isLiked,
        likeCount: _postLikeCount,
        profile: _profile.copyWith(isFollowing: _isFollowing));
  }

  Future<void> toggleLikeStatus({@required Post post}) async {
    final Post _recievedPost = post;

    final bool _likeStatus = _recievedPost.isLiked;
    final bool _newLikeStatus = !_likeStatus;

    final String _userID = await _authBloc.getUser;
    final String _postID = _recievedPost.postID;

    final int _updatedLikeCount = _newLikeStatus
        ? _recievedPost.likeCount + 1
        : _recievedPost.likeCount - 1;

    final Post _updatedPost = _recievedPost.copyWith(
        isLiked: _newLikeStatus,
        likeCount: _updatedLikeCount); // update like status

    // get post index in _posts;
    final int _postIndex =
        _posts.indexWhere((Post post) => post.postID == _postID);

    if (_postIndex != -1) {
      _posts[_postIndex] =
          _updatedPost; // update post in List<post> (optimistic update) in _posts
    }

    final int _profilePostIndex = _profilePosts.indexWhere((Post post) =>
        post.postID == _postID); // get post index in _profilePosts;

    if (_profilePostIndex != -1) {
      _profilePosts[_profilePostIndex] =
          _updatedPost; // update post in List<post> (optimistic update) in _profilePost
    }

    // update post in List<post> (optimistic update) in _likedPosts
    if (_newLikeStatus) {
      _likedPosts.insert(0, _updatedPost);
    } else {
      _likedPosts.removeWhere((Post likedPost) => likedPost.postID == _postID);
    }
    notifyListeners();

    try {
      if (_newLikeStatus) {
        await _postRepository.addToLike(postID: _postID, userID: _userID);
      } else {
        await _postRepository.removeFromLike(postID: _postID, userID: _userID);
      }

      // set post like in user collection
      await _profileBloc.togglePostLikeStatus(post: post, userID: _userID);

      return;
    } catch (e) {
      print(e.toString());

      final int _updatedLikeCount = !_newLikeStatus
          ? _recievedPost.likeCount + 1
          : _recievedPost.likeCount - 1;

      final Post _updatedPost = _recievedPost.copyWith(
          isLiked: !_newLikeStatus, likeCount: _updatedLikeCount);

      if (_postIndex != -1) {
        _posts[_postIndex] = _updatedPost;
      }

      if (_profilePostIndex != -1) {
        _profilePosts[_profilePostIndex] =
            _updatedPost; // update post in List<post> (optimistic update) in _profilePost
      }

      if (_newLikeStatus) {
        _likedPosts
            .removeWhere((Post likedPost) => likedPost.postID == _postID);
      } else {
        _likedPosts.insert(0, _updatedPost);
      }
      notifyListeners();
    }
  }

  Future<void> toggleFollowProfilePageStatus(
      {@required Profile currentPostProfile}) async {
    final Profile _profile = currentPostProfile;
    final String _currentUserId = await _authBloc.getUser;

    final bool _followingStatus = _profile.isFollowing;
    final bool _newFollowingStatus = !_followingStatus;

    final int _updateFollowersCount = _newFollowingStatus
        ? _profile.followersCount + 1
        : _profile.followersCount - 1;

    final Profile _updatedProfile = _profile.copyWith(
        isFollowing: _newFollowingStatus,
        followersCount: _updateFollowersCount);

    final List<Post> _userPosts = _posts
        .where((Post post) => post.userID == currentPostProfile.userID)
        .toList(); // get all posts with current post userID

    for (int i = 0; i < _userPosts.length; i++) {
      final String _postID = _userPosts[i].postID;
      final Post _updatedPost =
          _userPosts[i].copyWith(profile: _updatedProfile);

      final int _postIndex =
          _posts.indexWhere((Post post) => post.postID == _postID);

      _posts[_postIndex] = _updatedPost;
      notifyListeners();
    }

    try {
      if (_newFollowingStatus) {
        await _profileRepository.addToFollowers(
            postUserId: _profile.userID, userID: _currentUserId);
      } else {
        await _profileRepository.removeFromFollowers(
            postUserId: _profile.userID, userID: _currentUserId);
      }

      // set user following in user collection
      await _profileBloc.toggleFollowProfilePageStatus(profile: _profile);

      return;
    } catch (e) {
      print(e.toString());

      final int _updateFollowersCount = !_newFollowingStatus
          ? _profile.followersCount + 1
          : _profile.followersCount - 1;

      final Profile _updatedProfile = _profile.copyWith(
          isFollowing: _newFollowingStatus,
          followersCount: _updateFollowersCount);

      final List<Post> _userPosts = _posts
          .where((Post post) => post.userID == _profile.userID)
          .toList(); // get all posts with current post userID

      _userPosts.forEach((Post post) {
        final String _postID = post.postID;
        final Post _updatedPost = post.copyWith(profile: _updatedProfile);

        final int _postIndex =
            _posts.indexWhere((Post post) => post.postID == _postID);

        _posts[_postIndex] = _updatedPost;
        notifyListeners();
      });
    }
  }

  Future<void> fetchLikeedPosts() async {
    try {
      _likePostState = PostState.Loading;
      notifyListeners();

      final String _currentUserId = await _authBloc.getUser;
      QuerySnapshot _snapshot =
          await _profileRepository.fetchLikedPosts(userID: _currentUserId);

      List<Post> posts = [];

      for (int i = 0; i < _snapshot.documents.length; i++) {
        final DocumentSnapshot document = _snapshot.documents[i];
        final String _postID = document.documentID;
        final Post _post = await _getLikePost(postID: _postID);

        posts.add(_post);
      }

      _likedPosts = posts;

      _likePostState = PostState.Success;
      notifyListeners();
      return;
    } catch (e) {
      print(e.toString());

      _likePostState = PostState.Failure;
      notifyListeners();
    }
  }

  Future<void> fetchPosts() async {
    try {
      _postState = PostState.Loading;
      notifyListeners();

      QuerySnapshot _snapshot =
          await _postRepository.fetchPosts(lastVisiblePost: null);

      List<Post> posts = [];

      for (int i = 0; i < _snapshot.documents.length; i++) {
        final DocumentSnapshot document = _snapshot.documents[i];
        final Post _post = await _getPost(document: document);

        posts.add(_post);
      }
      _posts = posts;

      _postState = PostState.Success;
      notifyListeners();

      return;
    } catch (e) {
      print(e.toString());

      _postState = PostState.Failure;
      notifyListeners();
      return;
    }
  }

  Future<void> fetchMorePosts() async {
    try {
      final List<Post> currentPosts = _posts;
      final Post lastVisiblePost = currentPosts[currentPosts.length - 1];

      if (_fetchingMorePosts == true) {
        print('Fetching more categories!');
        return;
      }

      _morePostsAvailable = true;
      _fetchingMorePosts = true;
      notifyListeners();

      final QuerySnapshot _snapshot =
          await _postRepository.fetchPosts(lastVisiblePost: lastVisiblePost);

      if (_snapshot.documents.length < 1) {
        _morePostsAvailable = false;
        _fetchingMorePosts = false;
        notifyListeners();
        print('No more post available!');
        return;
      }

      List<Post> posts = [];

      for (int i = 0; i < _snapshot.documents.length; i++) {
        final DocumentSnapshot document = _snapshot.documents[i];
        final Post _post = await _getPost(document: document);

        posts.add(_post);
      }

      posts.isEmpty ? _posts = currentPosts : _posts += posts;
      _fetchingMorePosts = false;
      notifyListeners();

      return;
    } catch (e) {
      print(e.toString());

      _fetchingMorePosts = false;
      return;
    }
  }

  Future<void> fetchProfilePosts({@required String userID}) async {
    try {
      _profilePostState = PostState.Loading;
      notifyListeners();

      QuerySnapshot _snapshot = await _postRepository.fetchProfilePosts(
          lastVisiblePost: null, userID: userID);

      List<Post> profilePosts = [];

      for (int i = 0; i < _snapshot.documents.length; i++) {
        final DocumentSnapshot document = _snapshot.documents[i];
        final Post _post = await _getPost(document: document);

        profilePosts.add(_post);
      }
      _profilePosts = profilePosts;

      _profilePostState = PostState.Success;
      notifyListeners();

      return;
    } catch (e) {
      print(e.toString());

      _profilePostState = PostState.Failure;
      notifyListeners();
      return;
    }
  }

  Future<void> fetchMoreProfilePosts({@required String userID}) async {
    try {
      final List<Post> currentProfilePosts = _profilePosts;
      final Post lastVisiblePost =
          currentProfilePosts[currentProfilePosts.length - 1];

      if (_fetchingMoreProfilePosts == true) {
        print('Fetching more profile posts!');
        return;
      }

      _moreProfilePostsAvailable = true;
      _fetchingMoreProfilePosts = true;
      notifyListeners();

      final QuerySnapshot _snapshot = await _postRepository.fetchProfilePosts(
          lastVisiblePost: lastVisiblePost, userID: userID);

      if (_snapshot.documents.length < 1) {
        _moreProfilePostsAvailable = false;
        _fetchingMoreProfilePosts = false;
        notifyListeners();
        print('No more profile post available!');
        return;
      }

      List<Post> profilePosts = [];

      for (int i = 0; i < _snapshot.documents.length; i++) {
        final DocumentSnapshot document = _snapshot.documents[i];
        final Post _post = await _getPost(document: document);

        profilePosts.add(_post);
      }

      profilePosts.isEmpty
          ? _profilePosts = currentProfilePosts
          : _profilePosts += profilePosts;
      _fetchingMoreProfilePosts = false;
      notifyListeners();

      return;
    } catch (e) {
      print(e.toString());

      _fetchingMoreProfilePosts = false;
      return;
    }
  }

  Future<bool> createPost({@required Post post, List<Asset> assets}) async {
    try {
      _postState = PostState.Loading;
      notifyListeners();

      final String userID = await _authBloc.getUser;
      List<String> _imageUrls = [];
      if (assets != null) {
        _imageUrls = await _uploadPostImage(userID: userID, assets: assets);
      }

      post.imageUrls = _imageUrls;

      await _postRepository.createPost(post: post);
      _postState = PostState.Success;
      notifyListeners();
      return true;
    } catch (e) {
      print(e.toString());
      _postState = PostState.Failure;
      notifyListeners();

      return false;
    }
  }
}
