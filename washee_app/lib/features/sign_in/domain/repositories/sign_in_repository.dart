abstract class SignInRepository {
  Future<bool> signIn({required String email, required String password});
}
