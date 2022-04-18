import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:washee/core/account/account.dart';
import 'package:washee/core/environments/environment.dart';
import 'package:washee/core/errors/exception_handler.dart';
import 'package:washee/core/helpers/authorizer.dart';

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
  // Data Methods
  Future<Map<String, dynamic>> getCurrentLocation(int locationID);
  Future<List<Map<String, dynamic>>> getCurrentBookings(
      {DateTime? startTimeGreaterThan,
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
  Future<List<Map<String, dynamic>>> getCurrentBookings(
      {DateTime? startTimeGreaterThan,
      DateTime? startTimeLessThan,
      DateTime? endTimeGreaterThan,
      DateTime? endTimeLessThan,
      int? machineID,
      int? accountID,
      int? serviceID}) async {
    Response response;

    String queryString = "";

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
      "start_time": _convertToNonNaiveTime(startTime),
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

  @override
  Future<Map<String, dynamic>> getAccount(Account account) async {
    Response response;
    String url = accountsURL + "/${account.id.toString()}/";

    response = await dio.get(url);

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

      throw Exception(response.data);
    }
  }

  @override
  Future<bool> deleteBooking(bookingID) async {
    Response response;
    String url = bookingsURL + "/${bookingID}/";

    response = await dio.delete(url);

    if (response.statusCode != null && response.statusCode! == 204) {
      return true;
    } else {
      ExceptionHandler().handle(
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
        convertedData.add({
          "machineID": machine["id"].toString(),
          "startTime": "2022-04-15 22:47:18.289741",
          "endTime": "2022-04-15 22:47:18.289741",
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

  String _convertToNonNaiveTime(DateTime time) {
    // The backend is timezone sensitive, and needs it in the following specified format
    return DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(time) + "Z";
  }
}
