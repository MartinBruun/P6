import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract class BookLaundryRepository {
  Future<Either<Failure, bool>> bookLaundryMachine();
}
