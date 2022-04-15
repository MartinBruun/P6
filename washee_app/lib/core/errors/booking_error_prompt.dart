import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../presentation/themes/colors.dart';
import '../presentation/themes/dimens.dart';
import '../presentation/themes/themes.dart';
import '../widgets/common_used_widgets.dart';

class BookingErrorPrompt extends StatefulWidget {
  final String message;

  BookingErrorPrompt({required this.message});
  @override
  _BookingErrorPromptState createState() => _BookingErrorPromptState();
}

class _BookingErrorPromptState extends State<BookingErrorPrompt> {
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
          height: 550.h,
          width: 750.w,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 60.h),
                child: svgAsset('question_mark_icon.svg',
                    size: iconSize_120, color: AppColors.lightGray),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50.h, bottom: 50.h),
                child: Container(
                  width: 675.w,
                  height: 135.h,
                  child: Text(
                    widget.message,
                    style: textStyle.copyWith(
                      fontSize: textSize_30,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 84.h,
                      width: 254.w,
                      decoration: BoxDecoration(
                        color: AppColors.dialogLightGray,
                        borderRadius: BorderRadius.circular(20.h),
                        border: Border.all(
                          color: AppColors.backArrowLight,
                          width: 1.h,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'OK',
                          style: textStyle.copyWith(
                            fontSize: textSize_32,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
