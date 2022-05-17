import 'package:flutter_screenutil/flutter_screenutil.dart';

double minHeaderHeight = 130;
double maxHeaderHeight = 150;
double minSliderHeight = 20;
double defaultSliderHeight = 150;

double bottomNavigationBarHeight = 170.h;

double get iconSize_7 => _getAdjustedIconSize(7);
double get iconSize_8 => _getAdjustedIconSize(8);
double get iconSize_9 => _getAdjustedIconSize(9);
double get iconSize_10 => _getAdjustedIconSize(10);
double get iconSize_11 => _getAdjustedIconSize(11);
double get iconSize_12 => _getAdjustedIconSize(12);
double get iconSize_13 => _getAdjustedIconSize(13);
double get iconSize_14 => _getAdjustedIconSize(14);
double get iconSize_15 => _getAdjustedIconSize(15);
double get iconSize_16 => _getAdjustedIconSize(16);
double get iconSize_18 => _getAdjustedIconSize(18);
double get iconSize_20 => _getAdjustedIconSize(20);
double get iconSize_24 => _getAdjustedIconSize(24);
double get iconSize_26 => _getAdjustedIconSize(26);
double get iconSize_28 => _getAdjustedIconSize(28);
double get iconSize_29 => _getAdjustedIconSize(29);
double get iconSize_30 => _getAdjustedIconSize(30);
double get iconSize_32 => _getAdjustedIconSize(32);
double get iconSize_36 => _getAdjustedIconSize(36);
double get iconSize_40 => _getAdjustedIconSize(40);
double get iconSize_42 => _getAdjustedIconSize(42);
double get iconSize_44 => _getAdjustedIconSize(44);
double get iconSize_46 => _getAdjustedIconSize(46);
double get iconSize_48 => _getAdjustedIconSize(48);
double get iconSize_50 => _getAdjustedIconSize(50);
double get iconSize_52 => _getAdjustedIconSize(52);
double get iconSize_54 => _getAdjustedIconSize(54);
double get iconSize_58 => _getAdjustedIconSize(58);
double get iconSize_60 => _getAdjustedIconSize(60);
double get iconSize_64 => _getAdjustedIconSize(64);
double get iconSize_76 => _getAdjustedIconSize(76);
double get iconSize_80 => _getAdjustedIconSize(80);
double get iconSize_120 => _getAdjustedIconSize(120);
double get iconSize_152 => _getAdjustedIconSize(152);
double get iconSize_180 => _getAdjustedIconSize(180);
double get iconSize_192 => _getAdjustedIconSize(192);
double get iconSize_256 => _getAdjustedIconSize(256);
double get iconSize_400 => _getAdjustedIconSize(400);
double get iconSize_500 => _getAdjustedIconSize(500);
double get iconSize_1024 => _getAdjustedIconSize(1024);

// Text sizes
double get defaultTextSize => _getAdjustedTextSize(14);
double get extraLargeTextSize => _getAdjustedTextSize(44);
double get textSize_9 => _getAdjustedTextSize(9);
double get textSize_10 => _getAdjustedTextSize(10);
double get textSize_11 => _getAdjustedTextSize(11);
double get textSize_12 => _getAdjustedTextSize(12);
double get textSize_13 => _getAdjustedTextSize(13);
double get textSize_14 => _getAdjustedTextSize(14);
double get textSize_15 => _getAdjustedTextSize(15);
double get textSize_16 => _getAdjustedTextSize(16);
double get textSize_17 => _getAdjustedTextSize(17);
double get textSize_18 => _getAdjustedTextSize(18);
double get textSize_19 => _getAdjustedTextSize(19);

double get textSize_20 => _getAdjustedTextSize(20);
double get textSize_21 => _getAdjustedTextSize(21);
double get textSize_22 => _getAdjustedTextSize(22);
double get textSize_23 => _getAdjustedTextSize(23);
double get textSize_24 => _getAdjustedTextSize(24);
double get textSize_25 => _getAdjustedTextSize(25);
double get textSize_26 => _getAdjustedTextSize(26);
double get textSize_27 => _getAdjustedTextSize(27);
double get textSize_28 => _getAdjustedTextSize(28);
double get textSize_29 => _getAdjustedTextSize(29);

double get textSize_30 => _getAdjustedTextSize(30);
double get textSize_32 => _getAdjustedTextSize(32);
double get textSize_34 => _getAdjustedTextSize(34);
double get textSize_35 => _getAdjustedTextSize(35);
double get textSize_36 => _getAdjustedTextSize(36);
double get textSize_38 => _getAdjustedTextSize(38);
double get textSize_40 => _getAdjustedTextSize(40);

double get textSize_44 => _getAdjustedTextSize(44);
double get textSize_45 => _getAdjustedTextSize(45);
double get textSize_46 => _getAdjustedTextSize(46);
double get textSize_48 => _getAdjustedTextSize(48);

double get textSize_51 => _getAdjustedTextSize(51);
double get textSize_54 => _getAdjustedTextSize(54);

double get textSize_60 => _getAdjustedTextSize(60);
double get textSize_62 => _getAdjustedTextSize(62);
double get textSize_64 => _getAdjustedTextSize(64);
double get textSize_66 => _getAdjustedTextSize(66);
double get textSize_68 => _getAdjustedTextSize(68);

double get textSize_70 => _getAdjustedTextSize(70);

// when building textTheme data, ScreenUtil() is null
double _getAdjustedTextSize(double size) => ScreenUtil().setSp(size);
// Get scaled Square by width
double _getAdjustedIconSize(double width) => ScreenUtil().setWidth(width);
