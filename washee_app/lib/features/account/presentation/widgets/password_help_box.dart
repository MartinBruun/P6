import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:washee/core/presentation/themes/colors.dart';
import 'package:washee/core/presentation/themes/dimens.dart';
import 'package:washee/core/presentation/themes/themes.dart';
import 'package:washee/core/widgets/ok_button.dart';

class PasswordHelpDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.dialogLightGray,
            borderRadius: BorderRadius.circular(30.h),
          ),
          height: 600.h,
          width: 754.w,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 45.h, bottom: 45.h, left: 30.w, right: 30.w),
                child: Text(
                  "I tilfælde af, at du ikke kan huske dit kodeord ring venligst til en af de følgende:\n\nMartin Bruun Michaelsen: 40134229\nJakob Skov: 53379559\nMarco: 42921884\nRasmus: 28140596",
                  style: textStyle.copyWith(
                    fontSize: textSize_30,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: OkButton(() {
                  Navigator.of(context).pop();
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
