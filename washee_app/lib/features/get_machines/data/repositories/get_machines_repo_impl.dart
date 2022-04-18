import 'package:washee/core/helpers/web_communicator.dart';
import 'package:washee/core/network/network_info.dart';
import 'package:washee/core/washee_box/machine_model.dart';
import 'package:washee/features/get_machines/domain/repositories/get_machines_repository.dart';

class GetMachinesRepositoryImpl implements GetMachinesRepository {
  WebCommunicator communicator;
  NetworkInfo networkInfo;

  GetMachinesRepositoryImpl(
      {required this.communicator, required this.networkInfo});
  @override
  Future<List<MachineModel>> getMachines() async {
    if (await networkInfo.isConnected) {
      var data = await communicator.getMachines();
      return constructMachineList(data);
    }
    return List.empty();
  }

  List<MachineModel> constructMachineList(List<Map<String, dynamic>> machinesAsJson) {
    List<MachineModel> _machines = [];
    for (var machine in machinesAsJson) {
      _machines.add(MachineModel.fromJson(machine));
    }

    return _machines;
  }
}
