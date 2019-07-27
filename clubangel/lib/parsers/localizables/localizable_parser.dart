
import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class LocalizableParser {
  Locale locale;
  static Map<dynamic, dynamic> _localisedValues;

  LocalizableParser(Locale locale) {
    this.locale = locale;
  }

  static LocalizableParser of(BuildContext context) {
    return Localizations.of<LocalizableParser>(context, LocalizableParser);
  }

  static Future<LocalizableParser> load(Locale locale) async {
    LocalizableParser localizableParser = LocalizableParser(locale);
    String path = "assets/localizables/${locale.languageCode}.json";
    String jsonContent = await rootBundle.loadString(path);
    _localisedValues = json.decode(jsonContent);
    return localizableParser;
  }

  get currentLanguage => locale.languageCode;

  String text(String key) {
    return _localisedValues[key] ?? "null";
  }
}