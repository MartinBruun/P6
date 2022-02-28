import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:washee/core/usecases/usecase.dart';

import '../repositories/discover_repository.dart';

class DiscoverUseCase implements UseCase<List<ConnectivityResult>, NoParams> {
  final DiscoverRepository repository;

  DiscoverUseCase({required this.repository});

  @override
  Future<List<ConnectivityResult>> call(NoParams params) async {
    return await repository.discover();
  }
}
