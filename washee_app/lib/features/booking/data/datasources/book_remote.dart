import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:washee/core/booking/booking_model.dart';
import 'package:washee/core/errors/exception_handler.dart';

const String ENDPOINT = "http://localhost:8000/api/1/bookings/";

abstract class BookRemote {
  Future<List<BookingModel>> getAllBookings();
  Future<bool> book();
  Future<bool> pay();
}

class BookLaundryRemoteImpl implements BookRemote {
  final http.Client client;
  BookLaundryRemoteImpl({required this.client});

  @override
  Future<List<BookingModel>> getAllBookings() async {
    List<BookingModel> allBookings = [];
    print("INSIDE FUNC"); // REMOVE BEFORE MERGE TO MASTER!
    final response = await http.get(Uri.parse(ENDPOINT), headers: { 
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*" // THIS HAS NO SECURITY!!! BE AWARE!!!
        });
    print(response.body); // REMOVE BEFORE MERGE TO MASTER!
    if (response.statusCode == 200) {
      allBookings = (jsonDecode(response.body) as List).map((i) => BookingModel.fromJson(i)).toList();
    }
    else{
      ExceptionHandler().handle("Did not receive All Bookings from backend, but received statusCode: " + response.statusCode.toString(), log:true);
    }
    return allBookings;
  }

  @override
  Future<bool> book() async {
    return Future.delayed(Duration(seconds: 5)).then((value) => true);
  }

  @override
  Future<bool> pay() async {
    return Future.delayed(Duration(seconds: 5)).then((value) => true);
  }
}
