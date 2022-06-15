import 'package:flutter/material.dart';
import 'package:washee/features/account/domain/entities/user_entity.dart';
import 'package:washee/features/account/domain/usecases/auto_sign_in.dart';
import 'package:washee/features/account/domain/usecases/sign_in.dart';

class AccountProvider extends ChangeNotifier {
  final AutoSignInUsecase autoSignInUsecase;
  final SignInUseCase signInUsecase;

  UserEntity currentUser = UserEntity.anonymousUser();
  bool signinIn = false;

  AccountProvider({required this.autoSignInUsecase, required this.signInUsecase});

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

  Future<UserEntity> signIn({required String username, required String password}) async {
    signinIn = true;
    notifyListeners();
    currentUser = await signInUsecase.call(SignInParams(email: username, password: password));
    signinIn = false;
    notifyListeners();
    return currentUser;
  }
}
