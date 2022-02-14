import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../presentation/themes/colors.dart';
import '../presentation/themes/dimens.dart';
import '../presentation/themes/themes.dart';
import '../widgets/common_used_widgets.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: BookDialog(),
    );
  }
}

class BookDialog extends StatelessWidget {
  const BookDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
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
              child: svgAsset('question_mark_icon.svg',
                  size: iconSize_120, color: AppColors.lightGray),
            ),
            Padding(
              padding: EdgeInsets.only(top: 45.h, bottom: 24.h),
              child: Container(
                width: 600.w,
                height: 180.h,
                child: Text(
                  "Welcome, please choose an option",
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
                InkWell(
                  onTap: () {
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => MyHomePage(),
                    //     ));
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
                        "Book Laundry Machine",
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
    );
  }
}
