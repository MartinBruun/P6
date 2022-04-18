import 'dart:io';

import 'package:dio/dio.dart';
import 'package:washee/core/account/user.dart';
import 'package:washee/core/helpers/web_communicator.dart';
import 'package:washee/core/washee_box/machine_model.dart';
import 'package:washee/core/environments/environment.dart';

import 'package:washee/core/errors/exception_handler.dart';
import 'package:washee/features/booking/data/models/booking_model.dart';
import '../errors/failures.dart';
import 'package:washee/injection_container.dart';

abstract class BoxCommunicator {
  Future<Map<String, dynamic>> getMachines();
  Future<Map<String, dynamic>> lockOrUnlock(
      String command, MachineModel machine);
  String get lockURL;
  String get unlockURL;
  String get getMachinesURL;
}

class BoxCommunicatorImpl implements BoxCommunicator {
  Dio dio = new Dio();
  WebCommunicator communicator;

  BoxCommunicatorImpl({required this.dio, required this.communicator});
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
    MachineModel machine) async {
      Response response;
      DateTime endTime = DateTime.now().add(Duration(hours: 2, minutes: 30));
      try {
        List<Map<String,dynamic>> currentBooking = await communicator.getCurrentBookings(
          machineID: int.parse(machine.machineID),
          startTimeLessThan: DateTime.now(),
          endTimeGreaterThan: DateTime.now()
        );
        if (currentBooking.isNotEmpty){
          endTime = DateTime.parse(currentBooking[0]["end_time"]);
        }
        else{
          ExceptionHandler().handle("BIG ERROR! No Booking is active for this time! " + DateTime.now().toString(),log:true, show:true);
        }
      }
      catch (e){
        ExceptionHandler().handle("Could not get booking time, defaulting to 2 hours and 30 minutes",log:true, show:true);
      }

      var startTime = DateTime.now();
      machine.startTime = startTime;
      machine.endTime = startTime.add(startTime.difference(endTime));
      try {
        response = await dio.post(unlockURL, data: machine.toJson());
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
      String command, MachineModel machine) {
    if (command == "lock") {
      return _lock();
    }
    return _unlock(machine);
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
