import 'package:dio/dio.dart';
import 'package:washee/features/connect/domain/repositories/connect_repository.dart';

import '../datasources/connect_remote.dart';

class ConnectRepositoryImpl implements ConnectRepository {
  final ConnectRemote remote;

  ConnectRepositoryImpl({required this.remote});
  @override
  Future<Response> connect() async {
    return await remote.connect();
  }
}
