import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:washee/core/pages/home_screen.dart';
import 'package:washee/core/pages/pages_enum.dart';
import 'package:washee/core/presentation/themes/colors.dart';
import 'package:washee/core/presentation/themes/dimens.dart';
import 'package:washee/core/presentation/themes/themes.dart';

class DoesNotHaveCurrentBookingDialog extends StatefulWidget {
  const DoesNotHaveCurrentBookingDialog({Key? key}) : super(key: key);

  @override
  State<DoesNotHaveCurrentBookingDialog> createState() =>
      _DoesNotHaveCurrentBookingDialogState();
}

class _DoesNotHaveCurrentBookingDialogState
    extends State<DoesNotHaveCurrentBookingDialog> {
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
      height: 420.h,
      width: 754.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Book venligst en tid gennem booking systemet først!",
            style: textStyle.copyWith(
              fontSize: textSize_32,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          Center(
            child: _okButton(context),
          )
        ],
      ),
    );
  }

  Widget _okButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(
                      page: PageNumber.CalendarScreen,
                    )));
      },
      child: Container(
        height: 84.h,
        width: 279.81.w,
        decoration: BoxDecoration(
          color: AppColors.dialogLightGray,
          borderRadius: BorderRadius.circular(20.w),
          border: Border.all(
            color: Colors.white,
            width: 1.w,
          ),
        ),
        child: Center(
          child: Text(
            "OK",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: textSize_32,
            ),
          ),
        ),
      ),
    );
  }
}
