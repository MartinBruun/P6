import 'package:washee/core/usecases/usecase.dart';

import '../repositories/unlock_repository.dart';

class UnlockUseCase implements UseCase<bool, NoParams> {
  final UnlockRepository repository;

  UnlockUseCase({required this.repository});

  @override
  Future<bool> call(NoParams params) async {
    return await repository.unlock();
  }
}
