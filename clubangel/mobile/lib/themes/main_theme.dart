import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainTheme {
  const MainTheme();

  static Color bgndColor = const Color(0xFFFF8A65);
  static const Color buttonColor = const Color(0xFF2DB5F5);
  static const Color disabledColor = const Color(0x552B2B2B);
  static const Color enabledColor = const Color(0xFFee6d66);
  static const Color appBarColor = const Color(0xFFFF8A65);

  static const Color gradientStartColor = const Color(0xFFfbab66);
  static const Color gradientEndColor = const Color(0xFFf7418c);
  static const primaryLinearGradient = const LinearGradient(
      colors: const [gradientStartColor, gradientEndColor],
      stops: const [0.0, 1.0],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      tileMode: TileMode.clamp);

  static const buttonLinearGradient = const LinearGradient(
      colors: const [const Color(0xFFee8f66), const Color(0xFFf7418c)],
      stops: const [0.0, 1.0],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      tileMode: TileMode.clamp);
}
