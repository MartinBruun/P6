import 'package:washee/features/location/data/models/box_machine_model.dart';

abstract class GetMachinesRepository {
  Future<List<MachineModel>> getMachines();
}
