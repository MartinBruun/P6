import 'package:washee/core/usecases/usecase.dart';
import 'package:washee/features/unlock/domain/usecases/connect_box_wifi.dart';
import 'package:washee/features/unlock/domain/usecases/disconnect_box_wifi.dart';
import 'package:washee/injection_container.dart';

import '../../../../core/washee_box/machine_model.dart';
import '../repositories/get_machines_repository.dart';

class GetMachinesUseCase implements UseCase<List<MachineModel>, NoParams> {
  final GetMachinesRepository repository;

  GetMachinesUseCase({required this.repository});

  @override
  Future<List<MachineModel>> call(NoParams params) async {
    await sl<ConnectBoxWifiUsecase>().call(NoParams());
    List<MachineModel> machines= await repository.getMachines();
    sl<DisconnectBoxWifiUsecase>().call(NoParams());
    return machines;
  }
}
