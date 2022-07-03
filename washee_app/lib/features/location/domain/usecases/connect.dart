import 'package:dio/dio.dart';
import 'package:washee/core/standards/base_usecase/usecase.dart';
import 'package:washee/features/location/data/repositories/connect_repo.dart';

class ConnectUseCase implements UseCase<Response, NoParams> {
  final ConnectRepository repository;

  ConnectUseCase({required this.repository});

  @override
  Future<Response> call(NoParams params) async {
    return await repository.connect();
  }
}
