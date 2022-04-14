import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:washee/core/presentation/themes/dimens.dart';
import 'package:washee/core/presentation/themes/themes.dart';

class NoButton extends StatelessWidget {
  const NoButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(254.w, 84.h),
          primary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.h)
          )
        ),
        child: Text(
          'Nej',
          style: textStyle.copyWith(
            fontSize: textSize_32,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      )
    );
  }
}