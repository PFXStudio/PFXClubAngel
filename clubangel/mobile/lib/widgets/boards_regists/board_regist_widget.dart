import 'package:clubangel/loaders/localizable_loader.dart';
import 'package:clubangel/themes/main_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_image_picker/asset.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'board_regist_top_bar_widget.dart';

class BoardRegistWidget extends StatefulWidget {
  BoardRegistWidget({Key key}) : super(key: key);

  @override
  _BoardRegistState createState() => new _BoardRegistState();
}

class _BoardRegistState extends State<BoardRegistWidget>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final FocusNode titleFocusNode = FocusNode();
  final FocusNode contentsFocusNode = FocusNode();

  TextEditingController titleController = new TextEditingController();
  TextEditingController contentsController = new TextEditingController();

  double contentsHeight = 800;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: BoardRegistTopBarWidget(),
        ),
        key: _scaffoldKey,
        body: SingleChildScrollView(
            child: Container(
          width: MediaQuery.of(context).size.width,
          height: contentsHeight,
          decoration: new BoxDecoration(
            gradient: MainTheme.primaryLinearGradient,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: _buildContents(context),
                ),
              ),
            ],
          ),
        )));
  }

  @override
  void dispose() {
    titleFocusNode.dispose();
    contentsFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 16.0),
      ),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }

  Widget _buildGallery(BuildContext context) {
    List<Asset> resultList;
    String error;
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        height: 100.0,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 1,
            itemBuilder: (context, index) {
              return Padding(
                padding: MainTheme.edgeInsets,
                child: GestureDetector(
                  onTap: () async => {
                    resultList = await MultiImagePicker.pickImages(
                      maxImages: 300,
                    ),
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: MainTheme.bgndColor,
                    ),
                    child: new Icon(FontAwesomeIcons.images,
                        color: MainTheme.enabledIconColor),
                  ),
                ),
              );
            }));
  }

  Widget _buildLineDecoration(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: new LinearGradient(
                  colors: [
                    Colors.white10,
                    Colors.white,
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            width: MediaQuery.of(context).size.width / 2,
            height: 1.0,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: new LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white10,
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            width: 100.0,
            height: 1.0,
          ),
        ],
      ),
    );
  }

  Widget _buildRegistButton(BuildContext context) {
    return Container(
      margin: MainTheme.edgeInsets,
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: MainTheme.gradientStartColor,
            offset: Offset(1.0, 6.0),
            blurRadius: 20.0,
          ),
          BoxShadow(
            color: MainTheme.gradientEndColor,
            offset: Offset(1.0, 6.0),
            blurRadius: 20.0,
          ),
        ],
        gradient: MainTheme.buttonLinearGradient,
      ),
      child: MaterialButton(
          highlightColor: Colors.transparent,
          splashColor: MainTheme.gradientEndColor,
          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
            child: Text(
              LocalizableLoader.of(context).text("board_regist_button"),
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
              ),
            ),
          ),
          onPressed: () {
            showInSnackBar("Login button pressed");
            _requestRegist(context);
          }),
    );
  }

  Widget _buildContents(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MainTheme.edgeInsets.top),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width -
                      MainTheme.edgeInsets.left,
                  height: 450,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: MainTheme.edgeInsets,
                        child: TextField(
                          focusNode: titleFocusNode,
                          controller: titleController,
                          keyboardType: TextInputType.multiline,
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.cocktail,
                              color: Colors.black54,
                              size: 18.0,
                            ),
                            hintText: LocalizableLoader.of(context)
                                .text("board_title_hint_text"),
                            hintStyle: TextStyle(fontSize: 17.0),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width -
                            MainTheme.edgeInsets.left * 2,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                          padding: MainTheme.edgeInsets,
                          child: TextField(
                            focusNode: contentsFocusNode,
                            controller: contentsController,
                            keyboardType: TextInputType.multiline,
                            maxLines: 15,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesomeIcons.alignJustify,
                                size: 18.0,
                                color: Colors.black54,
                              ),
                              hintText: LocalizableLoader.of(context)
                                  .text("board_contents_hint_text"),
                              hintStyle: TextStyle(fontSize: 17.0),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
          _buildGallery(context),
          _buildLineDecoration(context),
          _buildRegistButton(context),
        ],
      ),
    );
  }

  void _requestRegist(BuildContext context) {
    print("tab!!");
  }
}
