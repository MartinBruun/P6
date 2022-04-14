import 'package:washee/features/booking/data/models/booking_model.dart';

abstract class BookRepository {
  Future<bool> book();
  Future<bool> pay();
  Future<List<BookingModel>> getBookings();
}
