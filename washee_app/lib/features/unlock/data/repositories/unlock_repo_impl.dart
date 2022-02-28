import 'package:washee/core/network/network_info.dart';
import 'package:washee/features/unlock/domain/repositories/unlock_repository.dart';

import '../datasources/unlock_remote.dart';

class UnlockRepositoryImpl implements UnlockRepository {
  UnlockRemote remote;
  NetworkInfo networkInfo;

  UnlockRepositoryImpl({required this.remote, required this.networkInfo});
  @override
  Future<bool> unlock() async {
    if (await networkInfo.isConnected) {
      return await remote.unlock();
    }
    return false;
  }
}
