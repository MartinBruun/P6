import 'package:connectivity_plus/connectivity_plus.dart';

abstract class DiscoverRemote {
  Future<List<ConnectivityResult>> getNetworks();
}

class DiscoverRemoteImpl implements DiscoverRemote {
  @override
  Future<List<ConnectivityResult>> getNetworks() async {
    var results = [] as List<ConnectivityResult>;
    return await Future.delayed(Duration(seconds: 5)).then((value) => results);
  }
}
