import 'package:washee/core/standards/base_usecase/usecase.dart';
import 'package:washee/features/account/data/repositories/account_repository_impl.dart';
import 'package:washee/features/account/data/repositories/user_repository.dart';
import 'package:washee/features/account/domain/entities/account_entity.dart';

class UpdateAccountUseCase implements UseCase<void, NoParams> {
  final IUserRepository userRepository;
  final IAccountRepository accountRepository;

  UpdateAccountUseCase({required this.accountRepository, required this.userRepository});

  @override
  Future<AccountEntity> call(NoParams) async {
    throw UnimplementedError();
  }
}