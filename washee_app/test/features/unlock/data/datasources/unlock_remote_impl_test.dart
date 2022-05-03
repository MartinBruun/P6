import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:washee/core/helpers/box_communicator.dart';
import 'package:washee/core/helpers/date_helper.dart';
import 'package:washee/core/helpers/web_communicator.dart';
import 'package:washee/core/network/network_info.dart';
import 'package:washee/features/booking/data/models/booking_model.dart';
import 'package:washee/features/unlock/data/datasources/unlock_remote.dart';

class MockWebCommunicator extends Mock implements WebCommunicator {}

class MockBoxCommunicator extends Mock implements BoxCommunicator {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockDateHelper extends Mock implements DateHelper {}

void main() {
  late UnlockRemoteImpl unlockRemote;
  late MockWebCommunicator mockWebCommunicator;
  late MockBoxCommunicator mockBoxCommunicator;
  late MockNetworkInfo mockNetworkInfo;

  setUp() {
    mockWebCommunicator = MockWebCommunicator();
    mockBoxCommunicator = MockBoxCommunicator();
    mockNetworkInfo = MockNetworkInfo();
    unlockRemote = UnlockRemoteImpl(
      boxCommunicator: mockBoxCommunicator,
      webCommunicator: mockWebCommunicator,
      networkInfo: mockNetworkInfo
    );
  }
  test(
      """
        When UnlockRemote is unlocking a valid list of bookings,
        it should return the same list of unlocked bookings,
        given the WebCommunicator is assumed to have correctly send its data to the backend, 
        and the BoxCommunicator is assumed to correctly having send its data to the box,
        and the NetworkInfo is assumed to have valid info on internet access and connections,
        and the DateHelper is assumed to having correctly handling the times
      """,
      () async {
    // arrange
    setUp();
    MockDateHelper mockBookingModelDateHelper = MockDateHelper();
    when(() => mockBookingModelDateHelper.convertToNonNaiveTime(DateTime(2022,2,2,12,0,0)))
      .thenAnswer((_) => "2022-02-02T12:00:00Z");
    BookingModel fakeBooking = BookingModel(
        dateHelper: mockBookingModelDateHelper,
        bookingID: 12,
        startTime: DateTime(2022,2,2,12,0,0),
        machineResource: "http://test.com/machines/12",
        serviceResource: "http://test.com/services/12",
        accountResource: "http://test.com/accouts/12");
    List<BookingModel> listOfBookingInput = [fakeBooking];

    List<Map<String,dynamic>> bookingsFromWebCommunicator = [
      {
        'id': 12,
        'start_time': "2022-02-02T12:00:00T",
        'end_time': "2022-02-02T12:00:00T",
        'created': "2022-02-02T12:00:00T",
        'last_updated': "2022-02-02T12:00:00T",
        'activated': "true",
        'machine': "http://test.com/machines/12",
        'service': "http://test.com/services/12",
        'account': "http://test.com/accounts/12"
      }
    ];

    Map<String,dynamic> informationFromBox = {
      "???": "???" // I don't know right now, should be made more clear
    }

    // arrange (dependencies)
    when(() => mockWebCommunicator.updateBooking(listOfBookingInput[0].resource, activated: true))
      .thenAnswer((_) async => bookingsFromWebCommunicator);
    when(() => mockBoxCommunicator.lockOrUnlock("unlock", listOfBookingInput[0].machine, Duration(hours: 2, minutes: 30)))
      .thenAnswer((_) async => informationFromBox);
    when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

    // act
    final result = await unlockRemote.unlock(listOfBookingInput);

    // assert
    expect (result, listOfBookingInput);

    // assert (dependencies)
    verifyInOrder([
      () => mockNetworkInfo.isConnected,
      () => mockWebCommunicator.updateBooking(listOfBookingInput[0].resource, activated:true),
      () => mockNetworkInfo.connectToBoxWifi(),
      () => mockBoxCommunicator.lockOrUnlock("unlock", fakeBooking.machine, Duration(hours: 2, minutes: 30)),
      () => mockNetworkInfo.disconnectFromBoxWifi(),
    ]);
  });
}