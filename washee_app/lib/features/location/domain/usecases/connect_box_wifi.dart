import 'package:washee/core/standards/base_usecase/usecase.dart';

import '../../../location/domain/repositories/unlock_repository.dart';

class ConnectBoxWifiUsecase implements UseCase<bool, NoParams> {
  final UnlockRepository repository;

  ConnectBoxWifiUsecase({required this.repository});

  @override
  Future<bool> call(NoParams params) async {
    return await repository.connectToBoxWifi();
  }
}
