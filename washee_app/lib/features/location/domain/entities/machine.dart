import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Machine extends Equatable {
  final String machineID;
  final String name;
  final String machineType;
  DateTime? startTime;
  DateTime? endTime;
  bool activated;

  Machine({
    required this.machineID,
    required this.name,
    required this.machineType,
    this.startTime,
    this.endTime,
    this.activated = false
  });

  @override
  List<Object?> get props => [machineID, name, machineType, startTime, endTime, activated];
}
