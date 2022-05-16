import 'package:flutter/material.dart';

class SignInProvider extends ChangeNotifier {
  bool _signingIn = false;

  bool get signingIn => _signingIn;

  updateSignIn(bool value) async {
    if (value) {
      _signingIn = true;
    } else {
      _signingIn = false;
    }
    notifyListeners();
  }

  Future delay() async {
    await Future.delayed(Duration(seconds: 2));
  }
}
