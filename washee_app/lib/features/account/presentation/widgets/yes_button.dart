import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:washee/core/ui/themes/colors.dart';
import 'package:washee/core/ui/themes/dimens.dart';
import 'package:washee/core/ui/themes/themes.dart';
import 'package:washee/features/account/presentation/providers/account_current_user_provider.dart';

class YesButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var accCurUserProv = Provider.of<AccountCurrentUserProvider>(context, listen:false);
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
            accCurUserProv.signOut();
            Navigator.of(context).pop();
          },
        ));
  }
}
