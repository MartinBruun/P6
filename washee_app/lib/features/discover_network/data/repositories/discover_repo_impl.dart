import 'package:connectivity_plus_platform_interface/src/enums.dart';
import 'package:washee/core/network/network_info.dart';
import 'package:washee/features/discover_network/domain/repositories/discover_repository.dart';

import '../datasources/discover_remote.dart';

class DiscoverRepositoryImpl implements DiscoverRepository {
  NetworkInfo networkInfo;
  DiscoverRemote remote;

  DiscoverRepositoryImpl({required this.networkInfo, required this.remote});

  @override
  Future<List<ConnectivityResult>> discover() async {
    return await remote.getNetworks();
  }
}
