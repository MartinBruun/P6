import 'package:dio/dio.dart';
import 'package:washee/core/errors/failures.dart';
import 'package:washee/core/errors/http_error_prompt.dart';
import 'package:washee/core/network/network_info.dart';
import 'package:washee/core/washee_box/machine_model.dart';
import 'package:washee/features/unlock/domain/repositories/unlock_repository.dart';

import '../datasources/unlock_remote.dart';

class UnlockRepositoryImpl implements UnlockRepository {
  UnlockRemote remote;
  NetworkInfo networkInfo;

  UnlockRepositoryImpl({required this.remote, required this.networkInfo});
  @override
  Future<Response?> unlock(MachineModel machine, Duration duration) async {
    if (await networkInfo.isConnected) {
      return await remote.unlock(machine, duration);
    }
    return null;
  }
}
