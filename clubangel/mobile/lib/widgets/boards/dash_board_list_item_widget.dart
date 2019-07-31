import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'board_infomation_widget.dart';
import 'board_poster.dart';

class DashBoardListItemWidget extends StatelessWidget {
  DashBoardListItemWidget({
    @required this.board,
    @required this.onTapped,
    @required this.showReleaseDateInformation,
  });

  final Board board;
  final VoidCallback onTapped;
  final bool showReleaseDateInformation;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 225,
        padding: EdgeInsets.all(5),
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.white),
          child: Stack(
            fit: StackFit.expand,
            children: [
              BoardPoster(event: board),
              _TextualInfo(board),
              Positioned(
                top: 10.0,
                child: Visibility(
                  visible: showReleaseDateInformation,
                  child: BoardInfomationWidget(board),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onTapped,
                  child: Container(),
                ),
              ),
            ],
          ),
        ));
  }
}

class _TextualInfo extends StatelessWidget {
  _TextualInfo(this.board);
  final Board board;

  BoxDecoration _buildGradientBackground() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        stops: [0.0, 0.7, 0.7],
        colors: [
          Colors.black,
          Colors.transparent,
          Colors.transparent,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _buildGradientBackground(),
      padding: const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
      child: _TextualInfoContent(board),
    );
  }
}

class _TextualInfoContent extends StatelessWidget {
  _TextualInfoContent(this.board);
  final Board board;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          board.title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          board.genres,
          style: const TextStyle(
            fontSize: 12.0,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}
