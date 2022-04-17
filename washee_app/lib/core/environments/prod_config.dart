import 'package:flutter_dotenv/flutter_dotenv.dart';
import "base_config.dart";

class ProdConfig implements BaseConfig {
  String get webApiHost => dotenv.get("WEB_API_HOST");

  String get boxApiHost => dotenv.get("BOX_API_HOST");
  String get boxWifiSSID => dotenv.get("BOX_WIFI_SSID");
  String get boxWifiPassword => dotenv.get("BOX_WIFI_PASSWORD");
  bool get boxHasInternetAccess => dotenv.get("BOX_HAS_INTERNET") == "true";
}