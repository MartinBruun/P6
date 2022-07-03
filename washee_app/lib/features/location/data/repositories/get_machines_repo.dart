import 'package:washee/features/location/data/datasources/web_machine_remote.dart';
import 'package:washee/features/location/data/models/box_machine_model.dart';

abstract class GetMachinesRepository {
  Future<List<MachineModel>> getMachines();
}

class GetMachinesRepositoryImpl implements GetMachinesRepository {
  IWebMachineRemote webMachineRemote;

  GetMachinesRepositoryImpl(
      {required this.webMachineRemote});
  @override
  Future<List<MachineModel>> getMachines() async {
    List<Map<String,dynamic>> machines = await webMachineRemote.getMachines();
    return await constructMachineList(machines);
  }

  List<MachineModel> constructMachineList(List<Map<String, dynamic>> machinesAsJson) {
    List<MachineModel> _machines = [];
    for (var machine in machinesAsJson) {
      _machines.add(MachineModel.fromJson(machine));
    }

    return _machines;
  }
}
