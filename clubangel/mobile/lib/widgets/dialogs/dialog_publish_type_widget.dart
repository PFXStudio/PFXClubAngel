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

typedef DialogPublishTypeWidgetCallback = void Function(int index);

class DialogPublishTypeWidgetWidget extends StatefulWidget {
  DialogPublishTypeWidgetWidget({this.callback = null});
  @override
  _DialogPublishTypeWidgetWidgetState createState() =>
      _DialogPublishTypeWidgetWidgetState();
  DialogPublishTypeWidgetCallback callback;
}

class _DialogPublishTypeWidgetWidgetState
    extends State<DialogPublishTypeWidgetWidget> {
  @override
  Widget build(BuildContext context) {
    return FlatIconTextButton(
        iconData: FontAwesomeIcons.venusMars,
        color: MainTheme.enabledButtonColor,
        width: 170,
        text: LocalizableLoader.of(context).text("publish_type_select"),
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
                                .text("publish_type_select")),
                        Material(
                          type: MaterialType.transparency,
                          child: DialogPublishTypeWidgetContentsWidget(),
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

class DialogPublishTypeWidgetContentsWidget extends StatefulWidget {
  @override
  _DialogPublishTypeWidgetContentsWidgetState createState() =>
      _DialogPublishTypeWidgetContentsWidgetState();
}

class _DialogPublishTypeWidgetContentsWidgetState
    extends State<DialogPublishTypeWidgetContentsWidget> {
  @override
  PublishType publishType = PublishType.all;
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          ListTile(
            title:
                Text(LocalizableLoader.of(context).text("${PublishType.all}")),
            leading: Radio(
              value: PublishType.all,
              groupValue: publishType,
              onChanged: (PublishType value) {
                setState(() {
                  publishType = value;
                });
              },
            ),
          ),
          ListTile(
            title:
                Text(LocalizableLoader.of(context).text("${PublishType.male}")),
            leading: Radio(
              value: PublishType.male,
              groupValue: publishType,
              onChanged: (PublishType value) {
                setState(() {
                  publishType = value;
                });
              },
            ),
          ),
          ListTile(
            title: Text(
                LocalizableLoader.of(context).text("${PublishType.female}")),
            leading: Radio(
              value: PublishType.female,
              groupValue: publishType,
              onChanged: (PublishType value) {
                setState(() {
                  publishType = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  onChangedValue(value) {
    setState(() {
      publishType = value;
    });
  }
}
