import 'package:dio/dio.dart';

abstract class ConnectRemote {
  Future<Response> connect();
}

class ConnectRemoteImpl implements ConnectRemote {
  @override
  Future<Response> connect() async {
    var response = Response(requestOptions: RequestOptions(path: "some_path"));
    return await Future.delayed(Duration(seconds: 5)).then((value) => response);
  }
}
