import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class InfoDefaultGridItemWidget extends StatelessWidget {
  InfoDefaultGridItemWidget({
    @required this.onTapped,
  });

  final VoidCallback onTapped;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(color: Colors.white),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // EventPoster(event: event),
          Positioned(
            top: 10.0,
            child: Visibility(
              child: Text("1111",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  )),
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
    );
  }
}
