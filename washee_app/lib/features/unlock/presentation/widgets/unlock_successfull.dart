import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/presentation/themes/colors.dart';
import '../../../../core/presentation/themes/dimens.dart';
import '../../../../core/presentation/themes/themes.dart';

class UnlockSuccessfull extends StatefulWidget {
  UnlockSuccessfull({Key? key}) : super(key: key);

  @override
  State<UnlockSuccessfull> createState() => _UnlockSuccessfullState();
}

class _UnlockSuccessfullState extends State<UnlockSuccessfull> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Icon(
              Icons.check_circle,
              color: AppColors.main,
              size: 200.h,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 45.h, bottom: 24.h, left: 10.w, right: 10.w),
            child: Container(
              width: 760.w,
              height: 100.h,
              child: Text(
                "Din maskine er nu låst op!",
                style: textStyle.copyWith(
                  fontSize: textSize_40,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Container(
                  height: 84.h,
                  width: 254.w,
                  decoration: BoxDecoration(
                    color: Colors.green[600],
                    borderRadius: BorderRadius.circular(20.h),
                  ),
                  child: Center(
                    child: InkWell(
                      onTap: () async {
                        // sl<StartWashUseCase>().call()
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Start',
                        style: textStyle.copyWith(
                          fontSize: textSize_32,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
