import 'package:flutter/material.dart';

class SelectLanguageWidget extends StatefulWidget {
  @override
  _SelectLanguageWidgetState createState() => _SelectLanguageWidgetState();
}

class _SelectLanguageWidgetState extends State<SelectLanguageWidget> {
  final List<String> languageList = ["en", "kr"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select language"),
      ),
      body: this.buildLanguageList(),
    );
  }

  buildLanguageList() {
    return ListView.builder(
      itemCount: languageList.length,
      itemBuilder: (BuildContext context, int index) {
        return this.buildLanguageItem(languageList[index]);
      },
    );
  }

  buildLanguageItem(String language) {
    return InkWell(
      onTap: () {
        print(language);
      },
      child: Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(language,
                style: TextStyle(
                  fontSize: 24.0,
                ))),
      ),
    );
  }
}
