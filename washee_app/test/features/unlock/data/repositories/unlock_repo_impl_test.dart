import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:washee/core/externalities/network/network_info.dart';
import 'package:washee/core/standards/time/date_helper.dart';
import 'package:washee/features/location/data/datasources/unlock_remote.dart';
import 'package:washee/features/location/data/repositories/unlock_repo_impl.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}
class MockRemote extends Mock implements UnlockRemote {}
class MockDateHelper extends Mock implements DateHelper {}

void main() {
  var mockRemote = MockRemote();
  var mockNetworkInfo = MockNetworkInfo();
  var mockDateHelper = MockDateHelper();
  var repository =
      UnlockRepositoryImpl(remote: mockRemote, networkInfo: mockNetworkInfo, dateHelper: mockDateHelper);

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
}
