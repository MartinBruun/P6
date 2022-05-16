import 'package:equatable/equatable.dart';
import 'package:washee/core/usecases/usecase.dart';

import '../repositories/sign_in_repository.dart';

class SignInUseCase implements UseCase<void, SignInParams> {
  final SignInRepository repository;

  SignInUseCase({required this.repository});

  @override
  Future<bool> call(SignInParams params) async {
    return await repository.signIn(
        email: params.email, password: params.password);
  }
}

class SignInParams extends Equatable {
  final String email;
  final String password;

  SignInParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
