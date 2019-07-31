import 'package:clubangel/widgets/commons/divider_widget.dart';
import 'package:clubangel/widgets/commons/scaffold_widget.dart';
import 'package:flutter/material.dart';

import 'account_tile_widget.dart';

class AccountWidget extends StatelessWidget {
  var deviceSize;

  //Column1
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
                          backgroundImage: NetworkImage(
                              "https://avatars1.githubusercontent.com/u/13096942?s=460&v=4"),
                          foregroundColor: Colors.white,
                          radius: 30.0,
                        ),
                      ),
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

  //column2

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

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return bodyData();
  }
}

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
