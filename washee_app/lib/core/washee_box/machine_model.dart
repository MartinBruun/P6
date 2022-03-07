import 'package:washee/core/washee_box/machine_entity.dart';

class MachineModel extends Machine {
  final String machineID;
  final String name;
  final String machineType;
  final DateTime startTime;
  final DateTime endTime;

  MachineModel({
    required this.machineID,
    required this.name,
    required this.machineType,
    required this.startTime,
    required this.endTime,
  }) : super(
            endTime: endTime,
            startTime: startTime,
            name: name,
            machineID: machineID,
            machineType: machineType);

  @override
  List<Object?> get props => [
        machineID,
        name,
        machineType,
        startTime,
        endTime,
      ];

  factory MachineModel.fromJson(Map<String, dynamic> json) {
    return MachineModel(
        machineID: json['machineID'],
        name: json['name'],
        machineType: json['machineType'],
        startTime: DateTime.parse(json['startTime']),
        endTime: DateTime.parse(json['endTime']));
  }
}
