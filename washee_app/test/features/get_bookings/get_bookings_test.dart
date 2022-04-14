import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:washee/features/booking/data/models/booking_model.dart';

import '../../fixtures/fixture_reader.dart';

List<BookingModel> constructBookingList(Map<String, dynamic> bookingsAsJson) {
  List<BookingModel> _bookings = [];
  for (var booking in bookingsAsJson['data']) {
    _bookings.add(BookingModel.fromJSON(booking));
  }

  return _bookings;
}

void main() {
  test(
    'should return a list of Booking Models from JSON response',
    () async {
      // arrange

      var string = fixture("bookings.json");
      var stringAsJson = json.decode(string);
      print(stringAsJson);
      // // act
      final result = constructBookingList(stringAsJson);

      // // assert
      expect(result.length, 6);
    },
  );
}
