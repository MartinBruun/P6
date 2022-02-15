import 'package:dartz/dartz.dart';
import 'package:washee/core/errors/failures.dart';
import 'package:washee/core/usecases/usecase.dart';

import '../repositories/book_laundry_repository.dart';

class BookLaundryUseCase implements UseCase<bool, NoParams> {
  final BookLaundryRepository repository;

  BookLaundryUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.bookLaundryMachine();
  }
}
