import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:washee/core/environments/base_config.dart';

import "base_config.dart";

class DevConfig implements BaseConfig {
  String get webApiHost => dotenv.get("WEB_API_HOST", fallback: "http://10.0.2.2:8000");    

  String get boxApiHost => dotenv.get("BOX_API_HOST", fallback: "http://10.0.2.2:8001");    
  String get boxWifiSSID => dotenv.get("BOX_WIFI_SSID", fallback: "SecureInformation");                  
  String get boxWifiPassword => dotenv.get("BOX_WIFI_PASSWORD", fallback: "SecureInformation");          
  bool get boxHasInternetAccess => dotenv.get("BOX_HAS_INTERNET", fallback: "true") == "true"; // True for localhost in Dev
}
