import 'package:clubangel/themes/main_theme.dart';
import 'package:clubangel/widgets/accounts/account_nickname_edit_widget.dart';
import 'package:clubangel/widgets/commons/divider_widget.dart';
import 'package:clubangel/widgets/commons/scaffold_widget.dart';
import 'package:clubangel/widgets/snackbars/error_snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:core/src/networking/image_upload_api.dart';
import 'package:core/src/models/import.dart';
import 'package:core/src/blocs/import.dart';

import 'account_tile_widget.dart';

class AccountWidget extends StatefulWidget {
  @override
  _AccountWidgetState createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  final ProfileBloc _profileBloc = ProfileBloc.instance();
  List<Asset> _images = List<Asset>();
  var deviceSize;
  var defaultThumbnailUrl;
  @override
  Widget build(BuildContext context) {
    defaultThumbnailUrl = (_profileBloc.userProfile != null &&
            _profileBloc.userProfile.thumbnailUrl.length > 0)
        ? _profileBloc.userProfile.thumbnailUrl
        : "http://freelanceme.net/Images/default%20profile%20picture.png";

    deviceSize = MediaQuery.of(context).size;
    return bodyData();
  }

  Widget bodyData() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          profileColumn(),
          DividerWidget(),
          followColumn(deviceSize),
          DividerWidget(),
          descColumn(),
          DividerWidget(),
          accountColumn(),
          Padding(
            padding: const EdgeInsets.only(top: 50),
          ),
        ],
      ),
    );
  }

  //column3
  Widget descColumn() => Container(
        height: deviceSize.height * 0.13,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Text(
              "Google Developer Expert for Flutter. Passionate #Flutter, #Android Developer. #Entrepreneur #YouTuber",
              style:
                  TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
              textAlign: TextAlign.center,
              maxLines: 3,
              softWrap: true,
            ),
          ),
        ),
      );
  //column4
  Widget accountColumn() => FittedBox(
        fit: BoxFit.fill,
        child: Container(
          height: deviceSize.height * 0.3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FittedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    AccountTileWidget(
                      title: "Website",
                      subtitle: "about.me/imthepk",
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    AccountTileWidget(
                      title: "Phone",
                      subtitle: "+919876543210",
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    AccountTileWidget(
                      title: "YouTube",
                      subtitle: "youtube.com/mtechviral",
                    ),
                  ],
                ),
              ),
              FittedBox(
                fit: BoxFit.cover,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    AccountTileWidget(
                      title: "Location",
                      subtitle: "New Delhi",
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    AccountTileWidget(
                      title: "Email",
                      subtitle: "mtechviral@gmail.com",
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    AccountTileWidget(
                      title: "Facebook",
                      subtitle: "fb.com/imthepk",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget followColumn(Size deviceSize) => Container(
        height: deviceSize.height * 0.13,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            AccountTileWidget(
              title: "1.5K",
              subtitle: "Posts",
            ),
            AccountTileWidget(
              title: "2.5K",
              subtitle: "Followers",
            ),
            AccountTileWidget(
              title: "10K",
              subtitle: "Comments",
            ),
            AccountTileWidget(
              title: "1.2K",
              subtitle: "Following",
            )
          ],
        ),
      );

  Widget profileColumn() => Container(
        height: deviceSize.height * 0.24,
        child: FittedBox(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                // ),
                AccountNicknameEditWidget(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      // IconButton(
                      //   icon: Icon(Icons.chat),
                      //   color: Colors.white,
                      //   onPressed: () {},
                      // ),
                      Stack(children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                new BorderRadius.all(new Radius.circular(40.0)),
                            border: new Border.all(
                              color: Colors.black26,
                              width: 2.0,
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: NetworkImage(defaultThumbnailUrl),
                            foregroundColor: Colors.white,
                            radius: 30.0,
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.only(top: 45, left: 45),
                          icon: Icon(FontAwesomeIcons.image),
                          color: Colors.white54,
                          iconSize: 20,
                          onPressed: () {
                            _loadAssets();
                          },
                        ),
                      ]),
                      // IconButton(
                      //   icon: Icon(Icons.call),
                      //   color: Colors.white,
                      //   onPressed: () {},
                      // ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );

  Future<void> _loadAssets() async {
    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
        enableCamera: true,
      );

      if (resultList.length <= 0) {
        return;
      }

      Asset asset = resultList.first;
      Profile profile = _profileBloc.userProfile.copyWith();

      if (_profileBloc.updateProfile(profile: profile, thumbnailImage: asset) ==
          false) {
        // TODO :
        // ErrorSnackbarWidget().show(key, message, callback)
        return;
      }
    } on PlatformException catch (e) {
      error = e.message;
      print(e.message);
    }
  }
}

//Column1
