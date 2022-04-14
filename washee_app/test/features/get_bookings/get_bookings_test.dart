import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:washee/features/booking/data/models/booking_model.dart';

import '../../fixtures/bookings.dart';
import '../../fixtures/fixture_reader.dart';

List<BookingModel> constructBookingList(
    List<Map<String, dynamic>> bookingsAsJson) {
  List<BookingModel> _bookings = [];
  for (var booking in bookingsAsJson) {
    _bookings.add(BookingModel.fromJson(booking));
  }

  return _bookings;
}

void main() {
  test(
    'should return a list of Booking Models from JSON response',
    () async {
      // arrange

      var bookings = getAllBookingsMock();
      // // act
      final result = constructBookingList(bookings);

      // // assert
      expect(result.length, 6);
    },
  );
}
