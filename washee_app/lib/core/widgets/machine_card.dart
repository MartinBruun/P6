import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:washee/core/user/user.dart';
import 'package:washee/core/washee_box/machine_model.dart';
import '../presentation/themes/colors.dart';
import '../presentation/themes/dimens.dart';
import '../presentation/themes/themes.dart';
import 'wash_timer_on_card.dart';

class MachineCard extends StatelessWidget {
  MachineCard({required this.machine});
  MachineModel machine;
  final User fakeUser = User(token: 1, washCoupon: 14, userName: "Bjarne123");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 33.w, right: 33.w, bottom: 24.h),
      child: Container(
        height: 200.h,
        width: 935.w,
        decoration: BoxDecoration(
          color: AppColors.middleGray,
          borderRadius: BorderRadius.circular(20.h),
          border: !machine.isAvailable
              ? Border.all(
                  color: AppColors.red,
                  width: 10.h,
                )
              : null,
        ),
        child: Padding(
          padding:
              EdgeInsets.only(left: 37.w, right: 47.w, bottom: 28.h, top: 28.h),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  machine.isAvailable ? "Book " + machine.name : machine.name,
                  style: textStyle.copyWith(
                    fontSize: textSize_30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Spacer(),
              WashTimerOnCard(activeMachine: machine),
            ],
          ),
        ),
      ),
    );
  }
}


 // Container(
    //   width: 700.w,
    //   height: 200.h,
    //   child: ElevatedButton(
    //     child:
    //         Text(machine.isAvailable ? "Book " + machine.name : machine.name),
    //     onPressed: () async {
    //       if (machine.isAvailable) {
    //         if (fakeUser.washCoupon > 0) {
    //           showDialog(
    //             context: context,
    //             builder: (BuildContext context) {
    //               return InitiateWashDialog(machine: machine);
    //             },
    //           );
    //         }
    //       } else {
    //         // show notAvailableDialog
    //       }
    //     },
    //     style: ElevatedButton.styleFrom(
    //       primary: machine.isAvailable ? AppColors.deepGreen : Colors.red,
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(20.h),
    //       ),
    //     ),
    //   ),
    // );