import 'package:washee/core/environments/base_config.dart';

import "base_config.dart";

class DevConfig implements BaseConfig {
  String get webApiHost => "http://10.0.2.2:8000";
  
  String get boxApiHost => "http://10.0.2.2:8001";
}