import 'dart:io';

import 'package:dio/dio.dart';
import 'package:washee/core/environments/environment.dart';
import 'package:washee/core/errors/exception_handler.dart';

abstract class WebCommunicator {
  // Meta data
  String get token;
  // Maybe some func that makes sure to auto-issue a new token when the old one is about to expire?
  // Ideas can maybe be found in: https://ohuru.tech/blog/2020/4/19/flutter-signuplogin-application-with-django-backend-3/
  // Be aware that we don't strictly follow these guidelines! (we don't use Bloc as statemanager for example)
  // URLs
  String get tokenURL;
  String get usersURL;
  String get accountsURL;
  String get bookingsURL;
  String get locationsURL;
  String get machinesURL;
  String get machineModelsURL;
  String get servicesURL;
  // Methods
  Future<Map<String, dynamic>> getValidToken(String email, String password);
  Future<Map<String, dynamic>> getCurrentUser(int userID);
  Future<Map<String, dynamic>> getCurrentLocation(int locationID);
  Future<Map<String, dynamic>> getCurrentBookings(int locationID);
  Future<Map<String, dynamic>> postBooking(String timeStart, String timeEnd, int accountID, int machineID, int serviceID);
}

class WebCommunicatorImpl implements WebCommunicator {
  Dio dio = new Dio();

  WebCommunicatorImpl({required this.dio});

  @override
  String get token => "";

  @override
  String get tokenURL => Environment().config.webApiHost + "api/1/api-token-auth";

  @override
  String get usersURL => Environment().config.webApiHost + "api/1/users";

  @override
  String get accountsURL => Environment().config.webApiHost + "api/1/accounts";

  @override
  String get bookingsURL => Environment().config.webApiHost + "api/1/bookings";

  @override
  String get locationsURL => Environment().config.webApiHost + "api/1/locations";

  @override
  String get machineModelsURL => Environment().config.webApiHost + "api/1/machine_models";

  @override
  String get machinesURL => Environment().config.webApiHost + "api/1/machines";

  @override
  String get servicesURL => Environment().config.webApiHost + "api/1/services";

  @override
  Future<Map<String, dynamic>> getValidToken(String email, String password) async {
    Response response;

    response = await dio.post(tokenURL);
    if (response.statusCode == 200){
      return {"get": "valid token and update the 'token' attribute and make sure future dio requests use the header { 'Authorization': 'TOKEN <token>' }" };
    }
    else {
      ExceptionHandler().handle(
        "Something went wrong with status code: " + response.statusCode.toString() + " with response:\n" + response.data['response'],
        log:true, show:true, crash: false);
      return response.data;
    }
  }

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

    response = await dio.get(tokenURL);
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
