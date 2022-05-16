import 'package:dio/dio.dart';

abstract class ConnectRepository {
  Future<Response> connect();
}
