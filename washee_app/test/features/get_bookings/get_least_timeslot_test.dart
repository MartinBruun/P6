import 'dart:core';

import 'package:flutter_test/flutter_test.dart';

List<DateTime> mockTimeSlots = [
  DateTime(2022, 01, 01, 2, 0),
  DateTime(2022, 01, 01, 2, 30),
  DateTime(2022, 01, 01, 3, 0),
  DateTime(2022, 01, 01, 3, 30),
  DateTime(2022, 01, 01, 4, 0),
  DateTime(2022, 01, 01, 4, 30),
];

DateTime? getLeastTimeSlot() {
  return mockTimeSlots
      .reduce((current, next) => current.compareTo(next) > 0 ? next : current);
}

void main() {
  test(
    'should return the smallest element in date time list',
    () async {
      // arrange

      var least = DateTime(2022, 01, 01, 2, 0);
      // // act
      final result = getLeastTimeSlot();

      // // assert
      expect(result, least);
    },
  );
}
