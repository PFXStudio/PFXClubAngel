import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:clubangel/loaders/localizable_loader.dart';
import 'package:clubangel/themes/main_theme.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class AngelDetailContentsWidget extends StatefulWidget {
  AngelDetailContentsWidget(this.angel);
  final Angel angel;

  @override
  _AngelDetailContentsWidgetState createState() =>
      _AngelDetailContentsWidgetState();
}

class _AngelDetailContentsWidgetState extends State<AngelDetailContentsWidget> {
  bool _isExpandable;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _isExpandable = true;
    // TODO : expandable.
    // _isExpandable = widget.angel.shortSynopsis != widget.angel.synopsis;
  }

  void _toggleExpandedState() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final content = AnimatedCrossFade(
      // TODO : synopsis
      firstChild: Text(
        "모임일/클럽명/엠디/현인원-총인원/총비용-엔비/주류구성/이미지첨부/유투브링크/제목/내용\nas\n\nsefsf",
        style: const TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      secondChild: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FlatButton(
                      child: Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.calendar,
                            color: Colors.black54,
                            size: 14.0,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                          ),
                          Text(
                            "2019년9월19일 토",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                    FlatButton(
                      child: Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.mapMarkerAlt,
                            color: Colors.black54,
                            size: 14.0,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                          ),
                          Text(
                            "클럽명은옥타곤",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                    FlatButton(
                      child: Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.idCard,
                            color: Colors.black54,
                            size: 14.0,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                          ),
                          Text(
                            "엠디명은김상무",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FlatButton(
                      child: Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.users,
                            color: Colors.black54,
                            size: 14.0,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                          ),
                          Text(
                            "총7명 - 2자리남음",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                    FlatButton(
                      child: Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.cocktail,
                            color: Colors.black54,
                            size: 14.0,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                          ),
                          Text(
                            "3하드 2샴 + 섭샴",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                    FlatButton(
                      child: Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.wonSign,
                            color: Colors.black54,
                            size: 14.0,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                          ),
                          Text(
                            "총 150만원 - 엔 21만원",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            Text(
              "seeennddddd....\n asdfasdfddddfadfa\n\ndsfasdgadsa",
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          ]),
      crossFadeState:
          _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: kThemeAnimationDuration,
    );

    return InkWell(
      onTap: _isExpandable ? _toggleExpandedState : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Title(_isExpandable, _isExpanded),
            const SizedBox(height: 8.0),
            content,
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  _Title(this.expandable, this.expanded);
  final bool expandable;
  final bool expanded;

  Widget _buildExpandCollapsePrompt(String contents) {
    const captionStyle = TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w600,
      color: MainTheme.enabledButtonColor,
    );

    return Text(
      expanded ? contents : contents,
      style: captionStyle,
    );
  }

  @override
  Widget build(BuildContext context) {
    final content = <Widget>[
      Text(
        LocalizableLoader.of(context).text("board_contents_text"),
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    ];

    if (expandable) {
      content.add(Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: _buildExpandCollapsePrompt(
            LocalizableLoader.of(context).text("board_contents_more_text")),
      ));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: content,
    );
  }
}
