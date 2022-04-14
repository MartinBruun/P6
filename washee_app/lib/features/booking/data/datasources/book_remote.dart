import 'package:washee/core/helpers/web_communicator.dart';
import 'package:washee/core/network/network_info.dart';
import 'package:washee/features/booking/data/models/booking_model.dart';

abstract class BookRemote {
  Future<bool> book();
  Future<bool> pay();
  Future<List<BookingModel>> getBookings();
}

class BookLaundryRemoteImpl implements BookRemote {
  WebCommunicator communicator;
  NetworkInfo networkInfo;

  BookLaundryRemoteImpl(
      {required this.communicator, required this.networkInfo});

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

  List<BookingModel> constructBookingList(Map<String, dynamic> machinesAsJson) {
    List<BookingModel> _machines = [];
    for (var machine in machinesAsJson['machines']) {
      _machines.add(BookingModel.fromJSON(machine));
    }

    return _machines;
  }
}
