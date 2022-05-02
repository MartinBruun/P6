import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:washee/core/network/network_info.dart';
import 'package:washee/features/booking/data/datasources/book_remote.dart';
import 'package:washee/features/booking/data/models/booking_model.dart';
import 'package:washee/features/booking/data/repositories/book_repository_impl.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockBookRemote extends Mock implements BookRemote {}

void main() {
  late BookRepositoryImpl sut_bookRepositoryImpl;
  late MockNetworkInfo mockNetworkInfo;
  late MockBookRemote mockRemote;
  late BookingModel mockBookingModel;

  setUp(() {
    mockRemote = MockBookRemote();
    mockNetworkInfo = MockNetworkInfo();
    sut_bookRepositoryImpl =
        BookRepositoryImpl(networkInfo: mockNetworkInfo, remote: mockRemote);

    var booking1_start_time = DateTime(2022, 01, 01, 2, 0);
    mockBookingModel = BookingModel(
        bookingID: 12,
        startTime: booking1_start_time,
        machineResource: "https://mocked_machineResource/1",
        serviceResource: "https://mocked_serviceResource/1",
        accountResource: "https://mocked_accountResource/1");
  });

  test(
      'should verify that remote.postBooking() is called 1 times when isConnected is true',
      () async {
   
    //arrange
    when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    when(() => mockRemote.postBooking(
            startTime: mockBookingModel.startTime!,
            machineResource: mockBookingModel.machineResource,
            serviceResource: mockBookingModel.serviceResource,
            accountResource: mockBookingModel.accountResource))
        .thenAnswer((_) async => mockBookingModel);
    //act
    final result = await sut_bookRepositoryImpl.postBooking(
        startTime: mockBookingModel.startTime!,
        machineResource: mockBookingModel.machineResource,
        serviceResource: mockBookingModel.serviceResource,
        accountResource: mockBookingModel.accountResource);
    // assert
    expect(result, mockBookingModel);
    verify(() => mockRemote.postBooking(
        startTime: mockBookingModel.startTime!,
        machineResource: mockBookingModel.machineResource,
        serviceResource: mockBookingModel.serviceResource,
        accountResource: mockBookingModel.accountResource)).called(1);
  });

  test(
      'should verify that remote.postBooking() is never called when isConnected is false',
      () async {
    //arrange
    when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    when(() => mockRemote.postBooking(
            startTime: mockBookingModel.startTime!,
            machineResource: mockBookingModel.machineResource,
            serviceResource: mockBookingModel.serviceResource,
            accountResource: mockBookingModel.accountResource))
        .thenAnswer((_) async => mockBookingModel);
    //act
    final result = await sut_bookRepositoryImpl.postBooking(
        startTime: mockBookingModel.startTime!,
        machineResource: mockBookingModel.machineResource,
        serviceResource: mockBookingModel.serviceResource,
        accountResource: mockBookingModel.accountResource);
    // assert
    expect(result, null);
    verifyNever(() => mockRemote.postBooking(
        startTime: mockBookingModel.startTime!,
        machineResource: mockBookingModel.machineResource,
        serviceResource: mockBookingModel.serviceResource,
        accountResource: mockBookingModel.accountResource));
  });
}
