import 'package:clubangel/defines/define_strings.dart';
import 'package:clubangel/loaders/localizable_loader.dart';
import 'package:clubangel/themes/main_theme.dart';
import 'package:clubangel/widgets/buttons/flat_icon_text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

typedef AngelRegistClubCallback = void Function(int index);

class AngelRegistClubWidget extends StatefulWidget {
  AngelRegistClubWidget({this.callback = null});
  @override
  _AngelRegistClubWidgetState createState() => _AngelRegistClubWidgetState();
  AngelRegistClubCallback callback;
}

class _AngelRegistClubWidgetState extends State<AngelRegistClubWidget> {
  @override
  Widget build(BuildContext context) {
    List<Widget> actions = List<Widget>();
    var i = 0;
    for (int i = 0; i < DefineStrings.clubNames.length; i++) {
      String clubName = DefineStrings.clubNames[i];
      var action = CupertinoActionSheetAction(
        child: Text(clubName),
        onPressed: () {
          Navigator.pop(context, clubName);
          widget.callback(i);
        },
      );

      actions.add(action);
    }
    for (var clubName in DefineStrings.clubNames) {}

    return FlatIconTextButton(
        iconData: FontAwesomeIcons.mapMarkerAlt,
        color: MainTheme.enabledButtonColor,
        width: 170,
        text: LocalizableLoader.of(context).text("club_name_select"),
        onPressed: () => {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) => CupertinoActionSheet(
                  cancelButton: FlatButton(
                    color: Colors.red,
                    onPressed: () {
                      Navigator.pop(context, 'One');
                      widget.callback(-1);
                    },
                    child: Text(
                      LocalizableLoader.of(context).text("cancel_button"),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    LocalizableLoader.of(context).text("club_name_select"),
                  ),
                  message: Text(""),
                  actions: actions,
                ),
              )
            });
  }
}
