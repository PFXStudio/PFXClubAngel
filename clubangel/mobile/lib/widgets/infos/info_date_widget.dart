import 'package:clubangel/loaders/localizable_loader.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InfoDateWidget extends StatelessWidget {
  static final _releaseDateFormat = DateFormat('dd.MM.yyyy');

  InfoDateWidget(this.board);
  final Board board;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      padding: const EdgeInsets.only(
        top: 5.0,
        right: 20.0,
        bottom: 5.0,
        left: 10.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocalizableLoader.of(context).text("try_again"),
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2.0),
          Text(
            _releaseDateFormat.format(board.releaseDate),
            style: const TextStyle(
              color: const Color(0xFFFEFEFE),
              fontWeight: FontWeight.w300,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
