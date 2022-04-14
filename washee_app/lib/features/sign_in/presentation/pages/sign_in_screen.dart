import 'package:flutter/material.dart';
import 'package:washee/core/presentation/themes/colors.dart';
import 'package:washee/core/presentation/themes/dimens.dart';
import 'package:washee/core/presentation/themes/themes.dart';
import 'package:washee/features/sign_in/domain/usecases/sign_in.dart';
import 'package:washee/injection_container.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final OutlineInputBorder _borderStyle = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  );

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tilbage')),
      body: Container(
          alignment: Alignment.center,
          child: ListView(children: [
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    controller: _usernameController,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      enabledBorder: _borderStyle,
                      focusedBorder: _borderStyle,
                      labelText: 'Indtast brugernavn',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                          enabledBorder: _borderStyle,
                          focusedBorder: _borderStyle,
                          labelText: 'Indtast kodeord',
                          labelStyle: TextStyle(color: Colors.white)),
                    )),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Container(
                      height: 40,
                      width: 200,
                      child: ElevatedButton(
                        child: Text(
                          "Log ind",
                          style: textStyle.copyWith(
                              fontSize: textSize_45,
                              fontWeight: FontWeight.w600),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: AppColors.deepGreen,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onPressed: () async {
                          try {
                            var result = await sl<SignInUseCase>().call(
                                SignInParams(
                                    email: _usernameController.text,
                                    password: _passwordController.text));

                            if (result) {
                              print("IT WORKED");
                              // navigate
                            } else {
                              // let the user know that something went wrong
                            }
                          } on Exception catch (e) {
                            print("DioError occured: " + e.toString());
                          }
                        },
                      ),
                    ))
              ],
            )
          ])),
    );
  }
}
