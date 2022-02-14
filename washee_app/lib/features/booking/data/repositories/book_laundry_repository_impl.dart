import 'package:washee/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:washee/features/booking/domain/repositories/book_laundry_repository.dart';

import '../../../../core/network/network_info.dart';
import '../datasources/book_laundry_remote.dart';

class BookLaundryRepositoryImpl implements BookLaundryRepository {
  final NetworkInfo networkInfo;
  final BookLaundryRemote remote;

  BookLaundryRepositoryImpl({required this.networkInfo, required this.remote});

  @override
  Future<Either<Failure, bool>> bookLaundryMachine() async {
    if (await networkInfo.isConnected) {
      return Right(await remote.bookLaundryMachine());
    }
    return Left(BookingFailure(message: "No connection to the internet"));
  }
}
