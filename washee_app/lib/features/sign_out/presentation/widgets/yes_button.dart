import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:washee/core/account/user.dart';
import 'package:washee/core/presentation/themes/colors.dart';
import 'package:washee/core/presentation/themes/dimens.dart';
import 'package:washee/core/presentation/themes/themes.dart';

import '../../domain/usecases/log_out.dart';

class YesButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              fixedSize: Size(254.w, 84.h),
              primary: AppColors.deepGreen,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.h))),
          child: Text(
            'Ja',
            style: textStyle.copyWith(
              fontSize: textSize_32,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          onPressed: () {
            // breaking architecture!
            LogOutUseCase().call(LogoutParams(
              user: ActiveUser(),
            ));
            Navigator.of(context).pop();
          },
        ));
  }
}
