import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:washee/core/errors/exception_handler.dart';
import 'package:wifi_iot/wifi_iot.dart';

import 'package:washee/core/environments/environment.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  NetworkSecurity get chosenSecurity;
  String get boxDomainName;
  String get boxDomainPassword;
  Future<bool> getWifiAccessPermissions();
  Future<bool> connectToBoxWifi();
  Future<bool> disconnectFromBoxWifi();
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectionChecker;

  NetworkInfoImpl({required this.connectionChecker});

  @override
  NetworkSecurity get chosenSecurity => NetworkSecurity.WPA;

  @override
  String get boxDomainName => "???";

  @override
  String get boxDomainPassword => "???"; // Should be injected by secret production environment variables

  @override
  Future<bool> get isConnected async {
    final result = await connectionChecker.checkConnectivity();
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> getWifiAccessPermissions() async {
    WiFiForIoTPlugin.showWritePermissionSettings(true);
    return true;
  }

  @override
  Future<bool> connectToBoxWifi() async {
    try{
      WiFiForIoTPlugin.connect(boxDomainName,
                          password: boxDomainPassword,
                          joinOnce: true,
                          withInternet: true, // Should be changed depending on production or dev environment being run
                          isHidden: false,
                          security: chosenSecurity);
      WiFiForIoTPlugin.forceWifiUsage(true);
      return true;
    }
    catch (e) {
      ExceptionHandler().handle("Could not connect to wifi from NetworkInfo with error: " + e.toString(), log:true, show:true, crash:false);
      return false;
    }
  }

  @override
  Future<bool> disconnectFromBoxWifi() async {
    try{
      WiFiForIoTPlugin.disconnect();
      return true;
    }
    catch (e) {
      ExceptionHandler().handle("Could not disconnect from wifi at NetworkInfo with error: " + e.toString(), log:true, show:true, crash:false);
      return false;
    }
  }
}
