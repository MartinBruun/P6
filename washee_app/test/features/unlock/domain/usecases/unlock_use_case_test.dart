import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:washee/core/helpers/date_helper.dart';
import 'package:washee/features/booking/data/models/booking_model.dart';
import 'package:washee/features/unlock/data/repositories/unlock_repo_impl.dart';
import 'package:washee/features/unlock/domain/usecases/unlock.dart';

class MockUnlockRepoImpl extends Mock implements UnlockRepositoryImpl {}

class MockDateHelper extends Mock implements DateHelper {}

void main() {
  late UnlockUseCase unlockUseCase;
  late MockUnlockRepoImpl mockUnlockRepo;
  late MockDateHelper mockDateHelper;
  late BookingModel fakeBooking;

  setUp() {
    mockUnlockRepo = MockUnlockRepoImpl();
    unlockUseCase = UnlockUseCase(repository: mockUnlockRepo);

    DateTime initStartTime = DateTime(2022, 01, 01, 2, 0);
    mockDateHelper = MockDateHelper();
    when(() => mockDateHelper.convertToNonNaiveTime(initStartTime))
      .thenAnswer((_) => "2022-01-01T01:02:00Z");
    fakeBooking = BookingModel(
        dateHelper: mockDateHelper,
        bookingID: 12,
        startTime: initStartTime,
        machine: "http://test.com/machines/12",
        serviceResource: "http://test.com/services/12",
        accountResource: "http://test.com/accouts/12");
  }

  test(
      """
        When UnlockUseCase is called with a list of valid, non-activated bookings,
        it should return a list of the same bookings being activated,
        given the UnlockRepository is assumed to returning the same activated bookings, 
        and the DateHelper is assumed to having correctly handled the times.
      """,
      () async {
    // arrange
    setUp();
    List<BookingModel> bookingsToUnlock = [fakeBooking];
    UnlockParams params = UnlockParams(bookingsToUnlock);

    // arrange (dependencies)
    BookingModel fakeActivatedBooking = fakeBooking;
    fakeActivatedBooking.activated = true;
    when(() => mockUnlockRepo.unlock(bookingsToUnlock)
        .thenAnswer((_) async =>  fakeBooking));
    
    // act
    final result = await unlockUseCase.call(params);

    // assert
    expect(result.length, 1);
    expect(result[0].startTime, fakeBooking.startTime);
    expect(result[0].bookingID, fakeBooking.bookingID);
    expect(result[0].activated, true);

    // assert (dependencies)
    verify(() => mockUnlockRepo.unlock(bookingsToUnlock)).called(1);
  });
}