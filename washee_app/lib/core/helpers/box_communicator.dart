import 'package:dio/dio.dart';

abstract class BoxCommunicator {
  Future<Response> lockOrUnlock(String command);
  String get lockURL;
  String get unlockURL;
  String get lockCMD;
  String get unlockCMD;
}

class BoxCommunicatorImpl implements BoxCommunicator {
  Dio dio = new Dio();

  BoxCommunicatorImpl({required this.dio});

  Future<Response> _lock() async {
    Response response;

    response = await dio.post(lockURL, data: {'command': lockCMD});
    if (response.statusCode == 200) {
      return response;
    } else {
      print("Something went wrong, status code and response: " +
          response.statusCode.toString() +
          " " +
          response.data['response']);
      return response;
    }
  }

  Future<Response> _unlock() async {
    Response response;

    response = await dio.post(unlockURL, data: {'command': unlockCMD});
    if (response.statusCode == 200) {
      return response;
    } else {
      print("Something went wrong, status code and response: " +
          response.statusCode.toString() +
          " " +
          response.data['response']);
      return response;
    }
  }

  @override
  Future<Response> lockOrUnlock(String command) {
    if (command == "lock") {
      return _lock();
    }
    return _unlock();
  }

  @override
  String get lockCMD => throw UnimplementedError();

  @override
  String get lockURL => 'http://ip:8888/unlock';

  @override
  String get unlockCMD => throw UnimplementedError();

  @override
  String get unlockURL => 'http://ip:8888/lock';
}
