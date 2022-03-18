import 'package:flutter_test/flutter_test.dart';
import 'package:washee/features/booking/data/models/booking_model.dart';
import 'package:washee/features/booking/domain/entities/booking.dart';

void main() {
  test(
    'should be a subclass of Booking entity',
    () async {
      // arrange & act
      final tBookingModel =
          BookingModel(date: DateTime.now(), bookingID: 1, bookingName: "test");

      // assert
      expect(tBookingModel, isA<Booking>());
    },
  );
}
