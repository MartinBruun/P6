import 'package:washee/core/standards/base_usecase/usecase.dart';

import '../../../location/domain/repositories/unlock_repository.dart';

class DisconnectBoxWifiUsecase implements UseCase<bool, NoParams> {
  final UnlockRepository repository;

  DisconnectBoxWifiUsecase({required this.repository});

  @override
  Future<bool> call(NoParams params) async {
    return await repository.disconnectFromBoxWifi();
  }
}
