import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:washee/core/user/user.dart';
import 'package:washee/core/washee_box/machine_model.dart';
import 'package:washee/features/unlock/presentation/widgets/initiate_wash_dialog.dart';
import '../presentation/themes/colors.dart';

class UnlockButton extends StatelessWidget {
  UnlockButton({required this.machine});
  MachineModel machine;
  final User fakeUser = User(token: 1, washCoupon: 14, userName: "Bjarne123");

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320.w,
      height: 100.h,
      child: ElevatedButton(
        child:
            Text(machine.isAvailable ? "Book " + machine.name : machine.name),
        onPressed: () async {
          if (machine.isAvailable) {
            if (fakeUser.washCoupon > 0) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return InitiateWashDialog(machine: machine);
                },
              );
            }
          } else {
            // show notAvailableDialog
          }
        },
        style: ElevatedButton.styleFrom(
          primary: machine.isAvailable ? AppColors.deepGreen : Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.h),
          ),
        ),
      ),
    );
  }
}
