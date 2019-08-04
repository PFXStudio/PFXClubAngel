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
        "클럽명/엠디/모임일/현인원/총인원/총비용/엔비/주류구성/테이블위치/이미지첨부/유투브링크/제목/내용",
        style: const TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
        ),
      ),

      secondChild: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: FlatButton(
                      padding: EdgeInsets.only(top: 5),
                      onPressed: () => {},
                      child: Row(
                        // Replace with a Row for horizontal icon + text
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.cocktail,
                            color: MainTheme.enabledButtonColor,
                            size: 18.0,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                          ),
                          Text("클럽명은옥타곤",
                              style: TextStyle(
                                  color: MainTheme.enabledButtonColor,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                ),
                Expanded(
                    flex: 1,
                    child: FlatButton(
                      padding: EdgeInsets.only(top: 5),
                      onPressed: () => {},
                      child: Row(
                        // Replace with a Row for horizontal icon + text
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.jenkins,
                            color: MainTheme.enabledButtonColor,
                            size: 18.0,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                          ),
                          Text("엠디명은김상무",
                              style: TextStyle(
                                  color: MainTheme.enabledButtonColor,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                ),
                Expanded(
                    flex: 1,
                    child: FlatButton(
                      padding: EdgeInsets.only(top: 5),
                      onPressed: () => {},
                      child: Row(
                        // Replace with a Row for horizontal icon + text
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.calendar,
                            color: Colors.black54,
                            size: 18.0,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                          ),
                          Text("2019년9월19일",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: FlatButton(
                      padding: EdgeInsets.only(top: 5),
                      onPressed: () => {},
                      child: Row(
                        // Replace with a Row for horizontal icon + text
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.cocktail,
                            color: MainTheme.enabledButtonColor,
                            size: 18.0,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                          ),
                          Text("클럽명은옥타곤",
                              style: TextStyle(
                                  color: MainTheme.enabledButtonColor,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                ),
                Expanded(
                    flex: 1,
                    child: FlatButton(
                      padding: EdgeInsets.only(top: 5),
                      onPressed: () => {},
                      child: Row(
                        // Replace with a Row for horizontal icon + text
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.jenkins,
                            color: MainTheme.enabledButtonColor,
                            size: 18.0,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                          ),
                          Text("엠디명은김상무",
                              style: TextStyle(
                                  color: MainTheme.enabledButtonColor,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                ),
                Expanded(
                    flex: 1,
                    child: FlatButton(
                      padding: EdgeInsets.only(top: 5),
                      onPressed: () => {},
                      child: Row(
                        // Replace with a Row for horizontal icon + text
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.calendar,
                            color: MainTheme.enabledButtonColor,
                            size: 18.0,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                          ),
                          Text("2019년9월19일",
                              style: TextStyle(
                                  color: MainTheme.enabledButtonColor,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )),
              ],
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
