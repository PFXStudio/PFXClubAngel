import 'package:clubangel/loaders/localizable_loader.dart';
import 'package:clubangel/themes/main_theme.dart';
import 'package:clubangel/widgets/buttons/flat_icon_text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

typedef AngelRegistPriceCallback = void Function(int index);

class AngelRegistPriceWidget extends StatefulWidget {
  AngelRegistPriceWidget({this.callback = null});
  @override
  _AngelRegistPriceWidgetState createState() => _AngelRegistPriceWidgetState();
  AngelRegistPriceCallback callback;
}

class _AngelRegistPriceWidgetState extends State<AngelRegistPriceWidget> {
  String selectedPrice = "0";
  @override
  Widget build(BuildContext context) {
    return FlatIconTextButton(
        iconData: FontAwesomeIcons.wonSign,
        color: MainTheme.enabledButtonColor,
        width: 170,
        text: LocalizableLoader.of(context).text("price_select"),
        onPressed: () {
          Picker(
              adapter: NumberPickerAdapter(data: [
                NumberPickerColumn(begin: 0, end: 900, jump: 100),
                NumberPickerColumn(begin: 0, end: 90, jump: 10),
                NumberPickerColumn(begin: 1, end: 9),
              ]),
              delimiter: [
                // PickerDelimiter(
                //     child: Container(
                //   width: 30.0,
                //   alignment: Alignment.center,
                //   child: Icon(Icons.add),
                // )),
              ],
              containerColor: MainTheme.enabledButtonColor,
              hideHeader: true,
              title: new Text(selectedPrice),
              onSelect: (Picker picker, int index, List<int> selecteds) {
                setState(() {
                  selectedPrice = "${picker.getSelectedValues()}";
                });
              },
              onConfirm: (Picker picker, List value) {
                print(value.toString());
                print(picker.getSelectedValues());
              }).showDialog(context);
        });
  }
}
