import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:washee/core/presentation/themes/colors.dart';
import 'package:washee/core/presentation/themes/dimens.dart';
import 'package:washee/core/presentation/themes/themes.dart';
import 'package:washee/core/widgets/common_used_widgets.dart';
import 'package:washee/features/sign_out/presentation/widgets/no_buttton.dart';
import 'package:washee/features/sign_out/presentation/widgets/yes_button.dart';

class ConfirmLogOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
          child: Container(
        decoration: BoxDecoration(
          color: AppColors.dialogLightGray,
          borderRadius: BorderRadius.circular(30.h),
        ),
        height: 586.h,
        width: 754.w,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 90.h),
              child: svgAsset('question_mark_icon.svg',
                  size: iconSize_120, color: AppColors.lightGray),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 45.h, bottom: 14.h, left: 10.w, right: 10.w),
              child: Container(
                width: 760.w,
                height: 170.h,
                child: Text(
                  "Er du sikker på at du vil logge ud?",
                  style: textStyle.copyWith(
                    fontSize: textSize_32,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                YesButton(),
                NoButton(),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
