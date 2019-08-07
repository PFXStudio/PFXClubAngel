import 'package:clubangel/loaders/localizable_loader.dart';
import 'package:clubangel/themes/main_theme.dart';
import 'package:clubangel/widgets/buttons/flat_icon_text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:intl/intl.dart' as intl;

typedef AngelRegistPriceCallback = void Function(int index);

class AngelRegistPriceWidget extends StatefulWidget {
  AngelRegistPriceWidget({this.callback = null});
  @override
  _AngelRegistPriceWidgetState createState() => _AngelRegistPriceWidgetState();
  AngelRegistPriceCallback callback;
}

class _AngelRegistPriceWidgetState extends State<AngelRegistPriceWidget> {
  double selectedPrice = 0;
  Widget _buildHeader(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        color: MainTheme.bgndColor,
        child: Material(
            type: MaterialType.button,
            color: Colors.transparent,
            child: InkWell(
              borderRadius: kMaterialEdges[MaterialType.button],
              highlightColor: MainTheme.enabledButtonColor,
              splashColor: Colors.transparent,
              onTap: () {},
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    LocalizableLoader.of(context).text("price_select"),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
            )));
  }

  Widget _buildContents(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Container(
            margin: EdgeInsets.only(top: 50),
            alignment: Alignment.centerLeft,
            child: FlutterSlider(
              values: [10],
              rangeSlider: false,
              max: 500,
              min: 10,
              step: 1,
              jump: true,
              trackBar: FlutterSliderTrackBar(
                inactiveTrackBarHeight: 2,
                activeTrackBarHeight: 3,
              ),
              disabled: false,
              handler: customHandler(Icons.chevron_right),
              rightHandler: customHandler(Icons.chevron_left),
              tooltip: FlutterSliderTooltip(
                alwaysShowTooltip: true,
                numberFormat: intl.NumberFormat(),
                // leftPrefix: Icon(
                //   FontAwesomeIcons.wonSign,
                //   size: 14,
                //   color: Colors.black45,
                // ),
                rightSuffix: Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text("만원",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.bold))),
                textStyle: TextStyle(fontSize: 17, color: Colors.black45),
              ),
              onDragging: (handlerIndex, lowerValue, upperValue) {
                setState(() {
                  selectedPrice = lowerValue;
                });
              },
            )));
  }

  Widget _buildActions(BuildContext context) {
    return Container(
        color: Colors.white,
        child: ButtonTheme.bar(
          child: ButtonBar(
            children: <Widget>[
              FlatButton(
                  child:
                      Text(LocalizableLoader.of(context).text("cancel_button")),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              FlatButton(
                  child:
                      Text(LocalizableLoader.of(context).text("done_button")),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return FlatIconTextButton(
        iconData: FontAwesomeIcons.wonSign,
        color: MainTheme.enabledButtonColor,
        width: 170,
        text: LocalizableLoader.of(context).text("price_select"),
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
                        _buildHeader(context),
                        _buildContents(context),
                        _buildActions(context),
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
