import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:washee/features/account/data/models/web_user.dart';
import 'package:washee/core/ui/themes/colors.dart';
import 'package:washee/core/ui/themes/dimens.dart';
import 'package:washee/core/ui/themes/themes.dart';
import 'package:washee/features/account/presentation/widgets/user_text.dart';
import 'package:washee/features/booking/presentation/widgets/my_bookings_list.dart';

class UserInfo extends StatefulWidget {
  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  ActiveUser user = ActiveUser();

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: 1050.h,
        width: 900.w,
        decoration: BoxDecoration(
            color: AppColors.fieldItemGray,
            borderRadius: BorderRadius.circular(20.h)),
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            children: [
              UserText(
                textInfo: "Brugernavn",
                textValue: user.username!,
              ),
              UserText(
                textInfo: "Email",
                textValue: user.email!,
              ),
              UserText(
                textInfo: "Saldo",
                textValue: user.activeAccount!.balance.toString() + " kr",
              ),
              SizedBox(
                height: 75.h,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: Center(
                    child: Text(
                  "Mine Bookings",
                  style: textStyle.copyWith(
                    fontSize: textSize_32,
                  ),
                )),
              ),
              Expanded(child: MyAccountBookingList()),
            ],
          ),
        ));
  }
}
