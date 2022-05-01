import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:washee/core/account/user.dart';
import 'package:washee/features/booking/data/models/booking_entity.dart';
import 'package:washee/features/booking/data/models/booking_model.dart';
import 'package:washee/features/booking/domain/repositories/book_repository.dart';
import 'package:washee/features/booking/domain/usecases/post_booking.dart';

class MockBookRepository extends Mock implements BookRepository {}

void main() {
  late PostBookingUsecase sut_usecase;
  late MockBookRepository mockRepo;
  late Booking booking;
  late BookingModel? mockBookingModel;
  late PostBookingParams params;

  setUp(() {
    mockRepo = MockBookRepository();
    sut_usecase = PostBookingUsecase(repository: mockRepo);
    // create a user
    var user = ActiveUser();
    user.initUser(1, "test@test.test", "test", [
      {'account_id': 1, 'name': "test_account", 'balance': 20.0}
    ]);
    // create a booking
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

    params = PostBookingParams(
        startTime: booking.startTime!,
        machineResource: booking.machineResource,
        accountResource: booking.accountResource,
        serviceResource: booking.serviceResource);
  });

  test(
      """should verify that 1 call has been made to 
      the repository BookRepository's postBooking method """,
      () async {
    // arrange

    when(() => mockRepo.postBooking(
            startTime: booking.startTime!,
            machineResource: booking.machineResource,
            serviceResource: booking.serviceResource,
            accountResource: booking.accountResource))
        .thenAnswer((_) async => mockBookingModel);
    // act
    final result = await sut_usecase.call(params);

    // assert
    expect(result, mockBookingModel);
    verify(() => mockRepo.postBooking(
        startTime: booking.startTime!,
        machineResource: booking.machineResource,
        serviceResource: booking.serviceResource,
        accountResource: booking.accountResource)).called(1);
  });

/// theese next two tests has to be run in turn first and second. they show that the setUp function is called between every test function.///
/// 
  // test('Should verify that setUp is recalled with every test function', () {
  //   booking.startTime = booking.startTime!.add( Duration(days:1));
    
  //   verifyNever(() => mockRepo.postBooking(
  //       startTime: booking.startTime!.add( Duration(days:1)),
  //       machineResource: booking.machineResource,
  //       serviceResource: booking.serviceResource,
  //       accountResource: booking.accountResource));
  // });

  // test('Test that setUp is called with every test function', () {
  //     expect(booking.startTime,DateTime(2022, 01, 01, 2, 0) );
  // });



  
}
