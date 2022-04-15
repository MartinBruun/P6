import 'package:washee/core/environments/base_config.dart';

import "base_config.dart";

class RALLEFARCONFIG implements BaseConfig {
  // Should be removed and migrate to use .env.dev file instead!
  String get webApiHost => "http://192.168.87.145:8000";

  String get boxApiHost => "http://192.168.87.145:8001";
  String get boxWifiSSID => "YourWifi";         // Name of the wifi
  String get boxWifiPassword => "YourPassword"; // REMEMBER to avoid adding this to git! NEVER COMMIT YOUR PASSWORD! Should be injected from gitignored file, but i don't know how...
  bool get boxHasInternetAccess => true;        // When running in dev, we use localhost that has internet access, so set to true'
}
