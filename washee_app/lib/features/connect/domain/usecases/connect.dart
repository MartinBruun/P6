import 'package:dio/dio.dart';
import 'package:washee/core/usecases/usecase.dart';

import '../repositories/connect_repository.dart';

class ConnectUseCase implements UseCase<Response, NoParams> {
  final ConnectRepository repository;

  ConnectUseCase({required this.repository});

  @override
  Future<Response> call(NoParams params) async {
    return await repository.connect();
  }
}
