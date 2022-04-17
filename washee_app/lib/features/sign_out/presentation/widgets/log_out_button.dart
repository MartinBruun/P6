import 'package:flutter/material.dart';
import 'package:washee/core/presentation/themes/dimens.dart';
import 'package:washee/core/presentation/themes/themes.dart';
import 'package:washee/features/sign_out/presentation/pages/logout_question.dart';

class LogOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ConfirmLogOut();
            },
          );
        },
        child: Text(
          'Log ud',
          style: textStyle.copyWith(
            fontSize: textSize_25,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
