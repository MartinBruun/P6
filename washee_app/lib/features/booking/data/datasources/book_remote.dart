import 'package:washee/core/helpers/web_communicator.dart';
import 'package:washee/core/network/network_info.dart';
import 'package:washee/features/booking/data/models/booking_model.dart';

abstract class BookRemote {
  Future<bool> book();
  Future<bool> pay();
  Future<List<BookingModel>> getBookings();
}

class BookRemoteImpl implements BookRemote {
  WebCommunicator communicator;
  NetworkInfo networkInfo;

  BookRemoteImpl({required this.communicator, required this.networkInfo});

  @override
  Future<bool> book() async {
    return Future.delayed(Duration(seconds: 5)).then((value) => true);
  }

  @override
  Future<bool> pay() async {
    return Future.delayed(Duration(seconds: 5)).then((value) => true);
  }

  @override
  Future<List<BookingModel>> getBookings() async {
    if (await networkInfo.isConnected) {
      var data = await communicator.getCurrentBookings(1);
      return constructBookingList(data);
    }
    return List.empty();
  }

  List<BookingModel> constructBookingList(
      List<Map<String, dynamic>> bookingsAsJson) {
    List<BookingModel> _bookings = [];
    for (var booking in bookingsAsJson) {
      _bookings.add(BookingModel.fromJSON(booking));
    }

    return _bookings;
  }
}
