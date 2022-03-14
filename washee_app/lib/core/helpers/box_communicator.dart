import 'package:dio/dio.dart';
import 'package:washee/core/washee_box/machine_model.dart';

abstract class BoxCommunicator {
  Future<List<MachineModel>> getMachines();
  Future<bool> lockOrUnlock(String command);
  String get lockURL;
  String get unlockURL;
  String get getMachinesURL;
}

class BoxCommunicatorImpl implements BoxCommunicator {
  Dio dio = new Dio();

  BoxCommunicatorImpl({required this.dio});

  Future<bool> _lock() async {
    Response response;

    response = await dio.post(lockURL);
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

    response = await dio.post(unlockURL);
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
  String get lockURL => 'http://ip:8888/unlock';

  @override
  String get unlockURL => 'http://ip:8888/lock';

  @override
  Future<List<MachineModel>> getMachines() async {
    Response response;

    response = await dio.post(getMachinesURL);
    if (response.statusCode == 200) {
      if (response.data != null) {
        return response.data['machines'];
      }
    } else {
      print("Something went wrong, status code and response: " +
          response.statusCode.toString() +
          " " +
          response.data['response']);
      return [];
    }
    return List.empty();
  }

  @override
  String get getMachinesURL => "http://ip:washeebox.local/getMachinesInfo";
}
