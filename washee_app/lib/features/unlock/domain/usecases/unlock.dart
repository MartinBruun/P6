import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:washee/core/usecases/usecase.dart';
import 'package:washee/core/washee_box/machine_model.dart';

import '../repositories/unlock_repository.dart';

class UnlockUseCase implements UseCase<Response?, UnlockParams> {
  final UnlockRepository repository;

  UnlockUseCase({required this.repository});

  @override
  Future<Response?> call(UnlockParams params) async {
    return await repository.unlock(params.machine, params.duration);
  }
}

class UnlockParams extends Equatable {
  final MachineModel machine;
  final Duration duration;

  UnlockParams({required this.machine, required this.duration});

  @override
  List<Object?> get props => [machine, duration];
}
