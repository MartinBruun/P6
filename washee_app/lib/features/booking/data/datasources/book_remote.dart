import 'package:washee/core/helpers/web_communicator.dart';
import 'package:washee/core/network/network_info.dart';
import 'package:washee/features/booking/data/models/booking_model.dart';

abstract class BookRemote {
  Future<List<BookingModel>> getBookings({
    bool? activated,
    DateTime? startTimeGreaterThan,
    DateTime? startTimeLessThan,
    DateTime? endTimeGreaterThan,
    DateTime? endTimeLessThan,
    int? machineID,
    int? accountID,
    int? serviceID
  });
  List<BookingModel> constructBookingList(
      List<Map<String, dynamic>> bookingsAsJson);
  Future<BookingModel> postBooking(
      {required DateTime startTime,
      required String machineResource,
      required String serviceResource,
      required String accountResource});
  BookingModel constructBooking(Map<String, dynamic> bookingAsJson);
  Future<bool> deleteBooking(bookingID);
}

class BookRemoteImpl implements BookRemote {
  WebCommunicator communicator;
  NetworkInfo networkInfo;

  BookRemoteImpl({required this.communicator, required this.networkInfo});

  @override
  Future<List<BookingModel>> getBookings({
    bool? activated,
    DateTime? startTimeGreaterThan,
    DateTime? startTimeLessThan,
    DateTime? endTimeGreaterThan,
    DateTime? endTimeLessThan,
    int? machineID,
    int? accountID,
    int? serviceID
  }) async {
    if (await networkInfo.isConnected) {
      var data = await communicator.getCurrentBookings(
        activated: activated,
        startTimeGreaterThan: startTimeGreaterThan,
        startTimeLessThan: startTimeLessThan,
        endTimeGreaterThan: endTimeGreaterThan,
        endTimeLessThan: endTimeLessThan,
        machineID: machineID,
        accountID: accountID,
        serviceID: serviceID
      );
      return constructBookingList(data);
    }
    throw new Exception(
        "I would argue this should not return an empty list. No response from database is not the same as there are no bookings on the database!");
  }

  List<BookingModel> constructBookingList(
      List<Map<String, dynamic>> bookingsAsJson) {
    List<BookingModel> _bookings = [];
    for (var booking in bookingsAsJson) {
      _bookings.add(BookingModel.fromJson(booking));
    }

    return _bookings;
  }

  Future<BookingModel> postBooking(
      {required DateTime startTime,
      required String machineResource,
      required String serviceResource,
      required String accountResource}) async {
    var data = await communicator.postBooking(
        startTime: startTime,
        machineResource: machineResource,
        serviceResource: serviceResource,
        accountResource: accountResource);
    if (data.isEmpty) {
      throw new Exception(
          "Wont make sense to return an 'empty' booking model, what is that?");
    } else {
      return constructBooking(data);
    }
  }

  BookingModel constructBooking(Map<String, dynamic> bookingAsJson) {
    return BookingModel.fromJson(bookingAsJson);
  }

  @override
  Future<bool> deleteBooking(bookingID) async {
    if (await networkInfo.isConnected) {
      bool wasDeleted = await communicator.deleteBooking(bookingID);
      return wasDeleted;
    }
    return false;
  }
}
