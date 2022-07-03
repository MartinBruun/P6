import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:washee/core/externalities/box/box_communicator.dart';
import 'package:washee/features/location/data/datasources/web_machine_remote.dart';
import 'package:washee/features/location/data/repositories/get_machines_repo.dart';

class MockWebMachineRemote extends Mock implements WebMachineRemote {}
class MockCommunicator extends Mock implements BoxCommunicator {}

void main() {
  test(
    'should return a list of MachineModel from JSON response',
    () async {
      // arrange
      var mockMachineRemote = MockWebMachineRemote();
      var repository = GetMachinesRepositoryImpl(webMachineRemote: mockMachineRemote);

      var mockMachinesAsJson = listOfTestMachines();
      // act
      final result = repository.constructMachineList(mockMachinesAsJson);

      // assert
      expect(result.length, 4);
    },
  );
}

List<Map<String, dynamic>> listOfTestMachines() {
  return [
    {
      "endTime": "2022-03-07T10:15:26Z",
      "machineID": "l1",
      "machineType": "laundrymachine",
      "name": "vaskemaskine 1",
      "pin": 17,
      "startTime": "2022-03-07T10:15:26Z"
    },
    {
      "endTime": "2022-03-07T10:15:26Z",
      "machineID": "l2",
      "machineType": "laundrymachine",
      "name": "vaskemaskine 2",
      "pin": 27,
      "startTime": "2022-03-07T08:15:26Z"
    },
    {
      "endTime": "2022-03-07T10:15:26Z",
      "machineID": "t1",
      "machineType": "dryermachine",
      "name": "tørretumbler 1",
      "pin": 23,
      "startTime": "2022-03-07T08:15:26Z"
    },
    {
      "endTime": "2022-03-07T10:15:26Z",
      "machineID": "t2",
      "machineType": "dryermachine",
      "name": "tørretumbler 2",
      "pin": 12,
      "startTime": "2022-03-07T08:15:26Z"
    }
  ];
}
