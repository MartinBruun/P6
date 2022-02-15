import 'package:flutter/material.dart';

import 'colors.dart';
import 'dimens.dart';

ThemeData getMainTheme() => ThemeData(
    canvasColor: AppColors.createMaterialColor(AppColors.mainBackground),
    primaryColor: AppColors.main,
    hintColor: AppColors.main,
    errorColor: Colors.red,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: ColorScheme.fromSwatch(
            primarySwatch:
                AppColors.createMaterialColor(AppColors.mainBackground))
        .copyWith(secondary: AppColors.createMaterialColor(AppColors.main))
        .copyWith(secondary: AppColors.createMaterialColor(AppColors.main)));

// TextStyles
TextStyle get textStyle => TextStyle(
      fontSize: textSize_14,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ).poppins;

extension FontFamily on TextStyle {
  TextStyle get poppins => copyWith(fontFamily: 'Poppins');
}
