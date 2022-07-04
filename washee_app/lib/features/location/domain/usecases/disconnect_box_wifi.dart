import 'package:washee/core/base_usecase/usecase.dart';
import 'package:washee/features/location/data/repositories/unlock_repo.dart';

class DisconnectBoxWifiUsecase implements UseCase<bool, NoParams> {
  final UnlockRepository repository;

  DisconnectBoxWifiUsecase({required this.repository});

  @override
  Future<bool> call(NoParams params) async {
    return await repository.disconnectFromBoxWifi();
  }
}
