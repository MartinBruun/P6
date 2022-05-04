import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:washee/core/network/network_info.dart';
import 'package:washee/features/booking/data/datasources/book_remote.dart';
import 'package:washee/features/booking/data/models/booking_model.dart';
import 'package:washee/features/booking/data/repositories/book_repository_impl.dart';

class MockBookRemote extends Mock implements BookRemote {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late MockNetworkInfo mockNetworkInfo;
  late BookRepositoryImpl repositoryImpl;
  late MockBookRemote mockBookRemote;
  late BookingModel tBooking;

  setUp() {
    mockNetworkInfo = MockNetworkInfo();
    mockBookRemote = MockBookRemote();
    repositoryImpl = BookRepositoryImpl(
        networkInfo: mockNetworkInfo, remote: mockBookRemote);
    tBooking = BookingModel(
        bookingID: 12,
        startTime: DateTime(2022, 01, 01, 2, 0),
        machineResource: "test",
        serviceResource: "test",
        accountResource: "test");
  }

  test(
    'should return a booking model from the remote on a valid network connection',
    () async {
      // arrange

      setUp();
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockBookRemote.postBooking(
          machineResource: tBooking.machineResource,
          accountResource: tBooking.accountResource,
          serviceResource: tBooking.serviceResource,
          startTime: tBooking.startTime!)).thenAnswer((_) async => tBooking);

      // act
      final result = await repositoryImpl.postBooking(
          startTime: tBooking.startTime!,
          machineResource: tBooking.machineResource,
          serviceResource: tBooking.serviceResource,
          accountResource: tBooking.accountResource);

      // assert
      expect(result, tBooking);
      verify(() => mockBookRemote.postBooking).called(1);
    },
  );
}
