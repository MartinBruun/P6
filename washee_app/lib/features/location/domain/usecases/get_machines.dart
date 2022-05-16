import 'package:washee/core/usecases/usecase.dart';

import '../../../../core/washee_box/machine_model.dart';
import '../repositories/get_machines_repository.dart';

class GetMachinesUseCase implements UseCase<List<MachineModel>, NoParams> {
  final GetMachinesRepository repository;

  GetMachinesUseCase({required this.repository});

  @override
  Future<List<MachineModel>> call(NoParams params) async {
    List<MachineModel> machines= await repository.getMachines();
    return machines;
  }
}
