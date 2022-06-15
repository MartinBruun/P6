

import 'package:flutter/cupertino.dart';

class AccountLanguageProvider extends ChangeNotifier {
  String activeLanguage = "danish";

  AccountLanguageProvider();

  String getText(String widgetName, String purpose){
    return shownText[widgetName][purpose][activeLanguage];
  }

  Map<String,dynamic> shownText = {
    "SignInPage": {
      "presentationText": {
        "english": "Welcome to Washee",
        "danish": "Velkommen til Washee"
      },
      "buttonText": {
        "english": "Login",
        "danish": "Log ind"
      },
      "usernameField": {
        "english": "Email",
        "danish": "Email"
      },
      "passwordField": {
        "english": "Password",
        "danish": "Password"
      }
    }
  };
}
