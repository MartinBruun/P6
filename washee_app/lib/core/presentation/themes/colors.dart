import 'dart:core';

import 'package:flutter/material.dart';

class AppColors {
  static const Color main = Color(0xFF25F860);
  static const Color mainMedium = Color(0xFF07C83C);
  static const Color alreadyBooked = Color(0X00000);
  static const Color red = Color(0xFFC85530);
  static const Color dirtyMain = Color(0xFF203926);
  static const Color dirtyMain2 = Color(0xFF2C693D);
  static const Color selectedGreenMain = Color(0xFF24382A);
  static const Color deepGreen = Color(0xFF12B43F);
  static const Color borderGray = Color(0xFF616161);
  static const Color borderMiddleGray = Color(0xFF666666);
  static const Color fieldItemGray = Color(0xFF383838);
  static const Color disabledGray = Color(0xFFE5E5E5);
  static const Color textDarkGray = Color(0xFF262626);
  static const Color naviBarColor = Color(0xFF1D1D1D);
  static const Color textLightGray = Color(0xFFBDBDBD);
  static const Color mainDarkLight = Color(0xFF272727);
  static const Color mainBackground = Color(0xFF1B1B1B);
  static const Color textMiddleGray = Color(0xFFB2B2B2);
  static const Color indicatorGray = Color(0xFFB3B3B3);
  static const Color middleGray = Color(0xFF424242);
  static const Color lightGray = Color(0xFFE0E0E0);
  static const Color arrowControlGray = Color(0xFF9e9e9e);
  static const Color sportItemGray = Color(0xFF3F3E3E);
  static const Color dialogGray = Color(0xFF5A5A5A);
  static const Color grayScale = Color(0xFF121212);
  static const Color activeTrackGreen = Color(0xFF2E6B40);
  static const Color borderMain = Color(0xFF346A40);
  static const Color dialogLightGray = Color(0xFF545454);
  static const Color backArrowLight = Color(0xFFFFFFFF);
  static const Color borderUHFGray = Color(0xff595959);
  static const Color editPositionBoxGrey = Color(0xFF303030);
  static const Color backupGrey = Color(0xFF616161);

  static MaterialColor createMaterialColor(Color color) {
    final List<double> strengths = <double>[.05];
    final Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((double strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }
}
