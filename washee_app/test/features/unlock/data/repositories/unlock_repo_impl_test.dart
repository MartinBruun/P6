import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:washee/core/externalities/network/network_info.dart';
import 'package:washee/features/location/data/models/box_machine_model.dart';
import 'package:washee/features/location/data/datasources/unlock_remote.dart';
import 'package:washee/features/location/data/repositories/unlock_repo_impl.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}
class MockRemote extends Mock implements UnlockRemote {}

void main() {
  var mockRemote = MockRemote();
  var mockNetworkInfo = MockNetworkInfo();
  var repository =
      UnlockRepositoryImpl(remote: mockRemote, networkInfo: mockNetworkInfo);

  group("Internet connection", () {
    test(
      'should verify that there is an internet connection',
      () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        await mockNetworkInfo.isConnected;

        // assert
        verify(() => mockNetworkInfo.isConnected);
      },
    );

    test(
      'should verify that there is no internet connection',
      () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

        // act
        await mockNetworkInfo.isConnected;

        // assert
        verify(() => mockNetworkInfo.isConnected);
      },
    );
  });

  test(
    'should return null when unlocking fails due to no active network connection',
    () async {
      // arrange
      MachineModel tMachine =
          MachineModel(machineID: "123", name: "Test", machineType: "laundry");
      Duration tduration = Duration(hours: 2, minutes: 30);
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      // act
      var result = await repository.unlock(tMachine, tduration);

      // assert
      verifyNever(() => mockRemote.unlock(tMachine, tduration));
      expect(result, null);
    },
  );
}
