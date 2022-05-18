import 'package:washee/features/location/domain/entities/washee_entity.dart';

import '../../domain/entities/machine_entity.dart';

class WasheeBoxModel extends WasheeBox {
  final String ssid;
  final String name;
  final List<Machine> machines;

  WasheeBoxModel(
      {required this.ssid, required this.name, this.machines = const []})
      : super(
          name: name,
          ssid: ssid,
          machines: machines,
        );

  @override
  List<Object?> get props => [
        ssid,
        name,
      ];

  factory WasheeBoxModel.fromJson(Map<String, dynamic> json) {
    return WasheeBoxModel(
        ssid: json['ssid'],
        name: json['name'],
        machines: List<Machine>.from(json['machines']));
  }
}
