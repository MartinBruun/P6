import 'package:dio/dio.dart';
import 'package:washee/core/washee_box/machine_model.dart';

abstract class UnlockRepository {
  Future<MachineModel?> unlock(MachineModel machine, Duration duration);
}
