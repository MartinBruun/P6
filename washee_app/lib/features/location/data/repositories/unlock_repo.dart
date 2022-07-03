import 'package:washee/core/standards/time/date_helper.dart';
import 'package:washee/features/location/data/models/box_machine_model.dart';

import '../datasources/unlock_remote.dart';

abstract class UnlockRepository {
  Future<MachineModel?> unlock(MachineModel machine, Duration duration);
  Future<bool> getWifiPermission();
  Future<bool> connectToBoxWifi();
  Future<bool> disconnectFromBoxWifi();
}

class UnlockRepositoryImpl implements UnlockRepository {
  UnlockRemote remote;
  DateHelper dateHelper;

  UnlockRepositoryImpl({required this.remote, required this.dateHelper});
  @override
  Future<MachineModel?> unlock(MachineModel machine, Duration duration) async {
    var startTime = dateHelper.currentTime();
    machine.startTime = startTime;
    machine.endTime = startTime.add(duration);
    var data = await remote.unlock(machine.toJson(), duration);
    MachineModel updatedMachine = _constructMachineFromResponse(data);
    return updatedMachine;
  }

  MachineModel _constructMachineFromResponse(
      Map<String, dynamic> machineAsJson) {
    return MachineModel.fromJson(machineAsJson);
  }

  @override
  Future<bool> getWifiPermission() async {
    return await remote.getWifiPermission();
  }

  @override
  Future<bool> connectToBoxWifi() async {
    return await remote.connectToBoxWifi();
  }

  @override
  Future<bool> disconnectFromBoxWifi() async {
    return await remote.disconnectFromBoxWifi();
  }
}
