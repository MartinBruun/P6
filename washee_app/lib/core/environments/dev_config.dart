import 'package:washee/core/environments/base_config.dart';

import "base_config.dart";

class DevConfig implements BaseConfig {
  String get webApiHost => "http://localhost:8000";
  
  String get boxApiHost => "http://localhost:8001";
}