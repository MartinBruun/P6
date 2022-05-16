import 'package:washee/core/helpers/authorizer.dart';
import 'package:washee/core/helpers/web_communicator.dart';
import 'package:washee/core/account/account.dart';
import 'package:washee/features/sign_in/domain/repositories/sign_in_repository.dart';

class SignInRepositoryImpl implements SignInRepository {
  Authorizer authorizer;
  WebCommunicator communicator;

  SignInRepositoryImpl({required this.authorizer, required this.communicator});

  @override
  Future<bool> signIn({required String email, required String password}) async {
    return await authorizer.signIn(email: email, password: password);
  }

  @override
  Future<Account> getAccount(Account account) async{
    Map<String,dynamic> accountJson = await communicator.getAccount(account);
    return Account.fromJson(accountJson);
  }
}
