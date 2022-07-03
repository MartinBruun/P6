import 'package:washee/core/externalities/box/box_communicator.dart';

abstract class UnlockRemote {
  Future<Map<String, dynamic>> unlock(Map<String,dynamic> machine, Duration duration);
}

class UnlockRemoteImpl implements UnlockRemote {
  BoxCommunicator communicator;

  UnlockRemoteImpl({required this.communicator});

  @override
  Future<Map<String, dynamic>> unlock(
      Map<String,dynamic> machine, Duration duration) async {
    return await communicator.lockOrUnlock("unlock", machine, duration);
  }
}
