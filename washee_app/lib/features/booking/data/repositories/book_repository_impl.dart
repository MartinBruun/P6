import 'package:washee/features/booking/data/models/booking_model.dart';
import 'package:washee/features/booking/domain/repositories/book_repository.dart';

import '../../../../core/network/network_info.dart';
import '../datasources/book_remote.dart';

class BookRepositoryImpl implements BookRepository {
  final NetworkInfo networkInfo;
  final BookRemote remote;

  BookRepositoryImpl({required this.networkInfo, required this.remote});

  @override
  Future<List<BookingModel>> getBookings() async {
    return await remote.getBookings();
  }

  @override
  Future<BookingModel> postBooking({
      required DateTime startTime, 
      required String machineResource, 
      required String serviceResource, 
      required String accountResource
    }) async {
      return await remote.postBooking(
        startTime:startTime, 
        machineResource:machineResource, 
        serviceResource:serviceResource, 
        accountResource:accountResource);
  }
}
