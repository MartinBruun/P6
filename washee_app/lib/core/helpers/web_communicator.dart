import 'dart:io';

import 'package:dio/dio.dart';
import 'package:washee/core/environments/environment.dart';
import 'package:washee/core/errors/exception_handler.dart';
import 'package:washee/core/helpers/authorizer.dart';

abstract class WebCommunicator {
  // Setup
  Dio initDio();
  // URLs
  String get usersURL;
  String get accountsURL;
  String get bookingsURL;
  String get locationsURL;
  String get machinesURL;
  String get machineModelsURL;
  String get servicesURL;
  // Data Methods
  Future<Map<String, dynamic>> getCurrentUser(int userID);
  Future<Map<String, dynamic>> getCurrentLocation(int locationID);
  Future<Map<String, dynamic>> getCurrentBookings(int locationID);
  Future<Map<String, dynamic>> postBooking(String timeStart, String timeEnd, int accountID, int machineID, int serviceID);
}

class WebCommunicatorImpl implements WebCommunicator {
  Dio dio;

  WebCommunicatorImpl({required this.dio}){
    dio = initDio();
  }

  @override
  Dio initDio() {
    Dio temp_dio = new Dio();
    temp_dio.options.headers["content-Type"] = "application/json";
    String token = AuthorizerImpl().getTokenFromCache();
    temp_dio.options.headers["authorization"] = "TOKEN ${token}";
    return temp_dio;
  }

  @override
  String get usersURL => Environment().config.webApiHost + "/api/1/users";

  @override
  String get accountsURL => Environment().config.webApiHost + "/api/1/accounts";

  @override
  String get bookingsURL => Environment().config.webApiHost + "/api/1/bookings";

  @override
  String get locationsURL => Environment().config.webApiHost + "/api/1/locations";

  @override
  String get machineModelsURL => Environment().config.webApiHost + "/api/1/machine_models";

  @override
  String get machinesURL => Environment().config.webApiHost + "/api/1/machines";

  @override
  String get servicesURL => Environment().config.webApiHost + "/api/1/services";

  @override
  Future<Map<String, dynamic>> getCurrentUser(int userID) async {
    Response response;

    response = await dio.get(tokenURL);
    if (response.statusCode == 200){
      return {"get": "The current user from the database, maybe using email + password instead?" };
    }
    else {
      ExceptionHandler().handle(
        "Something went wrong with status code: " + response.statusCode.toString() + " with response:\n" + response.data['response'],
        log:true, show:true, crash: false);
      return response.data;
    }
  }

  @override
  Future<Map<String, dynamic>> getCurrentLocation(int locationID) async {
    Response response;

    response = await dio.get(tokenURL);
    if (response.statusCode == 200){
      return {"get": "The current location the person is in, or want to book in. The locationID should be saved locally" };
    }
    else {
      ExceptionHandler().handle(
        "Something went wrong with status code: " + response.statusCode.toString() + " with response:\n" + response.data['response'],
        log:true, show:true, crash: false);
      return response.data;
    }
  }

  @override
  Future<Map<String, dynamic>> getCurrentBookings(int locationID) async {
    Response response;

    response = await dio.get(bookingsURL);
    if (response.statusCode == 200){
      return {"get": "The current bookings already made for the current location" };
    }
    else {
      ExceptionHandler().handle(
        "Something went wrong with status code: " + response.statusCode.toString() + " with response:\n" + response.data['response'],
        log:true, show:true, crash: false);
      return response.data;
    }
  }

  Future<Map<String, dynamic>> postBooking(String timeStart, String timeEnd, int accountID, int machineID, int serviceID) async {
    Response response;

    response = await dio.post(tokenURL);
    if (response.statusCode == 200){
      return {"post": "a booking to a specific machine that is in a specific location, booking a specific service." };
    }
    else {
      ExceptionHandler().handle(
        "Something went wrong with status code: " + response.statusCode.toString() + " with response:\n" + response.data['response'],
        log:true, show:true, crash: false);
      return response.data;
    }
  }
}
