import 'package:washee/core/externalities/network/network_info.dart';
import 'package:washee/core/standards/time/date_helper.dart';
import 'package:washee/features/location/data/models/box_machine_model.dart';
import 'package:washee/features/location/domain/repositories/unlock_repository.dart';

import '../datasources/unlock_remote.dart';

class UnlockRepositoryImpl implements UnlockRepository {
  UnlockRemote remote;
  NetworkInfo networkInfo;
  DateHelper dateHelper;

  UnlockRepositoryImpl({required this.remote, required this.networkInfo, required this.dateHelper});
  @override
  Future<MachineModel?> unlock(MachineModel machine, Duration duration) async {
    if (await networkInfo.isConnected) {
      var startTime = dateHelper.currentTime();
      machine.startTime = startTime;
      machine.endTime = startTime.add(duration);
      var data = await remote.unlock(machine.toJson(), duration);
      MachineModel updatedMachine = _constructMachineFromResponse(data);
      return updatedMachine;
    } else {
      return null;
    }
  }

  MachineModel _constructMachineFromResponse(
      Map<String, dynamic> machineAsJson) {
    return MachineModel.fromJson(machineAsJson);
  }

  @override
  Future<bool> getWifiPermission() async {
    return await networkInfo.getWifiAccessPermissions();
  }

  @override
  Future<bool> connectToBoxWifi() async {
    return await networkInfo.connectToBoxWifi();
  }

  @override
  Future<bool> disconnectFromBoxWifi() async {
    return await networkInfo.disconnectFromBoxWifi();
  }
}
