import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:washee/core/network/network_info.dart';
import 'package:washee/features/booking/data/datasources/book_remote.dart';
import 'package:washee/features/booking/data/models/booking_entity.dart';
import 'package:washee/features/booking/data/models/booking_model.dart';
import 'package:washee/features/booking/data/repositories/book_repository_impl.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockBookRemote extends Mock implements BookRemote {}

void main() {
  late BookRepositoryImpl sut_impl;
  late MockNetworkInfo mockNetworkInfo;
  late MockBookRemote mockRemote;
  late Booking booking;
  late BookingModel mockBookingModel;
  late int? accontID;
  late bool? activated;

  setUp(() {
    accontID = 12;
    activated = false;
    mockRemote = MockBookRemote();
    mockNetworkInfo = MockNetworkInfo();
    sut_impl =
        BookRepositoryImpl(networkInfo: mockNetworkInfo, remote: mockRemote);

    var booking1_start_time = DateTime(2022, 01, 01, 2, 0);
    booking = Booking(
        bookingID: 12,
        startTime: booking1_start_time,
        machineResource: "https://mocked_machineResource/1",
        serviceResource: "https://mocked_serviceResource/1",
        accountResource: "https://mocked_accountResource/1");
    mockBookingModel = BookingModel(
        bookingID: booking.bookingID,
        startTime: booking.startTime,
        machineResource: booking.machineResource,
        serviceResource: booking.serviceResource,
        accountResource: booking.accountResource);
  });

  test(
      'should verify that remote.postBooking() is called 1 times when isConnected is true',
      () async {
    //check that postbooking is called 1 times
    // check that remote.postBooking() is called 1 times
    //arrange
    when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    when(() => mockRemote.postBooking(
            startTime: booking.startTime!,
            machineResource: booking.machineResource,
            serviceResource: booking.serviceResource,
            accountResource: booking.accountResource))
        .thenAnswer((_) async => mockBookingModel);
    //act
    final result = await sut_impl.postBooking(
        startTime: booking.startTime!,
        machineResource: booking.machineResource,
        serviceResource: booking.serviceResource,
        accountResource: booking.accountResource);
    // assert

    expect(result, mockBookingModel);
    verify(() => mockRemote.postBooking(
        startTime: booking.startTime!,
        machineResource: booking.machineResource,
        serviceResource: booking.serviceResource,
        accountResource: booking.accountResource)).called(1);
  });

  test(
      'should verify that remote.postBooking() is never called when isConnected is false',
      () async {
    //check that postbooking is called 1 times
    // check that remote.postBooking() is called 1 times
    //arrange
    when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    when(() => mockRemote.postBooking(
            startTime: booking.startTime!,
            machineResource: booking.machineResource,
            serviceResource: booking.serviceResource,
            accountResource: booking.accountResource))
        .thenAnswer((_) async => mockBookingModel);
    //act
    final result = await sut_impl.postBooking(
        startTime: booking.startTime!,
        machineResource: booking.machineResource,
        serviceResource: booking.serviceResource,
        accountResource: booking.accountResource);
    // assert

    expect(result, null);
    verifyNever(() => mockRemote.postBooking(
        startTime: booking.startTime!,
        machineResource: booking.machineResource,
        serviceResource: booking.serviceResource,
        accountResource: booking.accountResource));
  });
}
