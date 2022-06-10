

import 'package:washee/features/location/domain/entities/machine_entity.dart';

import 'first_machine_type.dart';

MachineEntity firstMachineFixture(){
  return MachineEntity(id: 1, name: "First Machine", machineType: firstMachineTypeFixture());
}

MachineEntity secondMachineFixture(){
  return MachineEntity(id: 2, name: "Second Machine", machineType: secondMachineTypeFixture());
}