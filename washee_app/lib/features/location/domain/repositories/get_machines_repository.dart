import 'package:washee/core/washee_box/machine_model.dart';

abstract class GetMachinesRepository {
  Future<List<MachineModel>> getMachines();
}
