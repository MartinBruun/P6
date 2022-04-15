import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/presentation/themes/colors.dart';

class DialogExitCross extends StatelessWidget {
  final Function(BuildContext context) onExitFunction;
  DialogExitCross({
    this.onExitFunction = _defaultOnExitFunction,
  });

  static _defaultOnExitFunction(BuildContext context) async {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 35.h),
      child: Container(
        height: 94.h,
        width: 94.h,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(25.w),
          border: Border.all(
            color: AppColors.borderGray,
            width: 2.h,
          ),
        ),
        child: InkWell(
          onTap: () {
            onExitFunction(context);
          },
          child: Icon(
            Icons.close,
            size: 50.h,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
