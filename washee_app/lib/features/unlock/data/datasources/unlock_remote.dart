import 'package:washee/core/helpers/box_communicator.dart';

abstract class UnlockRemote {
  Future<bool> unlock();
}

class UnlockRemoteImpl implements UnlockRemote {
  BoxCommunicator communicator;

  UnlockRemoteImpl({required this.communicator});

  @override
  Future<bool> unlock() async {
    return await communicator.lockOrUnlock("unlock");
  }
}
