import 'dart:async';

import 'package:clubangel/loaders/localizable_loader.dart';
import 'package:clubangel/managers/localizable_manager.dart';
import 'package:flutter/material.dart';

class LocalizableDelegate extends LocalizationsDelegate<LocalizableLoader> {
  final Locale newLocale;

  const LocalizableDelegate({this.newLocale});

  @override
  bool isSupported(Locale locale) {
    return localizableManager.supportedLanguagesCodes
        .contains(locale.languageCode);
  }

  @override
  Future<LocalizableLoader> load(Locale locale) {
    return LocalizableLoader.load(newLocale ?? locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<LocalizableLoader> old) {
    return true;
  }
}
