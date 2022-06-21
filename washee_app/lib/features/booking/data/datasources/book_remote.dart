
import 'package:dio/dio.dart';
import 'package:washee/core/externalities/network/network_info.dart';
import 'package:washee/core/externalities/web/web_connector.dart';

abstract class BookRemote {
  Future<List<Map<String, dynamic>>> getBookings(
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
      required String machineResource,
      required String serviceResource,
      required String accountResource});
  Future<bool> deleteBooking(bookingID);
}

class BookRemoteImpl implements BookRemote {
  IWebConnector connector;
  NetworkInfo networkInfo;

  BookRemoteImpl({required this.connector, required this.networkInfo});

  @override
  Future<List<Map<String, dynamic>>> getBookings(
      {bool? activated,
      DateTime? startTimeGreaterThan,
      DateTime? startTimeLessThan,
      DateTime? endTimeGreaterThan,
      DateTime? endTimeLessThan,
      int? machineID,
      int? accountID,
      int? serviceID}) async {
    if (await networkInfo.isConnected) {
      // SHOULD receive the data as Map<String,dynamic> directly from the repository (That would use a WebBookingModel for the serialization/deserialization)
      var response = await connector.retrieve("api/1/bookings", queryParameters: {
          "activated": activated,
          "startTimeGreaterThan": startTimeGreaterThan,
          "startTimeLessThan": startTimeLessThan,
          "endTimeGreaterThan": endTimeGreaterThan,
          "endTimeLessThan": endTimeLessThan,
          "machineID": machineID,
          "accountID": accountID,
          "serviceID": serviceID});
      return response.data;
    }
    throw new Exception(
        "I would argue this should not return an empty list. No response from database is not the same as there are no bookings on the database!");
  }

  Future<Map<String, dynamic>> postBooking(
      {required DateTime startTime,
      required String machineResource,
      required String serviceResource,
      required String accountResource}) async {
    if (await networkInfo.isConnected) {
      // SHOULD receive the data as Map<String,dynamic> directly from the repository (That would use a WebBookingModel for the serialization/deserialization)
      var response = await connector.create("api/1/bookings", {
          "startTime": startTime,
          "machineResource": machineResource,
          "serviceResource": serviceResource,
          "accountResource": accountResource});
      if (response.data.isEmpty) {
        throw new Exception(
            "Wont make sense to return an 'empty' booking model, what is that?");
      } else {
        return response.data;
      }
    }
    throw new Exception(
        "Not connected to a network when trying to call bookRemote.postBooking");
  }

  @override
  Future<bool> deleteBooking(bookingID) async {
    if (await networkInfo.isConnected) {
      Response response = await connector.delete("/api/1/bookings/" + bookingID.toString() + "/");
      if(response.statusCode == 200){
        return true;
      }
      else{
        return false;
      }
    }
    return false;
  }
}
