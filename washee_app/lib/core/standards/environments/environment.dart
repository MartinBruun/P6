import 'package:washee/core/environments/base_config.dart';
import 'package:washee/core/environments/dev_config.dart';
import 'package:washee/core/environments/prod_config.dart';

class Environment {
  factory Environment() {
    return _singleton;
  }

  static final Environment _singleton = Environment._internal();

  Environment._internal();

  static const String DEV_ENV = ".env.dev";
  static const String PROD_ENV = ".env.prod";

  static const String DEV = 'DEV';
  static const String PROD = 'PROD';

  late BaseConfig config;

  initConfig(String environment) {
    config = _getConfig(environment);
  }

  BaseConfig _getConfig(String environment) {
    switch (environment) {
      case Environment.DEV:
        return DevConfig();
      default:
        return ProdConfig();
    }
  }
}
