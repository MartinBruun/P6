import 'package:flutter_test/flutter_test.dart';
import 'package:washee/features/booking/data/models/booking_model.dart';
import 'package:washee/features/booking/domain/entities/booking.dart';

void main() {
  test(
    'should be a subclass of Booking entity',
    () async {
      // arrange
      final tBookingModel =
          BookingModel(date: DateTime.now(), bookingID: 1, bookingName: "test");

      // assert
      expect(tBookingModel, isA<Booking>());
    },
  );

  // test(
  //   'should return a valid BookingModel from a JSON response',
  //   () async {
  //     // arrange
  //     final tBookingModel = BookingModel(
  //         date: DateTime(2022, 2, 7, 13, 24, 00),
  //         bookingID: 1,
  //         bookingName: "test");
  //     final Map<String, dynamic> jsonMap = json.decode("booking.json");

  //     // act
  //     final result = BookingModel.fromJSON(jsonMap);

  //     // assert
  //     expect(result, tBookingModel);
  //   },
  // );
}
