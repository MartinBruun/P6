import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:washee/core/account/account.dart';
import 'package:washee/core/account/user.dart';
import 'package:washee/core/environments/environment.dart';
import 'package:washee/core/errors/exception_handler.dart';
import 'package:washee/core/helpers/authorizer.dart';
import 'package:washee/core/helpers/date_helper.dart';

import 'package:timezone/timezone.dart' as tz;

abstract class WebCommunicator {
  // ALL ID and Resource should be changed to their corresponding Model instead!
  // Models should then also have their resource AND id saved (or have the resource as a getter for convenience)
  // Setup
  Future<Dio> initDio();
  // URLs
  String get usersURL;
  String get accountsURL;
  String get bookingsURL;
  String get locationsURL;
  String get machinesURL;
  String get machineModelsURL;
  String get servicesURL;
  String get logsURL;
  // Data Methods
  Future<Map<String, dynamic>> getCurrentLocation(int locationID);
  Future<List<Map<String, dynamic>>> getCurrentBookings(
      {bool? activated,
      DateTime? startTimeGreaterThan,
      DateTime? startTimeLessThan,
      DateTime? endTimeGreaterThan,
      DateTime? endTimeLessThan,
      int? machineID,
      int? accountID,
      int? serviceID});
  Future<Map<String, dynamic>> postBooking(
      {required DateTime startTime,
      required String accountResource,
      required String machineResource,
      required String serviceResource});
  Future<Map<String, dynamic>> getAccount(Account account);
  Future<bool> deleteBooking(bookingID);
  Future<List<Map<String, dynamic>>> getMachines();
  Future<bool> postLog(String content);
  Future<bool> updateBooking(String bookingID, {bool? activated});
}

class WebCommunicatorImpl implements WebCommunicator {
  Dio dio;
  Authorizer authorizer;

  WebCommunicatorImpl({required this.dio, required this.authorizer});

  @override
  Future<Dio> initDio() async {
    dio.options.headers["content-Type"] = "application/json";
    String token = await authorizer.getTokenFromCache();
    dio.options.headers["authorization"] = "TOKEN $token";
    return dio;
  }

  @override
  String get usersURL => Environment().config.webApiHost + "/api/1/users";

  @override
  String get accountsURL => Environment().config.webApiHost + "/api/1/accounts";

  @override
  String get bookingsURL => Environment().config.webApiHost + "/api/1/bookings";

  @override
  String get locationsURL =>
      Environment().config.webApiHost + "/api/1/locations";

  @override
  String get machineModelsURL =>
      Environment().config.webApiHost + "/api/1/machine_models";

  @override
  String get machinesURL => Environment().config.webApiHost + "/api/1/machines";

  @override
  String get servicesURL => Environment().config.webApiHost + "/api/1/services";

  @override
  String get logsURL => Environment().config.webApiHost + "/api/1/logs";

  @override
  Future<Map<String, dynamic>> getCurrentLocation(int locationID) async {
    Response response;

    response = await dio.get(locationsURL + "/${locationID}/");
    if (response.statusCode == 200) {
      return response.data;
    } else {
      ExceptionHandler().handle(
          "Could not get the current location" +
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
  Future<List<Map<String, dynamic>>> getCurrentBookings(
      {bool? activated,
      DateTime? startTimeGreaterThan,
      DateTime? startTimeLessThan,
      DateTime? endTimeGreaterThan,
      DateTime? endTimeLessThan,
      int? machineID,
      int? accountID,
      int? serviceID}) async {
    Response response;

    String queryString = "";

    if (activated != null) {
      queryString += "activated=" + activated.toString() + "&";
    }

    if (startTimeGreaterThan != null) {
      queryString += "start_time__gte=" +
          _convertToNonNaiveTime(startTimeGreaterThan) +
          "&";
    }
    if (startTimeLessThan != null) {
      queryString +=
          "start_time__lte=" + _convertToNonNaiveTime(startTimeLessThan) + "&";
    }
    if (endTimeGreaterThan != null) {
      queryString +=
          "end_time__gte=" + _convertToNonNaiveTime(endTimeGreaterThan) + "&";
    }
    if (endTimeLessThan != null) {
      queryString +=
          "end_time__lte=" + _convertToNonNaiveTime(endTimeLessThan) + "&";
    }
    if (machineID != null) {
      queryString += "machine_id=" + machineID.toString() + "&";
    }
    if (accountID != null) {
      queryString += "account_id=" + accountID.toString() + "&";
    }
    if (serviceID != null) {
      queryString += "service_id=" + serviceID.toString() + "&";
    }

    String bookingsFinalURL = bookingsURL;
    if (queryString == "") {
      bookingsFinalURL += "/";
    } else {
      bookingsFinalURL += "?" + queryString;
      bookingsFinalURL =
          bookingsFinalURL.substring(0, bookingsFinalURL.length - 1);
    }

    var danishTime = tz.getLocation('Europe/Copenhagen');
    response = await dio.get(bookingsFinalURL);
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> convertedData = [];
      for (var booking in response.data) {
        convertedData.add({
          "id": booking["id"],
          "start_time": tz.TZDateTime.from(
                  DateTime.parse(booking["start_time"]), danishTime)
              .toString(),
          "end_time": tz.TZDateTime.from(
                  DateTime.parse(booking["end_time"]), danishTime)
              .toString(),
          "created":
              tz.TZDateTime.from(DateTime.parse(booking["created"]), danishTime)
                  .toString(),
          "last_updated": tz.TZDateTime.from(
                  DateTime.parse(booking["last_updated"]), danishTime)
              .toString(),
          "activated": booking["activated"],
          "machine": booking["machine"],
          "service": booking["service"],
          "account": booking["account"],
        });
      }
      return convertedData;
    } else {
      ExceptionHandler().handle(
          "Could not get the current bookings" +
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

    Map<String, dynamic> data = {
      "start_time": _convertToNonNaiveTime(startTime),
      "account": accountResource,
      "machine": machineResource,
      "service": serviceResource
    };

    response = await dio.post(bookingsURL + "/", data: data);
    if (response.statusCode == 201) {
      return response.data;
    } else {
      ExceptionHandler().handle(
          "Could not post booking" +
              data.toString() +
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
  Future<Map<String, dynamic>> getAccount(Account account) async {
    Response response;
    String url = accountsURL + "/${account.id.toString()}/";

    response = await dio.get(url);

    if (response.statusCode == 200) {
      response.data["account_id"] = response.data[
          "id"]; //Stupid choice made early on the backend side, not sending proper values
      return response.data;
    } else {
      ExceptionHandler().handle(
          "Could not get account " +
              account.id.toString() +
              "Something went wrong with status code: " +
              response.statusCode.toString() +
              " with response:\n" +
              response.data['response'],
          log: true,
          show: true,
          crash: false);

      throw Exception(response.data);
    }
  }

  @override
  Future<bool> deleteBooking(bookingID) async {
    Response response;
    String url = bookingsURL + "/${bookingID}/";

    response = await dio.delete(url);

    if (response.statusCode == 204) {
      return true;
    } else {
      ExceptionHandler().handle(
          "Could not delete booking ID: " +
              bookingID.toString() +
              "Something went wrong with status code: " +
              response.statusCode.toString() +
              " with response:\n" +
              response.data['response'],
          log: true,
          show: true,
          crash: false);
      return false;
    }
  }

  @override
  Future<bool> updateBooking(String bookingID, {bool? activated}) async {
    Response response;
    String url = bookingsURL + "/${bookingID}/";

    Map<String, dynamic> data = {};
    if (activated != null) {
      data["activated"] = activated;
    }

    response = await dio.patch(url, data: data);

    if (response.statusCode != null && response.statusCode! < 400) {
      return true;
    } else {
      ExceptionHandler().handle(
          "Could not update booking " +
              bookingID.toString() +
              "Something went wrong with status code: " +
              response.statusCode.toString() +
              " with response:\n" +
              response.data['response'],
          log: true,
          show: true,
          crash: false);

      throw Exception(response.data);
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getMachines() async {
    Response response;

    String url = machinesURL + "/";

    response = await dio.get(url);

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> convertedData = [];
      for (var machine in response.data) {
        DateTime? startTime;
        DateTime? endTime;
        bool activated = false;
        try {
          List<Map<String, dynamic>> currentBooking = await getCurrentBookings(
              machineID: int.parse(machine["id"].toString()),
              startTimeLessThan: DateHelper().currentTime(),
              endTimeGreaterThan: DateHelper().currentTime());
          if (currentBooking.isNotEmpty) {
            startTime = DateTime.parse(currentBooking[0]["start_time"]);
            endTime = DateTime.parse(currentBooking[0]["end_time"]);
            activated = currentBooking[0]["activated"] == true;
          }
        } catch (e) {
          print("Throws error: " + e.toString());
        }

        convertedData.add({
          "machineID": machine["id"].toString(),
          "startTime": startTime != null ? startTime : null,
          "activated": activated,
          "endTime": endTime != null ? endTime : null,
          "name": machine["name"],
          "machineType": machine["machine_model"]
                  .toString()
                  .contains('/api/1/machine_models/1/')
              ? "AKG Vaskemaskine"
              : "Electrolux Tørretumbler"
        });
      }
      return convertedData;
    } else {
      ExceptionHandler().handle(
          "Could not get machines" +
              "Something went wrong with status code: " +
              response.statusCode.toString() +
              " with response:\n" +
              response.data['response'],
          log: true,
          show: true,
          crash: false);

      throw Exception(response.data);
    }
  }

  Future<bool> postLog(String content) async {
    Response response;
    ActiveUser user = ActiveUser();
    String userResource = usersURL + "/${user.id}/";

    try {
      response = await dio.post(logsURL + "/",
          data: {"content": content, "user": userResource, "source": "APP"});
      if (response.statusCode == 201) {
        return true;
      } else {
        ExceptionHandler().handle(
            "Could not send to logs " +
                "Something went wrong with status code: " +
                response.statusCode.toString() +
                " with response:\n" +
                response.data['response'],
            log: true,
            show: true,
            crash: false);
        return false;
      }
    } catch (e) {
      print("Could not send message to logs: " +
          content +
          " because of: " +
          e.toString());
      return false;
    }
  }

  String _convertToNonNaiveTime(DateTime time) {
    // The backend is timezone sensitive, and needs it in the following specified format
    var danishTime = tz.getLocation('Europe/Copenhagen');
    var now = tz.TZDateTime.from(time, danishTime);
    return now.toUtc().toString();
  }
}
