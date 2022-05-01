import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:washee/core/helpers/web_communicator.dart';
import 'package:washee/core/network/network_info.dart';
import 'package:washee/features/get_machines/data/repositories/get_machines_repo_impl.dart';

import '../../../get_machines/get_machines_test.dart';

class MockWebCommunicator extends Mock implements WebCommunicator {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late GetMachinesRepositoryImpl getMachinesRepositoryImpl;
  late MockNetworkInfo mockNetworkInfo;
  late MockWebCommunicator mockCommunicator;
  late var mockMachines;

  setUp() {
    mockCommunicator = MockWebCommunicator();
    mockNetworkInfo = MockNetworkInfo();
    getMachinesRepositoryImpl = GetMachinesRepositoryImpl(
        communicator: mockCommunicator, networkInfo: mockNetworkInfo);

    mockMachines = listOfTestMachines();
  }

  test(
    'should return an emtpy list on no internet connection',
    () async {
      // arrange
      setUp();
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      // act
      final result = await getMachinesRepositoryImpl.getMachines();

      // assert
      expect(result, new List.empty());
      verifyNever(() => mockCommunicator.getMachines());
    },
  );

  test(
    'should call the WebCommunicator and return a list of machine models on a valid internet connection',
    () async {
      // arrange
      setUp();
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockCommunicator.getMachines())
          .thenAnswer((_) async => mockMachines);

      // act
      final result = await getMachinesRepositoryImpl.getMachines();

      // assert
      expect(result.length, 4);
      verify(() => mockCommunicator.getMachines()).called(1);
    },
  );
}
