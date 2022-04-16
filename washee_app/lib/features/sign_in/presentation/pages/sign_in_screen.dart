import 'package:flutter/material.dart';
import 'package:washee/core/account/user.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:washee/core/presentation/themes/colors.dart';
import 'package:washee/core/presentation/themes/dimens.dart';
import 'package:washee/core/presentation/themes/themes.dart';
import 'package:washee/core/usecases/usecase.dart';
import 'package:washee/features/sign_in/domain/usecases/sign_in.dart';
import 'package:washee/features/sign_in/presentation/pages/wrong_input.dart';
import 'package:washee/features/sign_in/presentation/widgets/text_input.dart';
import 'package:washee/features/unlock/domain/usecases/get_wifi_permission.dart';
import 'package:washee/injection_container.dart';

class SignInScreen extends StatefulWidget {
  final Function callback;

  SignInScreen(this.callback);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ActiveUser user = ActiveUser();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Container(
          alignment: Alignment.center,
          child: ListView(children: [
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextInput("Email", _emailController, false, 
                    (value) {
                      if (value == "") {
                        return "Du har ikke indtastet en Email";
                      }
                      return null;
                    }
                  ),
                  TextInput("Password", _passwordController, true, 
                    (value) {
                      if (value == "") {
                        return "Du har ikke indtastet et kodeord";
                      }
                      return null;
                    }
                  ),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
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
                            if (_formKey.currentState != null) {
                              var valid = _formKey.currentState!.validate();
                              if (!valid) {
                                // show error prompt

                              } else {
                                _formKey.currentState!.save();
                                try {
                                  var result = await sl<SignInUseCase>().call(
                                      SignInParams(
                                          email: _emailController.text,
                                          password: _passwordController.text));

                                  if (result) {
                                    print("something went right! Asking for wifi permissions");
                                    await sl<GetWifiPermissionUsecase>().call(NoParams());

                                    // update the homescreen with the callback function
                                    this.widget.callback();
                                  } else {
                                    print("something went wrong");

                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return IncorrectInput();
                                        });
                                  }
                                } on Exception catch (e) {
                                  print("DioError occured: " + e.toString());

                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return IncorrectInput();
                                      });
                                }
                              }
                            }
                          },
                        ),
                      ))
                ],
              ),
            )
          ])),
    );
  }
}
