import 'package:clubangel/loaders/localizable_loader.dart';
import 'package:clubangel/themes/main_theme.dart';
import 'package:clubangel/widgets/buttons/flat_icon_text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

typedef AngelRegistCocktailCountCallback = void Function(int index);

class AngelRegistCocktailCountWidget extends StatefulWidget {
  AngelRegistCocktailCountWidget({this.callback = null});
  @override
  _AngelRegistCocktailCountWidgetState createState() =>
      _AngelRegistCocktailCountWidgetState();

  AngelRegistCocktailCountCallback callback;
}

class _AngelRegistCocktailCountWidgetState
    extends State<AngelRegistCocktailCountWidget> {
  @override
  Widget build(BuildContext context) {
    return FlatIconTextButton(
        iconData: FontAwesomeIcons.cocktail,
        color: MainTheme.enabledButtonColor,
        width: 170,
        text: LocalizableLoader.of(context).text("cocktail_count_select"),
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
