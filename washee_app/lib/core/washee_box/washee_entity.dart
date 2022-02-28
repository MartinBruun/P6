import 'package:equatable/equatable.dart';

class WasheeBox extends Equatable {
  final String ssid;
  final String name;

  WasheeBox({required this.ssid, required this.name});

  @override
  List<Object?> get props => [ssid, name];
}
