import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:washee/core/helpers/date_helper.dart';
import 'package:washee/core/network/network_info.dart';
import 'package:washee/features/booking/data/datasources/book_remote.dart';
import 'package:washee/features/booking/data/models/booking_model.dart';
import 'package:washee/features/booking/data/repositories/book_repository_impl.dart';
import 'package:timezone/timezone.dart' as tz;

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockBookRemote extends Mock implements BookRemote {}

class MockDateHelper extends Mock implements DateHelper {}

class FakeLocation extends Mock implements tz.Location {}

// class MockBookingModel extends Mock implements BookingModelHelper {}

void main() {
  late BookRepositoryImpl sut_bookRepositoryImpl;
  late MockNetworkInfo mockNetworkInfo;
  late MockBookRemote mockRemote;
  // late MockBookingModel mockBookingHelper;
  late MockDateHelper mockDateHelper;
  late BookingModel mockBookingModelResult;
  late Map<String, dynamic> mockBookingJson;
  late DateTime currentTime;

  setUp(() {
    registerFallbackValue(FakeLocation());
    mockRemote = MockBookRemote();
    mockNetworkInfo = MockNetworkInfo();
    // mockBookingHelper = MockBookingModel();
    mockDateHelper = MockDateHelper();
    sut_bookRepositoryImpl =
        BookRepositoryImpl(networkInfo: mockNetworkInfo, remote: mockRemote );
    currentTime = DateTime.now();
    var booking1_start_time = DateTime(2022, 01, 01, 2, 0);
    var booking1_end_time =
        booking1_start_time.add(Duration(hours: 2, minutes: 30));
    mockBookingJson = {
      "bookingID": 12,
      "startTime": booking1_start_time,
      "endTime": booking1_end_time,
      "machineResource": "https://mocked_machineResource/1",
      "serviceResource": "https://mocked_serviceResource/1",
      "accountResource": "https://mocked_accountResource/1"
    };

    mockBookingModelResult = BookingModel(
        bookingID: 12,
        startTime: booking1_start_time,
        endTime: booking1_end_time,
        machineResource: "https://mocked_machineResource/1",
        serviceResource: "https://mocked_serviceResource/1",
        accountResource: "https://mocked_accountResource/1");
  });


//TODO:make a test for bookings
//   test(
//       'should verify that remote.postBooking() is called 1 times when isConnected is true',
//       () async {
//     //arrange
//     // when((() => mockBookingHelper.usingJson(mockBookingJson))).thenReturn(mockBookingModelResult);

// // TODO: this does not work, because mockDateHelper is a singleton
//     when(() => mockDateHelper.convertToNonNaiveTime(currentTime))
//         .thenReturn(currentTime.toString());
//     when(() => mockDateHelper.currentTime()).thenReturn(currentTime);
//     when(() => mockDateHelper.from(any(), any())).thenReturn(currentTime);
//     when(() => mockDateHelper.getLocation('Europe/Copenhagen'))
//         .thenReturn(FakeLocation());

//     when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
//     when(() => mockRemote.postBooking(
//             startTime: mockBookingJson["startTime"],
//             machineResource: mockBookingJson["machineResource"],
//             serviceResource: mockBookingJson["serviceResource"],
//             accountResource: mockBookingJson["accountResource"]))
//         .thenAnswer((_) async => mockBookingJson);
    

//     //act
//     final result = await sut_bookRepositoryImpl.postBooking(
//         startTime: mockBookingJson["startTime"],
//         machineResource: mockBookingJson["machineResource"],
//         serviceResource: mockBookingJson["serviceResource"],
//         accountResource: mockBookingJson["accountResource"]);
//     // assert
//     verify(() => mockDateHelper.getLocation('Europe/Copenhagen')).called(1);
//     //simple test
//     expect(result, mockBookingModelResult);
//     //informational test
//     expect(result!.startTime!, mockBookingJson["startTime"]);
//     expect(result.endTime!, mockBookingJson["endTime"]);
//     expect(result.accountResource, mockBookingJson["accountResource"]);
//     expect(result.machineResource, mockBookingJson["machineResource"]);
//     expect(result.serviceResource, mockBookingJson["serviceResource"]);

//     verify(() => mockRemote.postBooking(
//         startTime: mockBookingJson["startTime"],
//         machineResource: mockBookingJson["machineResource"],
//         serviceResource: mockBookingJson["serviceResource"],
//         accountResource: mockBookingJson["accountResource"])).called(1);
//   });

  test(
      'should verify that remote.postBooking() is never called when isConnected is false',
      () async {
    //arrange
    when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    when(() => mockRemote.postBooking(
            startTime: mockBookingJson["startTime"],
            machineResource: mockBookingJson["machineResource"],
            serviceResource: mockBookingJson["serviceResource"],
            accountResource: mockBookingJson["accountResource"]))
        .thenAnswer((_) async => mockBookingJson);
    //act
    final result = await sut_bookRepositoryImpl.postBooking(
        startTime: mockBookingJson["startTime"],
        machineResource: mockBookingJson["machineResource"],
        serviceResource: mockBookingJson["serviceResource"],
        accountResource: mockBookingJson["accountResource"]);
    // assert
    expect(result, null);
    verifyNever(() => mockRemote.postBooking(
        startTime: mockBookingJson["startTime"],
        machineResource: mockBookingJson["machineResource"],
        serviceResource: mockBookingJson["serviceResource"],
        accountResource: mockBookingJson["accountResource"]));
  });
}
