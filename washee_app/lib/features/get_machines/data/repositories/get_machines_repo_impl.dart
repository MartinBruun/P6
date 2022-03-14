import 'package:washee/core/helpers/box_communicator.dart';
import 'package:washee/core/network/network_info.dart';
import 'package:washee/core/washee_box/machine_model.dart';
import 'package:washee/features/get_machines/domain/repositories/get_machines_repository.dart';
import 'package:wifi_iot/wifi_iot.dart';

class GetMachinesRepositoryImpl implements GetMachinesRepository {
  BoxCommunicator communicator;
  NetworkInfo networkInfo;

  GetMachinesRepositoryImpl(
      {required this.communicator, required this.networkInfo});
  @override
  Future<List<MachineModel>> getMachines() async {
    if (await networkInfo.isConnected) {
      return await communicator.getMachines();
    }
    return List.empty();
  }
}
