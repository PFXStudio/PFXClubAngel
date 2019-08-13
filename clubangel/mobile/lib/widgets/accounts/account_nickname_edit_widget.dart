import 'package:clubangel/defines/define_enums.dart';
import 'package:clubangel/loaders/localizable_loader.dart';
import 'package:clubangel/themes/main_theme.dart';
import 'package:clubangel/widgets/buttons/flat_icon_text_button.dart';
import 'package:clubangel/widgets/dialogs/dialog_bottom_widget.dart';
import 'package:clubangel/widgets/dialogs/dialog_header_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:core/src/models/member.dart';
import 'package:core/src/networking/firestore_account_api.dart';

typedef AccountNicknameEditWidgetCallback = void Function(int index);

class AccountNicknameEditWidget extends StatefulWidget {
  AccountNicknameEditWidget({this.callback = null});
  @override
  _AccountNicknameEditWidgetState createState() =>
      _AccountNicknameEditWidgetState();
  AccountNicknameEditWidgetCallback callback;
}

class _AccountNicknameEditWidgetState extends State<AccountNicknameEditWidget> {
  @override
  var contentsWidget = AccountNicknameEditWidgetContentsWidget();
  var firestoreAccountApi = FirestoreAccountApi();
  Widget build(BuildContext context) {
    return FlatIconTextButton(
        iconData: FontAwesomeIcons.solidEdit,
        color: Colors.white,
        width: 170,
        text: Member.signedInstance.nickname,
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        DialogHeaderWidget(
                            title: LocalizableLoader.of(context)
                                .text("edit_nickname")),
                        Material(
                          type: MaterialType.transparency,
                          child: contentsWidget,
                        ),
                        DialogBottomWidget(
                          cancelCallback: () {
                            Navigator.pop(context);
                          },
                          confirmCallback: () {
                            var nickname =
                                contentsWidget.nicknameController.text;
                            if (nickname == null || nickname.length < 4) {
                              // show error
                              return;
                            }

                            firestoreAccountApi.selectNickname(nickname,
                                (result) {
                              if (result != null) {
                                // show duplicate nickname
                                return;
                              }

                              Member updateMember = Member.signedInstance;
                              updateMember.nickname = nickname;
                              firestoreAccountApi.updateMember(updateMember,
                                  () {
                                Navigator.pop(context);
                              }, (error) {
                                print(error);
                              });
                            }, (error) {
                              // show error
                              print(error);
                            });
                          },
                        )
                      ])));
        });
  }
}

customHandler(IconData icon) {
  return FlutterSliderHandler(
    decoration: BoxDecoration(),
    child: Container(
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.3), shape: BoxShape.circle),
        child: Icon(
          icon,
          color: Colors.white,
          size: 23,
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
              color: Colors.blue.withOpacity(0.3),
              spreadRadius: 0.05,
              blurRadius: 5,
              offset: Offset(0, 1))
        ],
      ),
    ),
  );
}

class AccountNicknameEditWidgetContentsWidget extends StatefulWidget {
  @override
  _AccountNicknameEditWidgetContentsWidgetState createState() =>
      _AccountNicknameEditWidgetContentsWidgetState();
  TextEditingController nicknameController = new TextEditingController();
  final FocusNode nicknameFocusNode = FocusNode();
}

class _AccountNicknameEditWidgetContentsWidgetState
    extends State<AccountNicknameEditWidgetContentsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(children: <Widget>[
        Padding(
          padding:
              EdgeInsets.only(top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
          child: TextField(
            focusNode: widget.nicknameFocusNode,
            controller: widget.nicknameController,
            keyboardType: TextInputType.text,
            style: TextStyle(fontSize: 16.0, color: Colors.black),
            decoration: InputDecoration(
              border: InputBorder.none,
              icon: Icon(
                FontAwesomeIcons.envelope,
                color: Colors.black,
              ),
              hintText: "nickname",
              hintStyle: TextStyle(fontSize: 16.0),
            ),
          ),
        ),
      ]),
    );
  }
}
