import 'package:equatable/equatable.dart';
import 'package:washee/core/standards/base_usecase/usecase.dart';
import 'package:washee/features/account/data/repositories/user_repository.dart';
import 'package:washee/features/account/domain/entities/user_entity.dart';

class AutoSignInUsecase implements UseCase<void, AutoSignInParams> {
  final IUserRepository userRepository;

  AutoSignInUsecase({required this.userRepository});

  @override
  Future<UserEntity> call(AutoSignInParams params) async {
    UserEntity user = await userRepository.autoSignIn();
    if(user.id == 0){
      user.loggedIn = false;
    }
    else{
      user.loggedIn = true;
    }
    return user;
  }
}

class AutoSignInParams extends Equatable {
  AutoSignInParams();

  @override
  List<Object?> get props => [];
}
