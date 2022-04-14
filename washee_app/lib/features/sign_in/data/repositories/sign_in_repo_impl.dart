import 'package:washee/core/helpers/authorizer.dart';
import 'package:washee/features/sign_in/domain/repositories/sign_in_repository.dart';

class SignInRepositoryImpl implements SignInRepository {
  Authorizer authorizer;

  SignInRepositoryImpl({required this.authorizer});

  @override
  Future<bool> signIn({required String email, required String password}) async {
    return await authorizer.signIn(email: email, password: password);
  }
}
