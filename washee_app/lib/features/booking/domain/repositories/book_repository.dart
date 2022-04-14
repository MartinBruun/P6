import 'package:washee/features/booking/data/models/booking_model.dart';

abstract class BookRepository {
  Future<List<BookingModel>> getBookings();
  Future<BookingModel> postBooking();
}
