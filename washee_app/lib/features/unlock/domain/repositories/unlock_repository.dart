import 'package:dio/dio.dart';
import 'package:washee/core/washee_box/machine_model.dart';

abstract class UnlockRepository {
  Future<Response?> unlock(MachineModel machine, Duration duration);
}
