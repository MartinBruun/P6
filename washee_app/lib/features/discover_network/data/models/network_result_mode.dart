import 'package:washee/features/discover_network/domain/entities/network_result.dart';

class NetworkResultModel extends NetworkResult {
  final String ssid;
  final String name;
  final String ip;

  NetworkResultModel({required this.ssid, required this.name, required this.ip})
      : super(ip: ip, name: name, ssid: ssid);
}
