import 'package:washee/core/standards/base_usecase/usecase.dart';
import 'package:washee/features/location/data/repositories/unlock_repo.dart';

class ConnectBoxWifiUsecase implements UseCase<bool, NoParams> {
  final UnlockRepository repository;

  ConnectBoxWifiUsecase({required this.repository});

  @override
  Future<bool> call(NoParams params) async {
    return await repository.connectToBoxWifi();
  }
}
