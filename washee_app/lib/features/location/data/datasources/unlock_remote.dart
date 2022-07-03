import 'package:washee/core/externalities/box/box_communicator.dart';
import 'package:washee/core/externalities/network/network_info.dart';

abstract class UnlockRemote {
  Future<Map<String, dynamic>> unlock(Map<String,dynamic> machine, Duration duration);
  Future<bool> getWifiPermission();
  Future<bool> connectToBoxWifi();
  Future<bool> disconnectFromBoxWifi();
}

class UnlockRemoteImpl implements UnlockRemote {
  BoxCommunicator communicator;
  NetworkInfo networkInfo;

  UnlockRemoteImpl({required this.communicator, required this.networkInfo});

  @override
  Future<Map<String, dynamic>> unlock(Map<String,dynamic> machine, Duration duration) async {
    if(await networkInfo.isConnected){
      return await communicator.lockOrUnlock("unlock", machine, duration);
    }
    else{
      return {};
    }
  }

  @override
  Future<bool> getWifiPermission() async {
    return await networkInfo.getWifiAccessPermissions();
  }

  @override
  Future<bool> connectToBoxWifi() async {
    return await networkInfo.connectToBoxWifi();
  }

  @override
  Future<bool> disconnectFromBoxWifi() async {
    return await networkInfo.disconnectFromBoxWifi();
  }
}
