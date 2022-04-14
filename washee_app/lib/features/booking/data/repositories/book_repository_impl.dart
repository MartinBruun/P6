import 'package:washee/features/booking/data/models/booking_model.dart';
import 'package:washee/features/booking/domain/repositories/book_repository.dart';

import '../../../../core/network/network_info.dart';
import '../datasources/book_remote.dart';

class BookRepositoryImpl implements BookRepository {
  final NetworkInfo networkInfo;
  final BookRemote remote;

  BookRepositoryImpl({required this.networkInfo, required this.remote});

  @override
  Future<bool> book() async {
    if (await networkInfo.isConnected) {
      return await remote.book();
    }
    return false;
  }

  @override
  Future<bool> pay() async {
    if (await networkInfo.isConnected) {
      return await remote.pay();
    }
    return false;
  }

  @override
  Future<List<BookingModel>> getBookings() async {
    return await remote.getBookings();
  }
}
