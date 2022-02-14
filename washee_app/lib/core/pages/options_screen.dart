import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../presentation/themes/colors.dart';
import '../presentation/themes/dimens.dart';
import '../presentation/themes/themes.dart';
import '../widgets/common_used_widgets.dart';

class OptionsScreen extends StatefulWidget {
  static const routeName = "/options-screen";
  const OptionsScreen({Key? key}) : super(key: key);

  @override
  _OptionsScreenState createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
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
                height: 110.h,
                child: Text(
                  "Welcome to Washee ",
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
                    width: 500.w,
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
