import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
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
  Future<Map<String, dynamic>> getCurrentLocation(int locationID);
  Future<List<Map<String, dynamic>>> getCurrentBookings({
    DateTime? startTimeGreaterThan,
    DateTime? startTimeLessThan,
    DateTime? endTimeGreaterThan,
    DateTime? endTimeLessThan,
    int? machineID,
    int? accountID,
    int? serviceID
  });
  Future<Map<String, dynamic>> postBooking(
      {required DateTime startTime,
      required String accountResource,
      required String machineResource,
      required String serviceResource});
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
  String get usersURL => Environment().config.webApiHost + "/api/1/users";

  @override
  String get accountsURL =>
      Environment().config.webApiHost + "/api/1/accounts";

  @override
  String get bookingsURL =>
      Environment().config.webApiHost + "/api/1/bookings";

  @override
  String get locationsURL =>
      Environment().config.webApiHost + "/api/1/locations";

  @override
  String get machineModelsURL =>
      Environment().config.webApiHost + "/api/1/machine_models";

  @override
  String get machinesURL =>
      Environment().config.webApiHost + "/api/1/machines";

  @override
  String get servicesURL =>
      Environment().config.webApiHost + "/api/1/services";

  @override
  Future<Map<String, dynamic>> getCurrentLocation(int locationID) async {
    Response response;

    response = await dio.get(locationsURL + "/${locationID}/");
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
  Future<List<Map<String, dynamic>>> getCurrentBookings({
    DateTime? startTimeGreaterThan,
    DateTime? startTimeLessThan,
    DateTime? endTimeGreaterThan,
    DateTime? endTimeLessThan,
    int? machineID,
    int? accountID,
    int? serviceID}
    ) async {
    Response response;

    String queryString = "";
    
    if (startTimeGreaterThan != null){
      queryString += "start_time__gte=" + startTimeGreaterThan.toString() + "&";
    }
    if (startTimeLessThan != null){
      queryString += "start_time__lte=" + startTimeLessThan.toString() + "&";
    }
    if (endTimeGreaterThan != null){
      queryString += "end_time__gte=" + endTimeGreaterThan.toString() + "&";
    }
    if (endTimeLessThan != null){
      queryString += "end_time__lte=" + endTimeLessThan.toString() + "&";
    }
    if (machineID != null){
      queryString += "machine_id=" + machineID.toString() + "&";
    }
    if (accountID != null){
      queryString += "account_id=" + accountID.toString() + "&";
    }
    if (serviceID != null){
      queryString += "service_id=" + serviceID.toString() + "&";
    }

    String bookingsFinalURL = bookingsURL;
    if (queryString == ""){
      bookingsFinalURL += "/";
    }
    else{
      bookingsFinalURL += "?" + queryString;
      bookingsFinalURL = bookingsFinalURL.substring(0, bookingsFinalURL.length-1);
    }
    print(bookingsFinalURL);

    response = await dio.get(bookingsFinalURL);
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> convertedData = [];
      for (var booking in response.data) {
        convertedData.add({
          "id": booking["id"],
          "start_time": booking["start_time"],
          "end_time": booking["end_time"],
          "created": booking["created"],
          "last_updated": booking["last_updated"],
          "machine": booking["machine"],
          "service": booking["service"],
          "account": booking["account"],
        });
      }
      return convertedData;
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

  Future<Map<String, dynamic>> postBooking(
      {required DateTime startTime,
      required String accountResource,
      required String machineResource,
      required String serviceResource}) async {
    Response response;

    response = await dio.post(bookingsURL + "/", data: {
      "start_time": DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(startTime) + "Z",
      "account": accountResource,
      "machine": machineResource,
      "service": serviceResource
    });
    if (response.statusCode == 201) {
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
}
