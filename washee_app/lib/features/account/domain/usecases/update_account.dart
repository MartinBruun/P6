import 'package:washee/features/account/data/models/web_user.dart';
import 'package:washee/core/standards/base_usecase/usecase.dart';
import 'package:washee/features/account/data/models/web_account.dart';

import '../repositories/sign_in_repository.dart';

class UpdateAccountUseCase implements UseCase<void, NoParams> {
  final SignInRepository repository;

  UpdateAccountUseCase({required this.repository});

  @override
  Future<bool> call(NoParams) async {
    ActiveUser user = ActiveUser();
    Account updatedAccount = await repository.getAccount(user.activeAccount!);
    user.upDateAccount(updatedAccount);
    return true;
  }
}