import 'package:clubangel/defines/define_images.dart';
import 'package:clubangel/loaders/localizable_loader.dart';
import 'package:clubangel/widgets/accounts/addcount_widget.dart';
import 'package:clubangel/widgets/angels/angel_widget.dart';
import 'package:clubangel/widgets/mains/main_bottom_bar_widget.dart';
import 'package:clubangel/widgets/mains/main_top_bar_widget.dart';
import 'package:clubangel/widgets/real_times/real_time_widget.dart';
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
          RealTimeWidget(EventListType.nowInTheaters), // real time
          const AngelWidget(), // angel
          RealTimeWidget(EventListType.nowInTheaters), // club info
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
        bgndImage,
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
      child: MainBottomBarWidget(
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