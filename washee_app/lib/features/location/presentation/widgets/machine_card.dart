import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:washee/features/account/domain/entities/user_entity.dart';
import 'package:washee/features/account/presentation/provider/account_current_user_provider.dart';
import 'package:washee/features/location/data/models/box_machine_model.dart';
import 'package:washee/injection_container.dart';
import 'package:washee/features/booking/domain/usecases/has_current_booking.dart';
import 'package:washee/features/location/presentation/widgets/please_login_dialog.dart';
import '../../../location/presentation/widgets/initiate_wash_dialog.dart';
import 'package:washee/features/location/presentation/widgets/does_not_have_current_booking_dialog.dart';
import '../../../../core/ui/themes/colors.dart';
import '../../../../core/ui/themes/dimens.dart';
import '../../../../core/ui/themes/themes.dart';
import 'wash_timer_on_card.dart';

// ignore: must_be_immutable
class MachineCard extends StatelessWidget {
  MachineCard({required this.machine});
  MachineModel machine;

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
                    fontSize: textSize_35,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Spacer(),
              !machine.isAvailable
                  ? machine.activated
                      ? WashTimerOnCard(activeMachine: machine)
                      : Padding(
                          padding: EdgeInsets.only(right: 30.w),
                          child: Container(
                            height: 90.h,
                            width: 250.w,
                            child: ElevatedButton(
                              child: Text(
                                "Aktiver",
                                style: textStyle.copyWith(
                                    fontSize: textSize_30,
                                    fontWeight: FontWeight.w500),
                              ),
                              onPressed: () async {
                                _cardPressed(context, machine);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: AppColors.deepGreen,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.h),
                                ),
                                elevation: 2,
                              ),
                            ),
                          ),
                        )
                  : Padding(
                      padding: EdgeInsets.only(right: 38.w),
                      child: Container(
                        height: 90.h,
                        width: 250.w,
                        child: ElevatedButton(
                          child: Text(
                            "Book",
                            style: textStyle.copyWith(
                                fontSize: textSize_30,
                                fontWeight: FontWeight.w500),
                          ),
                          onPressed: () async {
                            _cardPressed(context, machine);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: AppColors.deepGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.h),
                            ),
                            elevation: 2,
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

  void _cardPressed(BuildContext context, MachineModel machine) async {
    var userProvider = Provider.of<AccountCurrentUserProvider>(context,listen:false);
    UserEntity user = userProvider.currentUser;
    if (user.loggedIn && user.activeAccount != null) {
      if (true ==
          await sl<HasCurrentBookingUseCase>().call(HasCurrentBookingParams(
              accountID: user.activeAccount!.id,
              machineID: int.parse(machine.machineID)))) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return InitiateWashDialog(machine: machine);
          },
        );
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return DoesNotHaveCurrentBookingDialog();
            });
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return PleaseLoginDialog();
        },
      );
    }
  }
}
