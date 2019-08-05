import 'package:clubangel/widgets/angel_details/angel_detail_widget.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

@visibleForTesting
Function(String) launchTicketsUrl = (url) async {
  if (await canLaunch(url)) {
    await launch(url);
  }
};

class AngelListTileWidget extends StatelessWidget {
  AngelListTileWidget(
    this.show, {
    this.opensEventDetails = true,
  }) : ticketsButtonKey = Key('${show.id}-tickets');

  final Angel show;
  final bool opensEventDetails;
  final Key ticketsButtonKey;

  void _navigateToEventDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AngelDetailWidget(show),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final onTap =
        opensEventDetails ? () => _navigateToEventDetails(context) : null;

    final content = Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0,
      ),
      child: Row(
        children: [
          _ClubInfo(show),
          _DetailedInfo(show),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(top: 1.0),
      child: Material(
        color: Colors.black12,
        child: InkWell(
          onTap: onTap,
          child: content,
        ),
      ),
    );
  }
}

class _ClubInfo extends StatelessWidget {
  _ClubInfo(this.show);
  final Angel show;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: new BorderRadius.all(new Radius.circular(40.0)),
            border: new Border.all(
              color: Colors.white10,
              width: 2.0,
            ),
          ),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(
                "https://avatars1.githubusercontent.com/u/13096942?s=460&v=4"),
            foregroundColor: Colors.white,
            radius: 30.0,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          "FACE",
          style: const TextStyle(fontSize: 14.0, color: Colors.white),
        ),
      ],
    );
  }
}

class _DetailedInfo extends StatelessWidget {
  _DetailedInfo(this.show);
  final Angel show;

  @override
  Widget build(BuildContext context) {
    final decoration = const BoxDecoration(
      border: Border(
        left: BorderSide(
          color: Colors.white,
        ),
      ),
    );

    final content = [
      Text(
        show.title,
        style: const TextStyle(
            fontWeight: FontWeight.w500, fontSize: 14.0, color: Colors.white),
      ),
      const SizedBox(height: 4.0),
      Text(
        show.theaterAndAuditorium + "1234567",
        style: const TextStyle(color: Colors.white70),
      ),
      _PresentationMethodChip(show),
    ];

    return Expanded(
      child: Container(
        decoration: decoration,
        margin: const EdgeInsets.only(left: 12.0),
        padding: const EdgeInsets.only(left: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: content,
        ),
      ),
    );
  }
}

class _PresentationMethodChip extends StatelessWidget {
  _PresentationMethodChip(this.show);
  final Angel show;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.only(top: 4.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: Text(
        show.presentationMethod,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
