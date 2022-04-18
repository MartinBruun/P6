import 'package:washee/core/helpers/date_helper.dart';
import 'package:washee/core/washee_box/machine_entity.dart';

// ignore: must_be_immutable
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

  Map<String, dynamic> toJson() => {
        'machineID': machineID,
        'name': name,
        'machineType': machineType,
        'startTime': startTime.toString(),
        'endTime': endTime.toString(),
      };

  factory MachineModel.fromJson(Map<String, dynamic> json) {
    return MachineModel(
      machineID: json['machineID'],
      name: json['name'],
      machineType: json['machineType'],
      startTime: json['startTime'] != "null"
          ? DateTime.parse(json['startTime'])
          : null,
      endTime:
          json['endTime'] != "null" ? DateTime.parse(json['endTime']) : null,
    );
  }

  bool get isAvailable {
    if (startTime == null || endTime == null) {
      return true;
    } else if (DateHelper.currentTime().isBefore(endTime!) &&
        DateHelper.currentTime().isAfter(startTime!)) {
      return false;
    }
    return true;
  }
}
