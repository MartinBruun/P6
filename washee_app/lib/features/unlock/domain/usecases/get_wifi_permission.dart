import 'package:washee/core/usecases/usecase.dart';

import '../repositories/unlock_repository.dart';

class GetWifiPermissionUsecase implements UseCase<bool, NoParams> {
  final UnlockRepository repository;

  GetWifiPermissionUsecase({required this.repository});

  @override
  Future<bool> call(NoParams params) async {
    return await repository.getWifiPermission();
  }
}
