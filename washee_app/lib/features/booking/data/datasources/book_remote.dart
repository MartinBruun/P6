import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:washee/core/booking/booking_model.dart';
import 'package:washee/core/errors/exception_handler.dart';

const String ENDPOINT = "http://localhost:8000/api/1/bookings";

Future<http.Response> fetchAlbum() {
  return http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
}

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
    final response = await http.get(Uri.parse(ENDPOINT));
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
