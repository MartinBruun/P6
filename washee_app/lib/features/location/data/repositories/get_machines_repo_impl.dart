import 'package:washee/core/externalities/network/network_info.dart';
import 'package:washee/core/externalities/web/web_connector.dart';
import 'package:washee/features/location/data/models/box_machine_model.dart';
import 'package:washee/features/location/domain/repositories/get_machines_repository.dart';

class GetMachinesRepositoryImpl implements GetMachinesRepository {
  IWebConnector connector;
  NetworkInfo networkInfo;

  GetMachinesRepositoryImpl(
      {required this.connector, required this.networkInfo});
  @override
  Future<List<MachineModel>> getMachines() async {
    if (await networkInfo.isConnected) {
      var response = await connector.retrieve("api/1/machines", queryParameters: {});
      return constructMachineList(response.data);
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
