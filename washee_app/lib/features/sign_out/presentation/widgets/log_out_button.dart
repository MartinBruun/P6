import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:washee/core/presentation/themes/colors.dart';
import 'package:washee/core/presentation/themes/dimens.dart';
import 'package:washee/core/presentation/themes/themes.dart';
import 'package:washee/features/sign_out/presentation/pages/logout_question.dart';

class LogOutButton extends StatelessWidget {
  final Function updatePage;

  LogOutButton(this.updatePage);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(254.w, 84.h),
        primary: AppColors.red
      ),
      child: Text(
        'Log ud',
        style: textStyle.copyWith(
          fontSize: textSize_32,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return logoutQuestion(updatePage);
          },
        );
      },
    );
  }
}