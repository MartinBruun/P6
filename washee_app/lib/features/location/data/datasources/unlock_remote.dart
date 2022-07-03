import 'package:washee/core/externalities/box/box_communicator.dart';
import 'package:washee/core/standards/time/date_helper.dart';
import 'package:washee/features/location/data/models/box_machine_model.dart';

abstract class UnlockRemote {
  Future<Map<String, dynamic>> unlock(MachineModel machine, Duration duration);
}

class UnlockRemoteImpl implements UnlockRemote {
  BoxCommunicator communicator;
  DateHelper dateHelper;

  UnlockRemoteImpl({required this.communicator, required this.dateHelper});

  @override
  Future<Map<String, dynamic>> unlock(
      MachineModel machine, Duration duration) async {
    var startTime = dateHelper.currentTime();
    machine.startTime = startTime;
    machine.endTime = startTime.add(duration);
    return await communicator.lockOrUnlock("unlock", machine.toJson(), duration);
  }
}
