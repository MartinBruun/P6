import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:washee/features/account/data/models/web_user.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:washee/core/ui/navigation/pages_enum.dart';
import 'package:washee/core/ui/themes/colors.dart';
import 'package:washee/core/ui/themes/dimens.dart';
import 'package:washee/core/ui/themes/themes.dart';
import 'package:washee/core/standards/base_usecase/usecase.dart';
import 'package:washee/features/account/domain/usecases/sign_in.dart';
import 'package:washee/features/account/presentation/pages/wrong_input.dart';
import 'package:washee/features/account/presentation/provider/sign_in_provider.dart';
import 'package:washee/features/account/presentation/widgets/password_help_box.dart';
import 'package:washee/features/account/presentation/widgets/text_input.dart';
import 'package:washee/features/location/domain/usecases/get_wifi_permission.dart';
import 'package:washee/injection_container.dart';

import 'package:washee/core/ui/navigation/home_screen.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _testController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ActiveUser user = ActiveUser();
  final OutlineInputBorder _borderStyle = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  );

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'Login',
          style: textStyle.copyWith(
            fontSize: textSize_40,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 40.h, top: 24.h),
              child: Container(
                height: 300.h,
                width: 300.w,
                child: Image.asset(
                  'assets/images/washingmachine.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 50.h),
              child: Text(
                "Velkommen til Washee",
                style: textStyle.copyWith(
                    fontSize: textSize_54, fontWeight: FontWeight.bold),
              ),
            ),
            TextInput(
              text: "Email",
              controller: _emailController,
              obscure: false,
              validator: (value) {
                if (value == "") {
                  return "Du har ikke indtastet en Email";
                }
                return null;
              },
            ),
            TextInput(
              text: "Password",
              controller: _passwordController,
              obscure: true,
              validator: (value) {
                if (value == "") {
                  return "Du har ikke indtastet et kodeord";
                }
                return null;
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
              child: Column(
                children: [
                  Container(
                    height: 82.h,
                    width: 279.81.w,
                    child: Consumer<SignInProvider>(
                      builder: (context, data, _) => ElevatedButton(
                        child: data.signingIn
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                "Log ind",
                                style: textStyle.copyWith(
                                    fontSize: textSize_38,
                                    fontWeight: FontWeight.w600),
                              ),
                        style: ElevatedButton.styleFrom(
                            primary: AppColors.dialogLightGray,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.w))),
                        onPressed: () async {
                          if (_formKey.currentState != null) {
                            _formKey.currentState!.save();
                            try {
                              data.updateSignIn(true);
                              var result = await sl<SignInUseCase>().call(
                                  SignInParams(
                                      email: _emailController.text,
                                      password: _passwordController.text));

                              if (result) {
                                if (Platform.isAndroid) {
                                  await sl<GetWifiPermissionUsecase>()
                                      .call(NoParams());
                                }

                                await data.delay();
                                data.updateSignIn(false);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(
                                      page: PageNumber.WasheeScreen,
                                    ),
                                  ),
                                );
                              } else {
                                data.updateSignIn(false);
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
                        },
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return PasswordHelpDialog();
                        },
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 50.h),
                      child: Container(
                        child: Text(
                          "Jeg har glemt mit kodeord!",
                          style: textStyle.copyWith(
                            color: Colors.white,
                            fontSize: textSize_20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
