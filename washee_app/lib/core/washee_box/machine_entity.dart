import 'package:equatable/equatable.dart';

class Machine extends Equatable {
  final String machineID;
  final String name;
  final String machineType;
  final DateTime? startTime;
  final DateTime? endTime;

  Machine({
    required this.machineID,
    required this.name,
    required this.machineType,
    this.startTime,
    this.endTime,
  });

  @override
  List<Object?> get props => [machineID, name, machineType, startTime, endTime];
}
