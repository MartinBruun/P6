import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:washee/core/network/network_info.dart';
import 'package:washee/features/booking/data/datasources/book_remote.dart';
import 'package:washee/features/booking/data/repositories/book_repository_impl.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockBookRemote extends Mock implements BookRemote {}

void main() {
  late BookRepositoryImpl sut_impl;
  late MockNetworkInfo mockNetwotkInfo;
  late MockBookRemote mockRemote;
  late int? accontID;
  late bool? activated;

  setUp(() {
    accontID = 12;
    activated = false;
    mockRemote = MockBookRemote();
    mockNetwotkInfo = MockNetworkInfo();
    sut_impl = BookRepositoryImpl(
      networkInfo: mockNetwotkInfo,
      remote: mockRemote
    );
  });

  test('should verify that remote.postBooking() is called 1 times', () {
    
  });
}
