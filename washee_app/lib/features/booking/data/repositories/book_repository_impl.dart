import 'package:washee/core/standards/time/date_helper.dart';
import 'package:washee/features/booking/data/models/booking_model.dart';
import '../datasources/book_remote.dart';

abstract class IBookRepository {
  Future<List<BookingModel>> getBookings({
    int? accountID,
    bool? activated
  });
  Future<BookingModel?> postBooking(
      {required DateTime startTime,
      required String machineResource,
      required String serviceResource,
      required String accountResource});
  Future<bool> hasCurrentBooking({
    required int accountID,
    required int machineID
  });
  Future<bool> deleteBooking({required int bookingID});
}


class BookRepository implements IBookRepository {
  final BookRemote remote;

  BookRepository({required this.remote});

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
      Map<String, dynamic> postetBookingJson = await remote.postBooking(
          startTime: startTime,
          machineResource: machineResource,
          serviceResource: serviceResource,
          accountResource: accountResource);
      return constructBooking(postetBookingJson);
  }

  @override
  Future<bool> hasCurrentBooking(
    {required int accountID, required int machineID}) async {
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

  @override
  Future<bool> deleteBooking({required int bookingID}) async {
    bool wasDeleted = await remote.deleteBooking(bookingID);
    return wasDeleted;
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
