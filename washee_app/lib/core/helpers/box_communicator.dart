import 'dart:io';

import 'package:dio/dio.dart';
import 'package:washee/core/washee_box/machine_entity.dart';
import 'package:washee/core/washee_box/machine_model.dart';

import '../errors/failures.dart';

abstract class BoxCommunicator {
  Future<Response> getMachines();
  Future<Response> lockOrUnlock(
      String command, MachineModel machine, Duration duration);
  String get lockURL;
  String get unlockURL;
  String get getMachinesURL;
}

class BoxCommunicatorImpl implements BoxCommunicator {
  Dio dio = new Dio();

  BoxCommunicatorImpl({required this.dio});

  Future<Response> _lock() async {
    Response response;

    response = await dio.post(lockURL);
    if (response.statusCode == 200) {
      return response.data['machine'];
    } else {
      print("Something went wrong, status code and response: " +
          response.statusCode.toString() +
          " " +
          response.data['response']);
      return response.data;
    }
  }

  Future<Response> _unlock(MachineModel machine, Duration duration) async {
    Response response;
    var startTime = DateTime.now();
    machine.startTime = startTime;
    machine.endTime = startTime.add(duration);
    try {
      response = await dio.post(unlockURL, data: {"machine": machine.toJson()});
      if (response.statusCode == 200) {
        return response.data;
      } else {
        print("Something went wrong, status code and response: " +
            response.statusCode.toString() +
            " " +
            response.data['response']);
        return response.data;
      }
    } on HttpException catch (e) {
      print(e.toString());
      throw new HTTPFailure();
    }
  }

  @override
  Future<Response> lockOrUnlock(
      String command, MachineModel machine, Duration duration) {
    if (command == "lock") {
      return _lock();
    }
    return _unlock(machine, duration);
  }

  @override
  String get lockURL => 'http://washeebox.local/lock';

  @override
  String get unlockURL => 'http://washeebox.local/unlock';

  @override
  Future<Response> getMachines() async {
    Response response;

    response = await dio.get(getMachinesURL);
    if (response.statusCode == 200) {
      if (response.data != null) {
        return response.data['machines'];
      }
    } else {
      print("Something went wrong, status code and response: " +
          response.statusCode.toString() +
          " " +
          response.data['response']);
      return response;
    }
    return response;
  }

  @override
  String get getMachinesURL => "http://ip:washeebox.local/getMachinesInfo";
}
