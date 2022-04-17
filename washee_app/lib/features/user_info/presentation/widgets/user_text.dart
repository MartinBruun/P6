import 'package:flutter/material.dart';
import 'package:washee/core/presentation/themes/dimens.dart';
import 'package:washee/core/presentation/themes/themes.dart';

class UserText extends StatelessWidget {
  final String textInfo;
  final String textValue;

  UserText({required this.textInfo, required this.textValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                textInfo + ": ",
                style: textStyle.copyWith(
                  fontSize: textSize_40,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              Text(
                textValue,
                style: textStyle.copyWith(
                  fontSize: textSize_35,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.white,
            thickness: 1.0,
          )
        ],
      ),
    );
  }
}
