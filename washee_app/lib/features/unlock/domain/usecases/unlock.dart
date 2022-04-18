import 'package:equatable/equatable.dart';
import 'package:washee/core/usecases/usecase.dart';
import 'package:washee/core/washee_box/machine_model.dart';
import 'package:washee/features/unlock/domain/usecases/connect_box_wifi.dart';
import 'package:washee/features/unlock/domain/usecases/disconnect_box_wifi.dart';
import 'package:washee/injection_container.dart';

import '../repositories/unlock_repository.dart';

class UnlockUseCase implements UseCase<MachineModel?, UnlockParams> {
  final UnlockRepository repository;

  UnlockUseCase({required this.repository});

  @override
  Future<MachineModel?> call(UnlockParams params) async {
    MachineModel? machine =
        await repository.unlock(params.machine, params.duration);

    return machine;
  }
}

class UnlockParams extends Equatable {
  final MachineModel machine;
  final Duration duration;

  UnlockParams({required this.machine, required this.duration});

  @override
  List<Object?> get props => [machine, duration];
}
