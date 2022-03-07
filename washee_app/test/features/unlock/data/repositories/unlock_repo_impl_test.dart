import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:washee/core/network/network_info.dart';
import 'package:washee/features/unlock/data/datasources/unlock_remote.dart';
import 'package:washee/features/unlock/data/repositories/unlock_repo_impl.dart';

import 'unlock_repo_impl_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<NetworkInfo>(as: #MockNetworkInfo, returnNullOnMissingStub: true),
  MockSpec<UnlockRemote>(as: #MockRemote, returnNullOnMissingStub: true)
])
void main() {
  var mockRemote = MockRemote();
  var mockNetworkInfo = MockNetworkInfo();
  var repository =
      UnlockRepositoryImpl(remote: mockRemote, networkInfo: mockNetworkInfo);

  group("Internet connection", () {
    test(
      'should return true when there is a internet connection',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        final result = await mockNetworkInfo.isConnected;

        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    test(
      'should return false when there is no internet connection',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

        // act
        final result = await mockNetworkInfo.isConnected;

        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );
  });

  test(
    'should return true when a successfull unlocking is done and there is a network conenction ',
    () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemote.unlock()).thenAnswer((_) async => true);

      // act
      final result = await repository.unlock();

      // assert
      verify(mockRemote.unlock());
      expect(result, true);
    },
  );

  test(
    'should return false when unlocking fails because there is no active network connection',
    () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      // act
      final result = await repository.unlock();

      // assert
      verify(mockRemote.unlock()).called(0);
      expect(result, false);
    },
  );
}
