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
      var data = await remote.unlock(machine, duration);
      MachineModel updatedMachine = _constructMachineFromResponse(data);
      print(updatedMachine);
      return updatedMachine;
    } else {
      return null;
    }
  }

  MachineModel _constructMachineFromResponse(
      Map<String, dynamic> machineAsJson) {
    print(machineAsJson);
    return MachineModel.fromJson(machineAsJson);
  }
}
