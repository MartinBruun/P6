import 'package:washee/core/errors/exception_handler.dart';
import 'package:washee/core/helpers/date_helper.dart';
import 'package:washee/features/booking/data/models/booking_model.dart';
import 'package:washee/features/booking/domain/repositories/book_repository.dart';

import '../../../../core/network/network_info.dart';
import '../datasources/book_remote.dart';

class BookRepositoryImpl implements BookRepository {
  final NetworkInfo networkInfo;
  final BookRemote remote;

  BookRepositoryImpl({required this.networkInfo, required this.remote});

  @override
  Future<List<BookingModel>> getBookings(
      {int? accountID, bool? activated}) async {
    List<Map<String, dynamic>> bookingsJson =
        await remote.getBookings(accountID: accountID, activated: activated);
    List<BookingModel> bookingModels = constructBookingList(bookingsJson);
    return bookingModels;
  }

  @override
  Future<BookingModel?> postBooking(
      {required DateTime startTime,
      required String machineResource,
      required String serviceResource,
      required String accountResource}) async {
    if (await networkInfo.isConnected) {
      Map<String, dynamic> postetBookingJson = await remote.postBooking(
          startTime: startTime,
          machineResource: machineResource,
          serviceResource: serviceResource,
          accountResource: accountResource);
      return constructBooking(postetBookingJson);
    }
    return null;
  }

  @override
  Future<bool> hasCurrentBooking(
      {required int accountID, required int machineID}) async {
    if (await networkInfo.isConnected) {
      List<Map<String, dynamic>> validBooking = await remote.getBookings(
          accountID: accountID,
          machineID: machineID,
          startTimeLessThan:
              DateTime.parse(DateHelper().convertToNonNaiveTime(DateHelper().currentTime())),
          endTimeGreaterThan:
              DateTime.parse(DateHelper().convertToNonNaiveTime(DateHelper().currentTime())));
      if (validBooking.isEmpty) {
        return false;
      } else {
        return true;
      }
    }
    ExceptionHandler()
        .handle("Not on network", log: true, show: true, crash: false);
    throw new Exception("Not on network");
  }

  @override
  Future<bool> deleteBooking({required int bookingID}) async {
    if (await networkInfo.isConnected) {
      bool wasDeleted = await remote.deleteBooking(bookingID);
      return wasDeleted;
    }
    ExceptionHandler()
        .handle("Not on network", log: true, show: true, crash: false);
    throw new Exception("Not on network");
  }

  List<BookingModel> constructBookingList(
      List<Map<String, dynamic>> bookingsAsJson) {
    List<BookingModel> _bookings = [];
    for (var booking in bookingsAsJson) {
      _bookings.add(constructBooking(booking));
    }
    return _bookings;
  }

  BookingModel constructBooking(Map<String, dynamic> bookingAsJson) {
    return BookingModel.fromJson(bookingAsJson);
  }

}
