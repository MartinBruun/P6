import 'dart:io';

import 'package:dio/dio.dart';
import 'package:washee/core/standards/environments/environment.dart';

import 'package:washee/core/standards/logger/exception_handler.dart';
import 'package:washee/core/standards/failures/failures.dart';

abstract class BoxCommunicator {
  Future<Map<String, dynamic>> getMachines();
  Future<Map<String, dynamic>> lockOrUnlock(
      String command, Map<String,dynamic> machine, Duration duration);
  String get lockURL;
  String get unlockURL;
  String get getMachinesURL;
}

class BoxCommunicatorImpl implements BoxCommunicator {
  late Dio dio;

  BoxCommunicatorImpl({required this.dio});
  @override
  String get lockURL => Environment().config.boxApiHost + '/lock';

  @override
  String get unlockURL => Environment().config.boxApiHost + '/unlock';

  @override
  String get getMachinesURL => Environment().config.boxApiHost + "/getMachinesInfo";

  Future<Map<String, dynamic>> _lock() async {
    Response response;

    response = await dio.post(lockURL);

    if (response.statusCode == 200) {
      return response.data;
    } else {
      ExceptionHandler().handle("Something went wrong, status code and response: " +
          response.statusCode.toString() +
          " " +
          response.data['response'], log:true, show:true, crash:false);
      return response.data;
    }
  }

  Future<Map<String, dynamic>> _unlock(
    Map<String,dynamic> machine, Duration duration) async {
      Response response;

      try {
        response = await dio.post(unlockURL, data: machine);
        if (response.statusCode == 200) {
          return response.data;
        } else {
          ExceptionHandler().handle("Something went wrong, status code and response: " +
              response.statusCode.toString() +
              " " +
              response.data['response'], log:true, show:true, crash:false);
          return response.data;
        }
      } on HttpException catch (e) {
        ExceptionHandler().handle(e.toString(),log:true,show:true,crash:false);
        throw new HTTPFailure();
      }
  }

  @override
  Future<Map<String, dynamic>> lockOrUnlock(
      String command, Map<String,dynamic> machine, Duration duration) {
    if (command == "lock") {
      return _lock();
    }
    return _unlock(machine, duration);
  }

  @override
  Future<Map<String, dynamic>> getMachines() async {
    Response response;

    response = await dio.get(getMachinesURL);

    if (response.statusCode == 200) {
      if (response.data != null) {
        return response.data;
      }
    } else {
      ExceptionHandler().handle("Something went wrong, status code and response: " +
          response.statusCode.toString() +
          " " +
          response.data['response'],log:true,show:true,crash:false);
      return response.data;
    }
    return response.data;
  }

  Future<Map<String, dynamic>?> dummyFetching() async {
    Response response;

    response = await dio.get(dummyURL);
    if (response.statusCode == 200) {
      if (response.data != null) {
        return response.data;
      }
    } else {
      ExceptionHandler().handle("Something went wrong during dummy fetching in BoxCommunicator",show:true,log:true,crash:false);
      return response.data;
    }
    return response.data;
  }

  String get dummyURL =>
      "https://dd4836d4-3a9d-4d8a-b83f-ccd74c637643.mock.pstmn.io/getMachinesInfo";
}
