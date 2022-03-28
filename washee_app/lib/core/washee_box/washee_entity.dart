import 'package:equatable/equatable.dart';

import 'machine_entity.dart';

class WasheeBox extends Equatable {
  final String ssid;
  final String name;
  final List<Machine> machines;

  WasheeBox({required this.ssid, required this.name, this.machines = const []});

  @override
  List<Object?> get props => [
        ssid,
        name,
        machines,
      ];
}
