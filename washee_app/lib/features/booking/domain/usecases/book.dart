import 'package:washee/core/usecases/usecase.dart';

import '../repositories/book_repository.dart';

class BookUseCase implements UseCase<bool, NoParams> {
  final BookRepository repository;

  BookUseCase({required this.repository});

  @override
  Future<bool> call(NoParams params) async {
    return await repository.book();
  }
}
