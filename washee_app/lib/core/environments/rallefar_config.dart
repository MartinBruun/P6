import 'package:washee/core/environments/base_config.dart';

import "base_config.dart";

class RALLEFARCONFIG implements BaseConfig {
  String get webApiHost => "http://192.168.1.5:8000";

  String get boxApiHost => "http://192.168.1.5:8001";
}
