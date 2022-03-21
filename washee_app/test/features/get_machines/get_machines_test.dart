import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:washee/core/helpers/box_communicator.dart';
import 'package:mockito/annotations.dart';
import 'package:washee/features/get_machines/data/repositories/get_machines_repo_impl.dart';

import '../../fixtures/fixture_reader.dart';
import '../unlock/data/repositories/unlock_repo_impl_test.mocks.dart';
import 'get_machines_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<BoxCommunicator>(
      as: #MockCommunicator, returnNullOnMissingStub: true),
])
void main() {
  test(
    'should return a list of MachineModel from JSON response',
    () async {
      // arrange
      var networkInfo = MockNetworkInfo();
      var communicator = MockCommunicator();
      var repository = GetMachinesRepositoryImpl(
          communicator: communicator, networkInfo: networkInfo);

      var string = fixture("machine_list.json");
      var stringAsJson = json.decode(string);
      // act
      final result = repository.constructMachineList(stringAsJson);

      // assert
      expect(result.length, 4);
    },
  );
}
