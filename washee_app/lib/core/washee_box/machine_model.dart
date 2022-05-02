import 'package:washee/core/helpers/date_helper.dart';
import 'package:washee/core/washee_box/machine_entity.dart';

// ignore: must_be_immutable
class MachineModel extends Machine {
  final String machineID;
  final String name;
  final String machineType;
  DateTime? startTime;
  DateTime? endTime;
  bool activated;

  MachineModel({
    required this.machineID,
    required this.name,
    required this.machineType,
    this.startTime,
    this.endTime,
    this.activated = false
  }) : super(
          endTime: endTime,
          startTime: startTime,
          name: name,
          machineID: machineID,
          machineType: machineType,
          activated:activated
        );

  @override
  List<Object?> get props => [
        machineID,
        name,
        machineType,
        startTime,
        endTime,
        activated
      ];

  Map<String, dynamic> toJson() => {
        'machineID': machineID,
        'name': name,
        'machineType': machineType,
        'startTime': startTime.toString(),
        'endTime': endTime.toString(),
      };

  factory MachineModel.fromJson(Map<String, dynamic> json) {
    MachineModel machine = MachineModel(
      machineID: json['machineID'].toString(),
      name: json['name'],
      machineType: json['machineType'],
      activated: json["activated"] == true ? json["activated"] : false,
      startTime: json['startTime'] != null
          ? DateTime.parse(json["startTime"].toString())
          : null,
      endTime:
          json['endTime'] != null ? DateTime.parse(json["endTime"].toString()) : null,
    );
    return machine;
  }

  bool get isAvailable {
    if (startTime == null || endTime == null) {
      return true;
    } else if (DateHelper().currentTime().isBefore(endTime!) &&
        DateHelper().currentTime().isAfter(startTime!)) {
      return false;
    }
    return true;
  }
}
