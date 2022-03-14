import 'package:equatable/equatable.dart';

class NetworkResult extends Equatable {
  final String ssid;
  final String name;
  final String ip;

  NetworkResult({required this.ssid, required this.name, required this.ip});

  @override
  List<Object?> get props => [ssid, name, ip];
}
