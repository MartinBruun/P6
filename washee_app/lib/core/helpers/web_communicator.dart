import 'package:dio/dio.dart';
import 'package:washee/core/account/user.dart';
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
  Future<Map<String, dynamic>> postBooking(String timeStart, String timeEnd,
      int accountID, int machineID, int serviceID);
}

class WebCommunicatorImpl implements WebCommunicator {
  Dio dio;
  Authorizer authorizer;

  WebCommunicatorImpl({required this.dio, required this.authorizer}) {
    dio = initDio();
  }

  @override
  Dio initDio() {
    dio.options.headers["content-Type"] = "application/json";
    String token = authorizer.getTokenFromCache();
    dio.options.headers["authorization"] = "TOKEN $token";
    return dio;
  }

  @override
  String get usersURL => Environment().config.webApiHost + "/api/1/users/";

  @override
  String get accountsURL =>
      Environment().config.webApiHost + "/api/1/accounts/";

  @override
  String get bookingsURL =>
      Environment().config.webApiHost + "/api/1/bookings/";

  @override
  String get locationsURL =>
      Environment().config.webApiHost + "/api/1/locations/";

  @override
  String get machineModelsURL =>
      Environment().config.webApiHost + "/api/1/machine_models/";

  @override
  String get machinesURL =>
      Environment().config.webApiHost + "/api/1/machines/";

  @override
  String get servicesURL =>
      Environment().config.webApiHost + "/api/1/services/";

  @override
  Future<Map<String, dynamic>> getCurrentUser(int userID) async {
    Response response;

    response = await dio.get(usersURL + "/$userID");
    if (response.statusCode == 200) {
      return response.data;
    } else {
      ExceptionHandler().handle(
          "Something went wrong with status code: " +
              response.statusCode.toString() +
              " with response:\n" +
              response.data['response'],
          log: true,
          show: true,
          crash: false);
      return response.data;
    }
  }

  @override
  Future<Map<String, dynamic>> getCurrentLocation(int locationID) async {
    Response response;

    response = await dio.get(locationsURL + "/$locationID");
    if (response.statusCode == 200) {
      return response.data;
    } else {
      ExceptionHandler().handle(
          "Something went wrong with status code: " +
              response.statusCode.toString() +
              " with response:\n" +
              response.data['response'],
          log: false,
          show: true,
          crash: false);
      return response.data;
    }
  }

  @override
  Future<Map<String, dynamic>> getCurrentBookings(int locationID) async {
    Response response;

    response = await dio.get(bookingsURL);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      ExceptionHandler().handle(
          "Something went wrong with status code: " +
              response.statusCode.toString() +
              " with response:\n" +
              response.data['response'],
          log: true,
          show: true,
          crash: false);
      return response.data;
    }
  }

  Future<Map<String, dynamic>> postBooking(String timeStart, String timeEnd,
      int accountID, int machineID, int serviceID) async {
    Response response;

    response = await dio.post(bookingsURL, data: {
      "time_start": timeStart,
      "time_end": timeEnd,
      "account": accountID,
      "machine": machineID,
      "service": serviceID
    });
    if (response.statusCode == 200) {
      return response.data;
    } else {
      ExceptionHandler().handle(
          "Something went wrong with status code: " +
              response.statusCode.toString() +
              " with response:\n" +
              response.data['response'],
          log: true,
          show: true,
          crash: false);
      return response.data;
    }
  }

  // ONLY FOR TESTING! SHOULD BE REMOVED WHEN THIS IS SOLVED!
  // @override
  // Future<List<User>> getAllUsers() async {
  //   Response response;

  //   response = await dio.get(usersURL);
  //   if (response.statusCode == 200) {
  //     List<User> _users = [];
  //     for (var user in response.data) {
  //       _users.add(User.fromJson(user));
  //     }

  //     return _users;
  //   } else {
  //     ExceptionHandler().handle(
  //         "Something went wrong with status code: " +
  //             response.statusCode.toString() +
  //             " with response:\n" +
  //             response.data['response'],
  //         log: true,
  //         show: true,
  //         crash: false);
  //     return [];
  //   }
  // }
}
