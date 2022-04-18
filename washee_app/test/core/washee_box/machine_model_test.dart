import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:washee/core/helpers/date_helper.dart';
import 'package:washee/core/washee_box/machine_entity.dart';
import 'package:washee/core/washee_box/machine_model.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  test(
    'should be a subclass of Machine entity',
    () async {
      // arrange
      final tMachineModel = MachineModel(
          machineID: "test1",
          name: "testName",
          machineType: "laundryMachine",
          startTime: DateHelper.currentTime(),
          endTime: DateTime(2022, 03, 07, 10, 15, 00));

      // assert
      expect(tMachineModel, isA<Machine>());
    },
  );

  test(
    'should return a valid MachineModel from json',
    () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture("machine.json"));
      final tMachineModel = MachineModel(
          machineID: "l1",
          name: "vaskemaskine1",
          machineType: "laundryMachine",
          startTime: DateTime.parse("2022-02-27T13:27:00"),
          endTime: DateTime.parse("2022-03-27T13:27:00"));

      // act
      final result = MachineModel.fromJson(jsonMap);

      // assert
      expect(result, tMachineModel);
    },
  );
}
