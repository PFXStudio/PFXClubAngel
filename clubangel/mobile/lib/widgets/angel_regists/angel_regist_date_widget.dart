import 'package:clubangel/loaders/localizable_loader.dart';
import 'package:clubangel/themes/main_theme.dart';
import 'package:clubangel/widgets/buttons/flat_icon_text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

typedef AngelRegistDateCallback = void Function(DateTime dateTime);

class AngelRegistDateWidget extends StatefulWidget {
  AngelRegistDateWidget({this.callback = null});
  @override
  _AngelRegistDateWidgetState createState() => _AngelRegistDateWidgetState();
  AngelRegistDateCallback callback;
}

class _AngelRegistDateWidgetState extends State<AngelRegistDateWidget> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return FlatIconTextButton(
      iconData: FontAwesomeIcons.calendar,
      color: MainTheme.enabledButtonColor,
      width: 150,
      text: LocalizableLoader.of(context).text("date_select"),
      onPressed: () {
        DatePicker.showDatePicker(context,
            showTitleActions: true,
            minTime: now,
            maxTime: now.add(Duration(days: 6)), onChanged: (date) {
          print('change $date');
        }, onConfirm: (date) {
          widget.callback(date);
        }, currentTime: now, locale: LocaleType.ko);
      },
    );
  }
}
