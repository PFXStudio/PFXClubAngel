import 'package:clubangel/loaders/localizable_loader.dart';
import 'package:clubangel/themes/main_theme.dart';
import 'package:clubangel/widgets/buttons/flat_icon_text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

typedef AngelRegistDateCallback = void Function(int index);

class AngelRegistDateWidget extends StatefulWidget {
  AngelRegistDateWidget({this.callback = null});
  @override
  _AngelRegistDateWidgetState createState() => _AngelRegistDateWidgetState();
  AngelRegistDateCallback callback;
}

class _AngelRegistDateWidgetState extends State<AngelRegistDateWidget> {
  @override
  Widget build(BuildContext context) {
    return FlatIconTextButton(
        iconData: FontAwesomeIcons.calendar,
        color: MainTheme.enabledButtonColor,
        width: 150,
        text: LocalizableLoader.of(context).text("date_select"),
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
                  title: const Text('Choose Options'),
                  message: const Text('Your options are '),
                  actions: <Widget>[
                    CupertinoActionSheetAction(
                      child: const Text('One'),
                      onPressed: () {
                        Navigator.pop(context, 'One');
                      },
                    ),
                    CupertinoActionSheetAction(
                      child: const Text('Two'),
                      onPressed: () {
                        Navigator.pop(context, 'Two');
                      },
                    )
                  ],
                ),
              )
            });
  }
}
