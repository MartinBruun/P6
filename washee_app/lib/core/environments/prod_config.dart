import "base_config.dart";

class ProdConfig implements BaseConfig {
  String get webApiHost => "https://www.emilbruun.dk";

  String get boxApiHost => "http://washeebox.local:8001";
}