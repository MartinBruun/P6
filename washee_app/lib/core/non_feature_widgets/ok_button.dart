import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:washee/core/presentation/themes/colors.dart';
import 'package:washee/core/presentation/themes/dimens.dart';
import 'package:washee/core/presentation/themes/themes.dart';

class OkButton extends StatelessWidget {
  final Function? navigate;

  OkButton(this.navigate);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          fixedSize: Size(254.w, 84.h), primary: AppColors.deepGreen),
      child: Text(
        'Ok',
        style: textStyle.copyWith(
          fontSize: textSize_32,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      onPressed: () {
        if (navigate != null) {
          navigate!();
        } else {
          Navigator.of(context).pop();
        }
      },
    );
  }
}
