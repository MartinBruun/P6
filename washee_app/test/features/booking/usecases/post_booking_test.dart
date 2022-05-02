import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:washee/features/booking/data/models/booking_model.dart';
import 'package:washee/features/booking/domain/repositories/book_repository.dart';
import 'package:washee/features/booking/domain/usecases/post_booking.dart';

class MockBookRepository extends Mock implements BookRepository {}

void main() {
  late PostBookingUsecase sut_usecase;
  late MockBookRepository mockRepo;
  late BookingModel? mockBookingModel;
  late PostBookingParams params;

  setUp(() {
    mockRepo = MockBookRepository();
    sut_usecase = PostBookingUsecase(repository: mockRepo);
    
    // create a booking
    var booking1_start_time = DateTime(2022, 01, 01, 2, 0);
    mockBookingModel = BookingModel(
        bookingID: 12,
        startTime: booking1_start_time,
        machineResource: "https://mocked_machineResource/1",
        serviceResource: "https://mocked_serviceResource/1",
        accountResource: "https://mocked_accountResource/1");

    params = PostBookingParams(
        startTime: mockBookingModel!.startTime!,
        machineResource: mockBookingModel!.machineResource,
        accountResource: mockBookingModel!.accountResource,
        serviceResource: mockBookingModel!.serviceResource);
  });

  test(
      """should verify that 1 call has been made to 
      the repository BookRepository's postBooking method """,
      () async {

    // arrange
    when(() => mockRepo.postBooking(
            startTime: mockBookingModel!.startTime!,
            machineResource: mockBookingModel!.machineResource,
            serviceResource: mockBookingModel!.serviceResource,
            accountResource: mockBookingModel!.accountResource))
        .thenAnswer((_) async => mockBookingModel);
    // act
    final result = await sut_usecase.call(params);
    // assert
    expect(result, mockBookingModel);
    verify(() => mockRepo.postBooking(
        startTime: mockBookingModel!.startTime!,
        machineResource: mockBookingModel!.machineResource,
        serviceResource: mockBookingModel!.serviceResource,
        accountResource: mockBookingModel!.accountResource)).called(1);
  });

/// theese next two tests has to be run in turn first and second. they show that the setUp function is called between every test function.///
/// 
  // test('Should verify that setUp is recalled with every test function', () {
  //   mockBookingModel!.startTime = mockBookingModel!.startTime!.add( Duration(days:1));
    
  //   verifyNever(() => mockRepo.postBooking(
  //       startTime: mockBookingModel!.startTime!.add( Duration(days:1)),
  //       machineResource: mockBookingModel!.machineResource,
  //       serviceResource: mockBookingModel!.serviceResource,
  //       accountResource: mockBookingModel!.accountResource));
  // });

  // test('Test that setUp is called with every test function', () {
  //     expect(mockBookingModel!.startTime,DateTime(2022, 01, 01, 2, 0) );
  // });



  
}
