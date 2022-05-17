import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:washee/core/presentation/themes/colors.dart';
import 'package:washee/core/presentation/themes/dimens.dart';
import 'package:washee/core/presentation/themes/themes.dart';
import 'package:washee/core/widgets/ok_button.dart';

class DialogBoxOk extends StatelessWidget {
  final String boxMessage;
  final Function? navigate;

  DialogBoxOk({required this.boxMessage, this.navigate});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.dialogLightGray,
        borderRadius: BorderRadius.circular(30.h),
      ),
      height: 350.h,
      width: 754.w,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: 45.h, bottom: 45.h, left: 30.w, right: 30.w),
            child: Text(
              boxMessage,
              style: textStyle.copyWith(
                fontSize: textSize_40,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Center(
            child: OkButton(navigate),
          )
        ],
      ),
    );
  }
}
