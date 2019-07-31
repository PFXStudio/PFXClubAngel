import 'package:clubangel/defines/define_images.dart';
import 'package:clubangel/loaders/localizable_loader.dart';
import 'package:clubangel/singletons/keyboard_singleton.dart';
import 'package:clubangel/themes/main_theme.dart';
import 'package:clubangel/widgets/accounts/account_widget.dart';
import 'package:clubangel/widgets/angels/angel_widget.dart';
import 'package:clubangel/widgets/boards/board_collection_widget.dart';
import 'package:clubangel/widgets/boards/dash_board_widget.dart';
import 'package:clubangel/widgets/mains/main_bottom_bar_widget.dart';
import 'package:clubangel/widgets/mains/main_invisible_bottom_bar.dart';
import 'package:clubangel/widgets/mains/main_top_bar_widget.dart';
import 'package:clubangel/widgets/real_times/real_time_collection_widget.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class MainWidget extends StatefulWidget {
  const MainWidget();

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Widget _buildTabContent() {
    final fill = Positioned.fill(
      child: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          BoardCollectionWidget(BoardListType.realTime),
          AngelWidget(BoardListType.realTime), // angel
          RealTimeCollectionWidget(BoardListType.clubInfo), // club info
          AccountWidget(),
        ],
      ),
    );
    return fill;
  }

  void _tabSelected(int newIndex) {
    setState(() {
      _selectedTab = newIndex;
      _tabController.index = newIndex;
    });
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      print("touched add");
    });
  }

  @override
  Widget build(BuildContext context) {
    final bgndImage =
        Image.asset(DefineImages.bgnd_main_path, fit: BoxFit.cover);

    final content = Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: MainTopBarWidget(),
      ),
      body: Stack(
        children: [
          _buildTabContent(),
          _BottomTabs(
            selectedTab: _selectedTab,
            onTap: _tabSelected,
          ),
        ],
      ),
    );

    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  MainTheme.loginGradientStart,
                  MainTheme.loginGradientEnd
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
        content,
      ],
    );
  }
}

class _BottomTabs extends StatelessWidget {
  _BottomTabs({
    @required this.selectedTab,
    @required this.onTap,
  });

  final int selectedTab;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    // final messages = MessageProvider.of(context);

    return Align(
      alignment: Alignment.bottomCenter,
      child: KeyboardSingleton().isKeyboardVisible()
          ? MainInvisibleBottomBar()
          : MainBottomBarWidget(
              currentIndex: selectedTab,
              onTap: onTap,
              items: [
                BottomNavigationBarItem(
                  title: Text(LocalizableLoader.of(context).text("app_title")),
                  icon: const Icon(Icons.settings_input_antenna),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                BottomNavigationBarItem(
                  title: Text(LocalizableLoader.of(context).text("app_title")),
                  icon: const Icon(Icons.local_pizza),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                BottomNavigationBarItem(
                  title: Text(LocalizableLoader.of(context).text("app_title")),
                  icon: const Icon(Icons.queue_music),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                BottomNavigationBarItem(
                  title: Text(LocalizableLoader.of(context).text("app_title")),
                  icon: const Icon(Icons.person),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
    );
  }
}
