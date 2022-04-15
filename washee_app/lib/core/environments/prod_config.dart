import 'package:flutter_dotenv/flutter_dotenv.dart';
import "base_config.dart";

class ProdConfig implements BaseConfig {
  // Should remove fallbacks to anonymise data, but don't know if it is possible for XCode to work then?
  String get webApiHost => dotenv.get("WEB_API_HOST",fallback: "https://www.emilbruun.dk");

  String get boxApiHost => dotenv.get("BOX_API_HOST", fallback: "http://washeebox.local:8001");
  String get boxWifiSSID => dotenv.get("BOX_WIFI_SSID", fallback: "washeenet");
  String get boxWifiPassword => dotenv.get("BOX_WIFI_PASSWORD", fallback: "raspberry");
  bool get boxHasInternetAccess => dotenv.get("BOX_HAS_INTERNET", fallback: "false") == "false";
}