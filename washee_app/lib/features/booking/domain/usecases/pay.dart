import 'package:washee/core/usecases/usecase.dart';

import '../repositories/book_repository.dart';

class PayUseCase implements UseCase<bool, NoParams> {
  final BookRepository repository;

  PayUseCase({required this.repository});

  @override
  Future<bool> call(NoParams params) async {
    return await repository.pay();
  }
}
