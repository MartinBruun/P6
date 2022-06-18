import 'package:equatable/equatable.dart';
import 'package:washee/core/standards/base_usecase/usecase.dart';
import 'package:washee/features/account/data/repositories/user_repository.dart';
import 'package:washee/features/account/domain/entities/user_entity.dart';

class SignOutUsecase implements UseCase<void, SignOutParams> {
  final IUserRepository userRepository;

  SignOutUsecase({required this.userRepository});

  @override
  Future<UserEntity> call(SignOutParams params) async {
    UserEntity user = await userRepository.signOut();
    return user;
  }
}

class SignOutParams extends Equatable {
  SignOutParams();

  @override
  List<Object?> get props => [];
}
