import 'package:flutter/material.dart';
import 'package:washee/core/presentation/themes/colors.dart';
import 'package:washee/core/presentation/themes/dimens.dart';
import 'package:washee/core/presentation/themes/themes.dart';
import 'package:washee/features/sign_in/presentation/pages/sign_in_screen.dart';

import '../../../../core/account/user.dart';

class LogInButton extends StatefulWidget {
  @override
  State<LogInButton> createState() => _LogInButtonState();
}

class _LogInButtonState extends State<LogInButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0.005),
      child: Container(
        height: 70,
        width: 200,
        child: ElevatedButton(
          child: Text(
            "Log ind",
            style: textStyle.copyWith(
                fontSize: textSize_54, fontWeight: FontWeight.w600),
          ),
          style: ElevatedButton.styleFrom(
              primary: AppColors.deepGreen,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          onPressed: () {},
        ),
      ),
    );
  }

  void _openLogInScreen() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignInScreen()));
    ActiveUser user = ActiveUser();
    //print("username: " + user.username.toString());

    //print("user balance: " + user.account!.balance.toString());
  }
}
