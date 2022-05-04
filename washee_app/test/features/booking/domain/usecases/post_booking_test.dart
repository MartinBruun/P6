import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:washee/core/account/user.dart';
import 'package:washee/features/booking/data/models/booking_model.dart';
import 'package:washee/features/booking/domain/repositories/book_repository.dart';
import 'package:washee/features/booking/domain/usecases/post_booking.dart';

class MockBookRepository extends Mock implements BookRepository {}

void main() {
  late PostBookingUsecase usecase;
  late MockBookRepository mockRepo;
  late BookingModel tBooking;

  setUp() {
    mockRepo = MockBookRepository();
    usecase = PostBookingUsecase(repository: mockRepo);
    var user = ActiveUser();
    user.initUser(1, "test@test.test", "test", [
      {'account_id': 1, 'name': "test_account", 'balance': 20.0}
    ]);
    tBooking = BookingModel(
        bookingID: 12,
        startTime: DateTime(2022, 01, 01, 2, 0),
        machineResource: "test",
        serviceResource: "test",
        accountResource: "test");
  }

  test(
      """should verify that a call has been made to the repository BookRepository""",
      () async {
    // arrange
    setUp();
    PostBookingParams params = PostBookingParams(
        startTime: tBooking.startTime!,
        machineResource: tBooking.machineResource,
        accountResource: tBooking.accountResource,
        serviceResource: tBooking.serviceResource);

    when(() => mockRepo.postBooking(
            startTime: tBooking.startTime!,
            machineResource: tBooking.machineResource,
            serviceResource: tBooking.serviceResource,
            accountResource: tBooking.accountResource))
        .thenAnswer((_) async => tBooking);
    // act
    final result = await usecase.call(params);

    // assert
    expect(result, tBooking);
    verify(() => mockRepo.postBooking(
        startTime: tBooking.startTime!,
        machineResource: tBooking.machineResource,
        serviceResource: tBooking.serviceResource,
        accountResource: tBooking.accountResource)).called(1);
  });
}
