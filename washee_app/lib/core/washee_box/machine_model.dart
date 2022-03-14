import 'package:washee/core/washee_box/machine_entity.dart';

class MachineModel extends Machine {
  final String machineID;
  final String name;
  final String machineType;
  DateTime? startTime;
  DateTime? endTime;

  MachineModel({
    required this.machineID,
    required this.name,
    required this.machineType,
    this.startTime,
    this.endTime,
  }) : super(
          endTime: endTime,
          startTime: startTime,
          name: name,
          machineID: machineID,
          machineType: machineType,
        );

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

  bool get isAvailable {
    if (startTime == null || endTime == null) {
      return true;
    } else if (DateTime.now().isBefore(endTime!) &&
        DateTime.now().isAfter(startTime!)) {
      return false;
    }
    return true;
  }
}
