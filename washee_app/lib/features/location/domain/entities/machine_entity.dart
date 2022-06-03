import 'package:equatable/equatable.dart';
import 'package:washee/features/location/domain/entities/machine_type_entity.dart';

// ignore: must_be_immutable
class MachineEntity extends Equatable {
  final int id;
  final String name;
  final MachineTypeEntity machineType;
  DateTime? startTime;
  DateTime? endTime;
  bool activated;

  MachineEntity({
    required this.id,
    required this.name,
    required this.machineType,
    this.startTime,
    this.endTime,
    this.activated = false
  });

  @override
  List<Object?> get props => [id, name, machineType, startTime, endTime, activated];
}
