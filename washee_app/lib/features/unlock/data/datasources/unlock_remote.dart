import 'package:washee/core/helpers/box_communicator.dart';
import 'package:washee/core/washee_box/machine_model.dart';

abstract class UnlockRemote {
  Future<Map<String, dynamic>> unlock(MachineModel machine, Duration duration);
}

class UnlockRemoteImpl implements UnlockRemote {
  BoxCommunicator communicator;

  UnlockRemoteImpl({required this.communicator});

  @override
  Future<Map<String, dynamic>> unlock(
      MachineModel machine, Duration duration) async {
    return await communicator.lockOrUnlock("unlock", machine, duration);
  }
}
