import 'package:washee/core/helpers/box_communicator.dart';
import 'package:washee/core/network/network_info.dart';
import 'package:washee/core/washee_box/machine_model.dart';
import 'package:washee/features/get_machines/domain/repositories/get_machines_repository.dart';

class GetMachinesRepositoryImpl implements GetMachinesRepository {
  BoxCommunicator communicator;
  NetworkInfo networkInfo;

  GetMachinesRepositoryImpl(
      {required this.communicator, required this.networkInfo});
  @override
  Future<List<MachineModel>> getMachines() async {
    if (await networkInfo.isConnected) {
      var response = await communicator.getMachines();
      _constructMachineList(response.data);
    }
    return List.empty();
  }

  _constructMachineList(Map<String, dynamic> machinesAsJson) {
    List<MachineModel> _machines = [];
    for (var machine in machinesAsJson['machines']) {
      _machines.add(MachineModel.fromJson(machine));
    }

    return _machines;
  }
}
