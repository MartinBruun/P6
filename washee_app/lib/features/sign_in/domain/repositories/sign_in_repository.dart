import 'package:washee/core/account/account.dart';

abstract class SignInRepository {
  Future<bool> signIn({required String email, required String password});
  Future<Account> getAccount(Account account);
}
