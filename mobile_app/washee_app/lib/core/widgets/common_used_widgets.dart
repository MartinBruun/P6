import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:washee/core/presentation/themes/dimens.dart';
import 'package:washee/core/presentation/themes/themes.dart';

Widget space(
        {double start = 0,
        double top = 0,
        double end = 0,
        double bottom = 0}) =>
    Padding(
      padding: EdgeInsetsDirectional.only(
        start: start,
        top: top,
        end: end,
        bottom: bottom,
      ),
    );

SvgPicture svgAsset(String path,
    {double? size,
    double? width,
    double? height,
    Color? color,
    bool? matchTextDirection,
    Key? key,
    BoxFit fit = BoxFit.contain,
    Alignment alignment = Alignment.center}) {
  const double defaultIconSize = 24.0;
  return SvgPicture.asset(
    'assets/images/$path',
    key: key,
    width: size ?? width ?? defaultIconSize,
    height: size ?? height ?? width ?? defaultIconSize,
    color: color,
    matchTextDirection: matchTextDirection ?? false,
    fit: fit,
    alignment: alignment,
  );
}

Widget pngAsset(
  String path, {
  Color? color,
  bool? matchTextDirection,
  Key? key,
}) {
  return Image.asset(
    'assets/images/$path',
    key: key,
    color: color,
    matchTextDirection: matchTextDirection ?? false,
  );
}

Widget avatarWidget(String imagePath, {BoxFit boxFit = BoxFit.contain}) {
  return FittedBox(
      fit: boxFit,
      child: CachedNetworkImage(
        imageUrl: imagePath,
      ));
}

Row badgeCircle(String badgeInfo, Color budgeColor) {
  final bool isNotEmpty = badgeInfo.isNotEmpty;
  final double opacity = isNotEmpty ? 1 : 0;
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: <Widget>[
      SizedBox(
        height: iconSize_28,
        width: iconSize_28,
        child: AnimatedOpacity(
          opacity: opacity,
          duration: const Duration(milliseconds: 150),
          child: Center(
            child: AnimatedContainer(
              height: iconSize_28,
              width: iconSize_28,
              duration: const Duration(milliseconds: 150),
              curve: Curves.bounceInOut,
              decoration: BoxDecoration(
                color: budgeColor,
                shape: BoxShape.circle,
              ),
              alignment: AlignmentDirectional.center,
              child: Container(
                child: Center(
                  child: Text(
                    badgeInfo,
                    softWrap: true,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    style: textStyle.copyWith(
                      fontSize: textSize_20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
