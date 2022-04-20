import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:washee/core/presentation/themes/colors.dart';
import 'package:washee/core/presentation/themes/dimens.dart';
import 'package:washee/core/presentation/themes/themes.dart';

class OutDatedDateDialog extends StatefulWidget {
  const OutDatedDateDialog({Key? key}) : super(key: key);

  @override
  State<OutDatedDateDialog> createState() => _OutDatedDateDialogState();
}

class _OutDatedDateDialogState extends State<OutDatedDateDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(child: _dialogBox(context)),
    );
  }

  Widget _dialogBox(BuildContext context) {
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
              "Datoen er udløbet",
              style: textStyle.copyWith(
                fontSize: textSize_32,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Center(
            child: _okButton(context),
          )
        ],
      ),
    );
  }

  Widget _okButton(BuildContext context) {
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
        Navigator.of(context).pop();
      },
    );
  }
}
