import 'package:dio/dio.dart';

import '../datasources/connect_remote.dart';

abstract class ConnectRepository {
  Future<Response> connect();
}

class ConnectRepositoryImpl implements ConnectRepository {
  final ConnectRemote remote;

  ConnectRepositoryImpl({required this.remote});
  @override
  Future<Response> connect() async {
    return await remote.connect();
  }
}
