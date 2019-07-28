import 'package:clubangel/defines/define_images.dart';
import 'package:clubangel/widgets/accounts/account_auth_widget.dart';
import 'package:flutter/material.dart';

class AccountWidget extends StatefulWidget {
  @override
  _AccountWidgetState createState() => new _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget>
    with TickerProviderStateMixin {
  int _index = 0;
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   print("push");
    //   Navigator.of(context).push(MaterialPageRoute(
    //       builder: (context) => AccountAuthWidget(), fullscreenDialog: true));
    // });
  }

  @override
  Widget build(BuildContext context) {
    _index = _index + 1;
    print(_index);
    final bgndImage =
        Image.asset(DefineImages.bgnd_main_path, fit: BoxFit.cover);

    final content = AccountAuthWidget();
    return Stack(
      fit: StackFit.expand,
      children: [
        bgndImage,
        content,
      ],
    );
  }
}
