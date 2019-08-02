import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainTheme {
  const MainTheme();

  static const Color bgndColor = const Color(0xFFfa6464);
  static const Color disabledColor = const Color(0x552B2B2B);
  static const Color enabledButtonColor = const Color(0xFFee6d66);
  static const Color appBarColor = const Color(0xFFfa6464);
  static const Color enabledIconColor = Colors.white;

  static const Color gradientStartColor = const Color(0xFFfa6464);
  static const Color gradientEndColor = const Color(0xFF2d122d);
  static const primaryLinearGradient = const LinearGradient(
      colors: const [gradientStartColor, gradientEndColor],
      stops: const [0.0, 1.0],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      tileMode: TileMode.clamp);

  static const buttonLinearGradient = const LinearGradient(
      colors: const [const Color(0xFFff9494), const Color(0xFFcf4242)],
      stops: const [0.0, 1.0],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      tileMode: TileMode.clamp);

  // paddings
  static const EdgeInsets edgeInsets = EdgeInsets.all(20);
}
