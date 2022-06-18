import 'package:equatable/equatable.dart';
import 'package:washee/core/standards/base_usecase/usecase.dart';
import 'package:washee/features/account/data/repositories/user_repository.dart';
import 'package:washee/features/account/domain/entities/user_entity.dart';

class SignInUseCase implements UseCase<void, SignInParams> {
  final IUserRepository userRepository;

  SignInUseCase({required this.userRepository});

  @override
  Future<UserEntity> call(SignInParams params) async {
    UserEntity user = await userRepository.signIn(
        params.email, params.password);
    if(user.id == 0){
      user.loggedIn = false;
    }
    else{
      user.loggedIn = true;
    }
    return user;
  }
}

class SignInParams extends Equatable {
  final String email;
  final String password;

  SignInParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
