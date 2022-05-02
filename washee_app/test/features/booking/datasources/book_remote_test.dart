import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:washee/core/helpers/web_communicator.dart';
import 'package:washee/core/network/network_info.dart';
import 'package:washee/features/booking/data/datasources/book_remote.dart';
import 'package:washee/features/booking/data/models/booking_model.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockWebCommnicator extends Mock implements WebCommunicator {}

// class MockConstructBooking extends Mock implements BookRemote.constructBooking {}

main() {
  late BookRemoteImpl sut_bookRemoteImpl;
  late MockNetworkInfo mockNetworkInfo;
  late MockWebCommnicator mockWebCommnicator;
  // late MockBookingModelMethods mockBookingModelMethods;
  late BookingModel? mockBookingModel;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockWebCommnicator = MockWebCommnicator();
    // mockBookingModelMethods = MockBookingModelMethods();

    sut_bookRemoteImpl = BookRemoteImpl(
        networkInfo: mockNetworkInfo, communicator: mockWebCommnicator);

    var booking1_start_time = DateTime(2022, 01, 01, 2, 0);
    mockBookingModel = BookingModel(
        bookingID: 12,
        startTime: booking1_start_time,
        machineResource: "https://mocked_machineResource/1",
        serviceResource: "https://mocked_serviceResource/1",
        accountResource: "https://mocked_accountResource/1");

    Map<String, dynamic> mockReturnedBookings = {
      "start_time": "test",
      "end_time": "test",
      "created": "2022-04-14T13:07:08.711Z",
      "last_updated": "2022-04-14T13:07:08.711Z",
      "machine": "https://mocked_machineResource/1",
      "service": "https://mocked_serviceResource/1",
      "account": "https://mocked_accountResource/1",
      "id": "12",
      "activated": false,
    };
    // when((() => constructBooking([mockReturnedBookings])))
  });

  test(
      'should verify that comunicator.postBooking is called 1 time when isConnected is true',
      () async {
    //arrange
    Map<String, dynamic> mockReturnedBookings = {
      "start_time": "test",
      "end_time": "test",
      "created": "2022-04-14T13:07:08.711Z",
      "last_updated": "2022-04-14T13:07:08.711Z",
      "machine": "https://mocked_machineResource/1",
      "service": "https://mocked_serviceResource/1",
      "account": "https://mocked_accountResource/1",
      "id": "12",
      "activated": false,
    };

    when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    when(() => mockWebCommnicator.postBooking(
            startTime: mockBookingModel!.startTime!,
            accountResource: mockBookingModel!.accountResource,
            machineResource: mockBookingModel!.machineResource,
            serviceResource: mockBookingModel!.serviceResource))
        .thenAnswer((_) async => mockReturnedBookings);
    //act
    var result = await sut_bookRemoteImpl.postBooking(
        startTime: mockBookingModel!.startTime!,
        accountResource: mockBookingModel!.accountResource,
        machineResource: mockBookingModel!.machineResource,
        serviceResource: mockBookingModel!.serviceResource);

    //assert
    expect(result, mockReturnedBookings);
    verify(() => mockWebCommnicator.postBooking(
        startTime: mockBookingModel!.startTime!,
        accountResource: mockBookingModel!.accountResource,
        machineResource: mockBookingModel!.machineResource,
        serviceResource: mockBookingModel!.serviceResource)).called(1);
  });

  test(
      'should verify that comunicator.postBooking is never called when isConnected is false',
      () async {
    //arrange
    Map<String, dynamic> mockReturnedBookings = {
      "start_time": mockBookingModel!.startTime!,
      "end_time":
          mockBookingModel!.startTime!.add(Duration(hours: 2, minutes: 30)),
      "created": "2022-04-14T13:07:08.711Z",
      "last_updated": "2022-04-14T13:07:08.711Z",
      "machine": "https://mocked_machineResource/1",
      "service": "https://mocked_serviceResource/1",
      "account": "https://mocked_accountResource/1",
      "id": "12",
      "activated": false
    };

    when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    when(() => mockWebCommnicator.postBooking(
            startTime: mockBookingModel!.startTime!,
            accountResource: mockBookingModel!.accountResource,
            machineResource: mockBookingModel!.machineResource,
            serviceResource: mockBookingModel!.serviceResource))
        .thenAnswer((_) async => mockReturnedBookings);
    //act
    // var result = sut_bookRemoteImpl.postBooking(
    //     startTime: mockBookingModel!.startTime!,
    //     accountResource: mockBookingModel!.accountResource,
    //     machineResource: mockBookingModel!.machineResource,
    //     serviceResource: mockBookingModel!.serviceResource);

    //assert
    expect(
        sut_bookRemoteImpl.postBooking(
            startTime: mockBookingModel!.startTime!,
            accountResource: mockBookingModel!.accountResource,
            machineResource: mockBookingModel!.machineResource,
            serviceResource: mockBookingModel!.serviceResource),
        throwsA(isA<Exception>()));
        
    verifyNever(() => mockWebCommnicator.postBooking(
        startTime: mockBookingModel!.startTime!,
        accountResource: mockBookingModel!.accountResource,
        machineResource: mockBookingModel!.machineResource,
        serviceResource: mockBookingModel!.serviceResource));
  });
}
