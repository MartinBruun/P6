import 'package:dio/dio.dart';

abstract class BoxCommunicator {
  Future<bool> lockOrUnlock(String command);
  String get lockURL;
  String get unlockURL;
  String get lockCMD;
  String get unlockCMD;
}

class BoxCommunicatorImpl implements BoxCommunicator {
  Dio dio = new Dio();

  BoxCommunicatorImpl({required this.dio});

  Future<bool> _lock() async {
    Response response;

    response = await dio.post(lockURL, data: {'command': lockCMD});
    if (response.statusCode == 200) {
      return true;
    } else {
      print("Something went wrong, status code and response: " +
          response.statusCode.toString() +
          " " +
          response.data['response']);
      return false;
    }
  }

  Future<bool> _unlock() async {
    Response response;

    response = await dio.post(unlockURL, data: {'command': unlockCMD});
    if (response.statusCode == 200) {
      return true;
    } else {
      print("Something went wrong, status code and response: " +
          response.statusCode.toString() +
          " " +
          response.data['response']);
      return false;
    }
  }

  @override
  Future<bool> lockOrUnlock(String command) {
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
