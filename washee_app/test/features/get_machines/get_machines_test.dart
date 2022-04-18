import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:washee/core/helpers/box_communicator.dart';
import 'package:mockito/annotations.dart';
import 'package:washee/features/get_machines/data/repositories/get_machines_repo_impl.dart';

import '../../fixtures/fixture_reader.dart';
import '../unlock/data/repositories/unlock_repo_impl_test.mocks.dart';
import 'get_machines_test.mock_web.dart';

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
      var communicator = MockWebCommunicator();
      var repository = GetMachinesRepositoryImpl(
          communicator: communicator, networkInfo: networkInfo);

      var mockMachinesAsJson = listOfMockMachines();
      // act
      final result = repository.constructMachineList(mockMachinesAsJson);

      // assert
      expect(result.length, 4);
    },
  );
}

List<Map<String,dynamic>> listOfMockMachines(){
  return [
        {
            "endTime": "null",
            "machineID": "l1",
            "machineType": "laundrymachine",
            "name": "vaskemaskine 1",
            "pin": 17,
            "startTime": "null"
        },
        {
            "endTime": "2022-03-07T10:15:26",
            "machineID": "l2",
            "machineType": "laundrymachine",
            "name": "vaskemaskine 2",
            "pin": 27,
            "startTime": "2022-03-07T08:15:26"
        },
        {
            "endTime": "2022-03-07T10:15:26",
            "machineID": "t1",
            "machineType": "dryermachine",
            "name": "tørretumbler 1",
            "pin": 23,
            "startTime": "2022-03-07T08:15:26"
        },
        {
            "endTime": "2022-03-07T10:15:26",
            "machineID": "t2",
            "machineType": "dryermachine",
            "name": "tørretumbler 2",
            "pin": 12,
            "startTime": "2022-03-07T08:15:26"
        }
    ];
}