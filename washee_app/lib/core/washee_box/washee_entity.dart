import 'package:equatable/equatable.dart';

class WasheeBox extends Equatable {
  final String ssid;
  final String name;
  final String machineType;
  final DateTime startTime;
  final DateTime endTime;

  WasheeBox(
      {required this.ssid,
      required this.name,
      required this.machineType,
      required this.startTime,
      required this.endTime});

  @override
  List<Object?> get props => [ssid, name, machineType, startTime, endTime];
}
