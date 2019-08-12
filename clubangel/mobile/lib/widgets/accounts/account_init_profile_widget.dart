import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clubangel/defines/define_enums.dart';
import 'package:clubangel/themes/main_theme.dart';
import 'package:clubangel/widgets/dialogs/dialog_gender_type_widget.dart';
import 'package:clubangel/widgets/mains/main_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:core/src/networking/firestore_account_api.dart';
import 'package:core/src/models/member.dart';

class AccountInitProfileWidget extends StatefulWidget {
  @override
  _AccountInitProfileWidgetState createState() =>
      _AccountInitProfileWidgetState();
}

class _AccountInitProfileWidgetState extends State<AccountInitProfileWidget> {
  TextEditingController nicknameController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();

  final FocusNode nicknameFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();

  GenderType genderType = GenderType.MAX;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: SingleChildScrollView(
            child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height >= 655.0
              ? MediaQuery.of(context).size.height
              : 655.0,
          decoration: new BoxDecoration(
            gradient: MainTheme.primaryLinearGradient,
          ),
          child: Column(
            children: <Widget>[
              Stack(
                alignment: Alignment.topCenter,
                overflow: Overflow.visible,
                children: <Widget>[
                  Card(
                    margin: EdgeInsets.all(30),
                    elevation: 2.0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(top: 30),
                      height: 500.0,
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: new BorderRadius.all(
                                  new Radius.circular(60.0)),
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
                              radius: 50.0,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.call),
                            color: Colors.white,
                            onPressed: () {},
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 20.0,
                                bottom: 20.0,
                                left: 25.0,
                                right: 25.0),
                            child: TextField(
                              focusNode: nicknameFocusNode,
                              controller: nicknameController,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  FontAwesomeIcons.child,
                                  color: Colors.black87,
                                  size: 16,
                                ),
                                hintText: "Nickname",
                                hintStyle: TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ),
                          Container(
                            width: 250.0,
                            height: 1.0,
                            color: Colors.grey[400],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 20.0,
                                bottom: 20.0,
                                left: 25.0,
                                right: 25.0),
                            child: TextField(
                              focusNode: descriptionFocusNode,
                              controller: descriptionController,
                              keyboardType: TextInputType.multiline,
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  FontAwesomeIcons.idCard,
                                  color: Colors.black87,
                                  size: 16,
                                ),
                                hintText: "Description",
                                hintStyle: TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ),
                          Container(
                            width: 250.0,
                            height: 1.0,
                            color: Colors.grey[400],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width -
                                MainTheme.edgeInsets.left,
                            height: 60,
                            padding: EdgeInsets.only(top: 20),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            DialogGenderTypeWidget(
                                                callback: (type) {
                                              genderType = type;
                                            }),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                          ),
                          // Container(
                          //   width: 250.0,
                          //   height: 1.0,
                          //   color: Colors.grey[400],
                          // ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 505.0),
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
                        splashColor: Colors.red,
                        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 42.0),
                          child: Text(
                            "Confirm",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        onPressed: touchedConfirmButton),
                  ),
                ],
              ),
            ],
          ),
        )));
  }

  Future touchedConfirmButton() async {
    if (nicknameController.text.length < 4 ||
        nicknameController.text.length > 12) {
      return;
    }

    if (genderType == GenderType.MAX) {
      return;
    }

    FirestoreAccountApi().selectNickname(nicknameController.text, (member) {
      if (member != null) {
        return;
      }

      Member updateMember = Member();
      updateMember = Member.memberInstance;
      updateMember.nickname = nicknameController.text;
      updateMember.description = descriptionController.text;
      FirestoreAccountApi().updateMember(updateMember, () {
        Navigator.of(context, rootNavigator: true).pushReplacement(
            MaterialPageRoute(builder: (context) => MainWidget()));
      }, (error) {
        print(error);
      });
    }, (error) {
      print(error);
    });
  }
}
