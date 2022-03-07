import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:washee/core/user/user.dart';
import 'package:washee/features/unlock/presentation/widgets/initiate_wash_dialog.dart';
import '../presentation/themes/colors.dart';

class UnlockButton extends StatelessWidget {
  UnlockButton({required this.text, required this.available});
  final String text;
  bool available;
  final User fakeUser = User(token: 1, washCoupon: 14, userName: "Bjarne123");

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320.w,
      height: 100.h,
      child: ElevatedButton(
        child: Text(available ? "Book " + text : text),
        onPressed: () async {
          if (available) {
            if (fakeUser.washCoupon > 0) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return InitiateWashDialog();
                },
              );
            }
          } else {
            // show notAvailableDialog
          }
        },
        style: ElevatedButton.styleFrom(
          primary: available ? AppColors.deepGreen : Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.h),
          ),
        ),
      ),
    );
  }
}
