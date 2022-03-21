import 'package:washee/core/network/network_info.dart';
import 'package:washee/core/washee_box/machine_model.dart';
import 'package:washee/features/unlock/domain/repositories/unlock_repository.dart';

import '../datasources/unlock_remote.dart';

class UnlockRepositoryImpl implements UnlockRepository {
  UnlockRemote remote;
  NetworkInfo networkInfo;

  UnlockRepositoryImpl({required this.remote, required this.networkInfo});
  @override
  Future<MachineModel?> unlock(MachineModel machine, Duration duration) async {
    if (await networkInfo.isConnected) {
      var response = await remote.unlock(machine, duration);
      return _constructMachineFromResponse(response.data);
    }
    return null;
  }

  MachineModel _constructMachineFromResponse(
      Map<String, dynamic> machineAsJson) {
    return MachineModel.fromJson(machineAsJson);
  }
}
