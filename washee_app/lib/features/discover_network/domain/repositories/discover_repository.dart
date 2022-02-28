import 'package:connectivity_plus/connectivity_plus.dart';

abstract class DiscoverRepository {
  Future<List<ConnectivityResult>> discover();
}
