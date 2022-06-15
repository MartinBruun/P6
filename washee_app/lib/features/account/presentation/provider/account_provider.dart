import 'package:flutter/material.dart';
import 'package:washee/features/account/domain/entities/user_entity.dart';
import 'package:washee/features/account/domain/usecases/auto_sign_in.dart';

class AccountProvider extends ChangeNotifier {
  final AutoSignInUsecase autoSignInUsecase;

  UserEntity currentUser = UserEntity.anonymousUser();
  bool signinIn = false;

  AccountProvider({required this.autoSignInUsecase});

  Future<bool> autoSignIn() async {
    signinIn = true;
    notifyListeners();
    currentUser = await autoSignInUsecase.call(AutoSignInParams());
    signinIn = false;
    notifyListeners();
    if(currentUser.loggedIn){
      return true;
    }
    else{
      return false;
    }
  }
}
