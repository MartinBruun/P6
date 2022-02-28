import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:washee/core/washee_box/washee_entity.dart';
import 'package:washee/features/discover_network/domain/entities/network_result.dart';

class WasheeBoxModel extends WasheeBox {
  final String ssid;
  final String name;

  WasheeBoxModel({
    required this.ssid,
    required this.name,
  }) : super(name: name, ssid: ssid);

  @override
  List<Object?> get props => [ssid, name];

  factory WasheeBoxModel.fromNetworkResult(NetworkResult networkResult) {
    return WasheeBoxModel(ssid: networkResult.ssid, name: networkResult.name);
  }
}
