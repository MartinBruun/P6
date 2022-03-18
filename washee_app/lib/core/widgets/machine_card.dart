import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:washee/core/user/user.dart';
import 'package:washee/core/washee_box/machine_model.dart';
import '../../features/unlock/presentation/widgets/initiate_wash_dialog.dart';
import '../presentation/themes/colors.dart';
import '../presentation/themes/dimens.dart';
import '../presentation/themes/themes.dart';
import 'wash_timer_on_card.dart';

// ignore: must_be_immutable
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
                  machine.name,
                  style: textStyle.copyWith(
                    fontSize: textSize_30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Spacer(),
              !machine.isAvailable
                  ? WashTimerOnCard(activeMachine: machine)
                  : Padding(
                      padding: EdgeInsets.only(right: 38.w),
                      child: Container(
                        height: 90.h,
                        width: 250.w,
                        child: ElevatedButton(
                          child: Text(
                            "Book now",
                            style: textStyle.copyWith(
                                fontSize: textSize_30,
                                fontWeight: FontWeight.w500),
                          ),
                          onPressed: () async {
                            if (fakeUser.washCoupon > 0) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return InitiateWashDialog(machine: machine);
                                },
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: AppColors.deepGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.h),
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}


//  // Container(
//     //   width: 700.w,
//     //   height: 200.h,
//       child: 
//     // );