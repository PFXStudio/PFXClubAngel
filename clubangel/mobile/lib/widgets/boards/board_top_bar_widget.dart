import 'package:clubangel/themes/main_theme.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class BoardTopBarWidget extends StatefulWidget {
  @override
  _BoardTopBarWidgetState createState() => _BoardTopBarWidgetState();
}

class _BoardTopBarWidgetState extends State<BoardTopBarWidget>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: MainTheme.defaultColor,
      automaticallyImplyLeading: false,
      centerTitle: false,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text('Real Time'),
    );
  }
}

class _Title extends StatelessWidget {
  _Title(this.toggleTheaters);
  final VoidCallback toggleTheaters;

  @override
  Widget build(BuildContext context) {
    final subtitle = StoreConnector<AppState, Theater>(
      converter: (store) => store.state.theaterState.currentTheater,
      builder: (BuildContext context, Theater currentTheater) {
        return Text(
          currentTheater?.name ?? '',
          style: const TextStyle(
            fontSize: 12.0,
            color: Colors.white70,
          ),
        );
      },
    );

    final title = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Test'),
        subtitle,
      ],
    );

    return GestureDetector(
      onTap: toggleTheaters,
      child: Row(
        children: [
          // Image.asset('assets/images/logo.png', width: 28.0, height: 28.0),
          // const SizedBox(width: 8.0),
          // title,
        ],
      ),
    );
  }
}
