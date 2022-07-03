import 'package:washee/core/standards/base_usecase/usecase.dart';

import 'package:washee/features/location/data/models/box_machine_model.dart';
import 'package:washee/features/location/data/repositories/get_machines_repo.dart';

class GetMachinesUseCase implements UseCase<List<MachineModel>, NoParams> {
  final GetMachinesRepository repository;

  GetMachinesUseCase({required this.repository});

  @override
  Future<List<MachineModel>> call(NoParams params) async {
    List<MachineModel> machines= await repository.getMachines();
    return machines;
  }
}
