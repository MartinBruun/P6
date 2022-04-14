<<<<<<< HEAD
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
=======
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:washee/features/booking/data/models/booking_model.dart';
import 'package:washee/core/errors/exception_handler.dart';

const String ENDPOINT = "http://localhost:8000/api/1/bookings/"; // localhost when using a browser
// "http://10.0.2.2:8000/api/1/bookings/" Calling localhost from an Android phone or emulator

// THIS IS MADE SIDE BY SIDE WITH BACKEND_COMMUNICATOR!!! Presently, this is the one being used in the home screen

abstract class BookRemote {
  Future<List<BookingModel>> getAllBookings();
  Future<bool> book();
  Future<bool> pay();
}

class BookLaundryRemoteImpl implements BookRemote {
   Dio dio = new Dio();

  BookLaundryRemoteImpl({required this.dio});

  @override
  Future<List<BookingModel>> getAllBookings() async {
    List<BookingModel> allBookings = [];
    final response = await dio.get(ENDPOINT);
    if (response.statusCode == 200) {
      allBookings = (jsonDecode(response.data) as List).map((i) => BookingModel.fromJson(i)).toList();
    }
    else{
      ExceptionHandler().handle("Could not get response from backend with statuscode: " 
        + response.statusCode.toString() 
        + " with response"
        + response.data['response'], log:true, show:true);
    }
    return allBookings;
  }
>>>>>>> 4c1fcfe8f154a0ac67a76aae1f5cbfacd796a4ed

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
