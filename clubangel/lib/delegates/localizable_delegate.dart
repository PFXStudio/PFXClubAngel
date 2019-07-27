import 'dart:async';

import 'package:clubangel/managers/application.dart';
import 'package:clubangel/parsers/localizables/localizable_parser.dart';
import 'package:flutter/material.dart';

class LocalizableDelegate extends LocalizationsDelegate<LocalizableParser> {
  final Locale newLocale;

  const LocalizableDelegate({
    this.newLocale
  });

  @override
  bool isSupported(Locale locale) {
    return application.supportedLanguagesCodes.contains(locale.languageCode);
  }

  @override
  Future<LocalizableParser> load(Locale locale) {
    return LocalizableParser.load(newLocale ?? locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<LocalizableParser> old) {
    return true;
  }
}