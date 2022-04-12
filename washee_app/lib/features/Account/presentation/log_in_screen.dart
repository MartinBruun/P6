import 'package:flutter/material.dart';
import 'package:washee/core/helpers/authorizer.dart';
import 'package:washee/core/helpers/web_communicator.dart';
import 'package:washee/core/presentation/themes/colors.dart';
import 'package:washee/core/presentation/themes/dimens.dart';
import 'package:washee/core/presentation/themes/themes.dart';

import 'package:dio/dio.dart'; // SHOULD BE REMOVED WHEN REFACTORED TO PROPERLY USE SINGLETONS!
import 'package:washee/core/account/user.dart'; // Should maybe also be removed? I dunno

class LogInScreen extends StatefulWidget {
  const LogInScreen({ Key? key }) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  
  final OutlineInputBorder _borderStyle = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.white
    ),
    

  );

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void _logIn() async {
    print("attempting to log in");
    print("username is " + usernameController.text);
    print("password is " + passwordController.text);

    Dio dio = new Dio();
    Authorizer authorizer = new AuthorizerImpl(dio: dio);
    await authorizer.getAndSaveTokenToCache(usernameController.text, passwordController.text);
    print("THE TOKEN IS: " + authorizer.token.toString());
    WebCommunicator web = new WebCommunicatorImpl(dio: dio, authorizer: authorizer);
    List<User> allUsers = await web.getAllUsers();
    print("USERS AS USER MODELS!");
    print(allUsers.toString());


    // showDialog(context: context, builder: (builder) {
    //   return AlertDialog(
    //     content: Text(usernameController.text),
    //   );
    // }
    // );
    bool loggedIn = true;
    Navigator.pop(context, {"username": usernameController.text, "loggedIn": loggedIn});
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tilbage')),
      body: Container(
        alignment: Alignment.center,
        child: ListView( 
          children: [ 
            Column(
              children: <Widget> [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    controller: usernameController,
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
                    controller: passwordController,
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      enabledBorder: _borderStyle,
                      focusedBorder: _borderStyle,
                      labelText: 'Indtast kodeord',
                      labelStyle: TextStyle(color: Colors.white)
                    ),
                  )
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Container(
                    height: 40,
                    width: 200,
                    child: ElevatedButton(
                      child: Text("Log ind",
                        style: textStyle.copyWith(
                          fontSize: textSize_45,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: AppColors.deepGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        )
                      ),
                      onPressed: () {
                        _logIn();
                      },
                    ),
                  )
                )
              ],
            )
          ]
        )
        //Text('Page 2', style: TextStyle(color: Colors.white),),
      ),
    );
  }
}