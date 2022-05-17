abstract class BaseConfig {
  // Vars for the backend
  String get webApiHost;
  // Vars for the box
  String get boxApiHost;
  String get boxWifiSSID;
  String get boxWifiPassword;
  bool get boxHasInternetAccess;
}