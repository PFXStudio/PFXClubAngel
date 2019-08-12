import 'package:clubangel/themes/main_theme.dart';
import 'package:clubangel/widgets/commons/divider_widget.dart';
import 'package:clubangel/widgets/commons/scaffold_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:core/src/networking/image_upload_api.dart';
import 'package:core/src/models/member.dart';
import 'package:core/src/networking/firestore_account_api.dart';

import 'account_tile_widget.dart';

class AccountWidget extends StatefulWidget {
  @override
  _AccountWidgetState createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  List<Asset> _images = List<Asset>();
  var deviceSize;
  var defaultImagePath = (Member.signedInstance.thumbnailPath != null &&
          Member.signedInstance.thumbnailPath.length > 0)
      ? Member.signedInstance.thumbnailPath
      : "https://avatars1.githubusercontent.com/u/13096942?s=460&v=4";

  @override
  Widget build(BuildContext context) {
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
                AccountTileWidget(
                  title: "Pawan Kumar",
                  subtitle: "Developer",
                  textColor: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.chat),
                        color: Colors.white,
                        onPressed: () {},
                      ),
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
                            backgroundImage: NetworkImage(defaultImagePath),
                            foregroundColor: Colors.white,
                            radius: 30.0,
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.only(top: 45, left: 45),
                          icon: Icon(FontAwesomeIcons.image),
                          color: Colors.white,
                          iconSize: 20,
                          onPressed: () {
                            _loadAssets();
                          },
                        ),
                      ]),
                      IconButton(
                        icon: Icon(Icons.call),
                        color: Colors.white,
                        onPressed: () {},
                      ),
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
      String thumbnailPath = await ImageUploadApi().saveProfileImage(
          documentID: Member.signedInstance.documentID, asset: asset);
      print(thumbnailPath);
      Member updateMember = Member.signedInstance;
      updateMember.thumbnailPath = thumbnailPath;
      FirestoreAccountApi().updateMember(updateMember, () {
        setState(() {
          defaultImagePath = thumbnailPath;
        });
      }, (error) {
        print(error);
      });
    } on PlatformException catch (e) {
      error = e.message;
      print(e.message);
    }
  }
}

//Column1
