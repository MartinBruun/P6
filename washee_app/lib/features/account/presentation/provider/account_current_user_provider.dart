import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:washee/features/account/domain/entities/user_entity.dart';
import 'package:washee/features/account/domain/usecases/auto_sign_in.dart';
import 'package:washee/features/account/domain/usecases/sign_in.dart';
import 'package:washee/features/account/domain/usecases/sign_out.dart';

class AccountCurrentUserProvider extends ChangeNotifier {
  final AutoSignInUsecase autoSignInUsecase;
  final SignInUseCase signInUsecase;
  final SignOutUsecase signOutUsecase;

  late UserEntity currentUser = UserEntity.anonymousUser();
  late bool signinIn = false;

  AccountCurrentUserProvider({required this.autoSignInUsecase, required this.signInUsecase, required this.signOutUsecase});

  Future<void> autoSignIn() async {
    signinIn = true;
    notifyListeners();
    currentUser = await autoSignInUsecase.call(AutoSignInParams());
    signinIn = false;
    notifyListeners();
  }

  Future<void> signIn({required String username, required String password}) async {
    signinIn = true;
    notifyListeners();
    currentUser = await signInUsecase.call(SignInParams(email: username, password: password));
    signinIn = false;
    notifyListeners();
  }

  Future<void> signOut() async {
    signinIn = true;
    notifyListeners();
    currentUser = await signOutUsecase.call(SignOutParams(userLoggingOut: currentUser));
    signinIn = false;
    notifyListeners();
  }
}
