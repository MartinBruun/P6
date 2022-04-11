import 'package:flutter/material.dart';
import 'package:washee/core/presentation/themes/colors.dart';
import 'package:washee/core/presentation/themes/dimens.dart';
import 'package:washee/core/presentation/themes/themes.dart';
import 'package:washee/features/Account/presentation/log_in_button.dart';
import 'package:washee/features/Account/presentation/log_in_status.dart';

class WasheeScreen extends StatelessWidget {
  static const routeName = "/washee-screen";


  
  @override
  Widget build(BuildContext context) {
    var mediaHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: mediaHeight * 0.2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: mediaHeight * 0.3,
              width: mediaHeight * 0.3,
              child: Image.asset(
                'assets/images/washingmachine.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: mediaHeight * 0.05,
            ),
            Padding(
              padding: EdgeInsets.all(mediaHeight * 0.005),
              child: Center(
                child: Container(
                  height: mediaHeight * 0.075,
                  child: FittedBox(
                    child: Text(
                      'WASHEEEEEE',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: mediaHeight * 0.05,
            ),
            LogInStatus()
          ],
        ),
      ),
    );
  }
}
