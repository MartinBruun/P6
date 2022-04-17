import 'package:washee/core/usecases/usecase.dart';

import '../repositories/unlock_repository.dart';

class DisconnectBoxWifiUsecase implements UseCase<bool, NoParams> {
  final UnlockRepository repository;

  DisconnectBoxWifiUsecase({required this.repository});

  @override
  Future<bool> call(NoParams params) async {
    return await repository.disconnectFromBoxWifi();
  }
}
