import 'package:flutter/material.dart';
import 'package:washee/core/presentation/themes/dimens.dart';
import 'package:washee/core/presentation/themes/themes.dart';
import 'package:washee/features/sign_out/presentation/widgets/log_out_button.dart';
import 'package:washee/features/user_info/presentation/widgets/user_info.dart';

class WasheeScreen extends StatelessWidget {
  static const routeName = "/washee-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: LogOutButton(),
          centerTitle: true,
          title: Text(
            "WASHEE",
            style: textStyle.copyWith(
                fontSize: textSize_40, fontWeight: FontWeight.w600),
          )),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: UserInfo()),
          ],
        ),
      ),
    );
  }
}
