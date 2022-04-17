import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:washee/core/account/user.dart';
import 'package:washee/core/presentation/themes/colors.dart';
import 'package:washee/core/presentation/themes/dimens.dart';
import 'package:washee/core/presentation/themes/themes.dart';
import 'package:washee/features/user_info/presentation/widgets/user_text.dart';
import '../../../booking/presentation/widgets/my_bookings_list.dart';


class UserInfo extends StatefulWidget {
  const UserInfo({ Key? key }) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  TextStyle bigText = textStyle.copyWith(
                  fontSize: textSize_51,
                  fontWeight: FontWeight.w600,
                  color: Colors.white);

  TextStyle smallText = textStyle.copyWith(
                  fontSize: textSize_40,
                  fontWeight: FontWeight.w600,
                  color: Colors.white);
  
  double bottomPadding = 8;

  ActiveUser user = ActiveUser();

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child:Container(
        height: 1000.h,
        width: 900.w,
        decoration: BoxDecoration(
          color: AppColors.fieldItemGray,
          borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: EdgeInsets.all(25),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserText("Brugernavn:", bigText, 0),
              UserText(user.username!, smallText, bottomPadding),
              UserText("Email:", bigText, 0),
              UserText(user.email!, smallText, bottomPadding),
              UserText("Saldo:", bigText,0),
              UserText(user.activeAccount!.balance.toString() + " kr", smallText, bottomPadding),
              MyAccountBookingList(),
            ],
          ),
        )
        )
    );  
  }
}
