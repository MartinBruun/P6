import 'package:washee/core/errors/exception_handler.dart';
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
  Future<BookingModel?> postBooking(
      {required DateTime startTime,
      required String machineResource,
      required String serviceResource,
      required String accountResource}) async {
    if (await networkInfo.isConnected) {
      return await remote.postBooking(
          startTime: startTime,
          machineResource: machineResource,
          serviceResource: serviceResource,
          accountResource: accountResource);
    }
    return null;
  }

  @override
  Future<bool> hasCurrentBooking({
    required int accountID,
    required int machineID
  }) async {
    if (await networkInfo.isConnected){
      List<BookingModel> validBooking = await remote.getBookings(
        accountID: accountID,
        machineID: machineID,
        startTimeLessThan: DateTime.now(),
        endTimeGreaterThan: DateTime.now()
      );
      if (validBooking.isEmpty){
        return false;
      }
      else{
        return true;
      }
    }
    ExceptionHandler().handle("Not on network", log:true, show:true, crash:false);
    throw new Exception("Not on network");
  }
}
