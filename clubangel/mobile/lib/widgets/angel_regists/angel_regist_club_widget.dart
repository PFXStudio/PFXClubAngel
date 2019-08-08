import 'dart:convert';

import 'package:clubangel/defines/define_strings.dart';
import 'package:clubangel/loaders/localizable_loader.dart';
import 'package:clubangel/themes/main_theme.dart';
import 'package:clubangel/widgets/buttons/flat_icon_text_button.dart';
import 'package:clubangel/widgets/dialogs/dialog_bottom_widget.dart';
import 'package:clubangel/widgets/dialogs/dialog_header_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

typedef AngelRegistClubCallback = void Function(int index);

class AngelRegistClubWidget extends StatefulWidget {
  AngelRegistClubWidget({this.callback = null});
  @override
  _AngelRegistClubWidgetState createState() => _AngelRegistClubWidgetState();
  AngelRegistClubCallback callback;
}

class _AngelRegistClubWidgetState extends State<AngelRegistClubWidget> {
  double selectedPrice = 0;

  Widget _buildContents(BuildContext context) {
    return Container(
        height: 250,
        color: Colors.white,
        child: ListView.separated(
            separatorBuilder: (context, index) => Divider(
                  color: Colors.black26,
                ),
            scrollDirection: Axis.vertical,
            itemCount: DefineStrings.clubNames.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    DefineStrings.clubNames[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                  ));
            }));
  }

  @override
  Widget build(BuildContext context) {
    return FlatIconTextButton(
        iconData: FontAwesomeIcons.mapMarkerAlt,
        color: MainTheme.enabledButtonColor,
        width: 170,
        text: LocalizableLoader.of(context).text("club_name_select"),
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
                                .text("club_name_select")),
                        Material(
                          type: MaterialType.transparency,
                          child: _buildContents(context),
                        ),
                        DialogBottomWidget(
                          cancelCallback: () {
                            Navigator.pop(context);
                          },
                          confirmCallback: () {
                            Navigator.pop(context);
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
