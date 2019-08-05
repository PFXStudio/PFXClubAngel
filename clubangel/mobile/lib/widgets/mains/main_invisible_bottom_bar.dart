import 'package:flutter/cupertino.dart';

class MainInvisibleBottomBar extends CupertinoTabBar {
  static const dummyIcon = Icon(IconData(0x0020));

  MainInvisibleBottomBar()
      : super(
          items: [
            BottomNavigationBarItem(icon: dummyIcon),
            BottomNavigationBarItem(icon: dummyIcon),
          ],
        );

  @override
  Size get preferredSize => const Size.square(0);

  @override
  Widget build(BuildContext context) => SizedBox();

  @override
  MainInvisibleBottomBar copyWith({
    Key key,
    List<BottomNavigationBarItem> items,
    Color backgroundColor,
    Color activeColor,
    Color inactiveColor,
    Size iconSize,
    Border border,
    int currentIndex,
    ValueChanged<int> onTap,
  }) =>
      MainInvisibleBottomBar();
}
