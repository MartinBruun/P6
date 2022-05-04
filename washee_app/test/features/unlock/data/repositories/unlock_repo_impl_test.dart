import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:washee/core/helpers/date_helper.dart';
import 'package:washee/core/network/network_info.dart';
import 'package:washee/features/booking/data/models/booking_model.dart';
import 'package:washee/features/unlock/data/datasources/unlock_remote.dart';
import 'package:washee/features/unlock/data/repositories/unlock_repo_impl.dart';

class MockUnlockRemote extends Mock implements UnlockRemoteImpl {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockDateHelper extends Mock implements DateHelper {}

void main() {
  late UnlockRepositoryImpl unlockRepository;
  late UnlockRemoteImpl mockUnlockRemote;
  late MockNetworkInfo mockNetworkInfo;
  late MockDateHelper mockDateHelper;
  late BookingModel fakeBooking;

  setUp() {
    mockUnlockRemote = MockUnlockRemote();
    mockNetworkInfo = MockNetworkInfo();
    mockDateHelper = MockDateHelper();
    unlockRepository = UnlockRepositoryImpl(remote: mockUnlockRemote, dateHelper: mockDateHelper);
  }
  test(
      """
        When UnlockRepository is unlocking a valid list of bookings,
        it should return the same list of bookings being activated,
        given the UnlockRemote is assumed to returning the same activated bookings, 
        and the DateHelper is assumed to having correctly handling the times.
      """,
      () async {
    // arrange
    setUp();

    // arrange (dependencies)
    MockDateHelper mockBookingModelDateHelper = MockDateHelper();
    when(() => mockBookingModelDateHelper.convertToNonNaiveTime(DateTime(2022,2,2,12,0,0)))
      .thenAnswer((_) => "2022-02-02T12:00:00Z");
    fakeBooking = BookingModel(
        dateHelper: mockBookingModelDateHelper,
        bookingID: 12,
        startTime: DateTime(2022,2,2,12,0,0),
        machineResource: "http://test.com/machines/12",
        serviceResource: "http://test.com/services/12",
        accountResource: "http://test.com/accouts/12");
    List<BookingModel> listOfBookingInput = [fakeBooking];

    List<Map<String,dynamic>> expectedBookingJsonFromRemote = [
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
    when(() => mockUnlockRemote.unlock(listOfBookingInput))
        .thenAnswer((_) async => expectedBookingJsonFromRemote);
    when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

    // act
    final result = await unlockRepository.unlock(listOfBookingInput);

    // assert
    expect(result.length, 1);
    expect(result[0] is BookingModel, true);
    expect(result[0].bookingID, 12);
    expect(result[0]["activated"], true);

    // assert (dependencies)
    verifyInOrder([
      () async => await mockNetworkInfo.isConnected,
      () async => await mockUnlockRemote.unlock(listOfBookingInput))
    ]);
  });
}