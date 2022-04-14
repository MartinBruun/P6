import 'package:washee/core/helpers/web_communicator.dart';
import 'package:washee/core/network/network_info.dart';
import 'package:washee/features/booking/data/models/booking_entity.dart';
import 'package:washee/features/booking/data/models/booking_model.dart';

abstract class BookRemote {
  Future<List<BookingModel>> getBookings();
  List<BookingModel> constructBookingList(List<Map<String, dynamic>> bookingsAsJson);
  Future<BookingModel> postBooking();
}

class BookRemoteImpl implements BookRemote {
  WebCommunicator communicator;
  NetworkInfo networkInfo;

  BookRemoteImpl({required this.communicator, required this.networkInfo});

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
      _bookings.add(BookingModel.fromJson(booking));
    }

    return _bookings;
  }

  Future<BookingModel> postBooking(){
    throw new Exception("Not implemented yet, dunno how");
  }
}
