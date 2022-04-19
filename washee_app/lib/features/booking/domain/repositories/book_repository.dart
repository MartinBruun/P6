import 'package:washee/features/booking/data/models/booking_model.dart';

abstract class BookRepository {
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
