import 'package:washee/core/washee_box/washee_entity.dart';

class WasheeBoxModel extends WasheeBox {
  final String ssid;
  final String name;
  final String machineType;
  final DateTime startTime;
  final DateTime endTime;

  WasheeBoxModel({
    required this.ssid,
    required this.name,
    required this.machineType,
    required this.startTime,
    required this.endTime,
  }) : super(
            name: name,
            ssid: ssid,
            machineType: machineType,
            startTime: startTime,
            endTime: endTime);

  @override
  List<Object?> get props => [ssid, name, machineType, startTime, endTime];

  factory WasheeBoxModel.fromJson(Map<String, dynamic> json) {
    return WasheeBoxModel(
      ssid: json['ssid'],
      name: json['name'],
      machineType: json['machineType'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
    );
  }
}
