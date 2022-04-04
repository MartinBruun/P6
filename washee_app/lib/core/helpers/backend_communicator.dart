import 'package:dio/dio.dart';

import '../errors/exception_handler.dart';

abstract class BackendCommunicator {
  Future<Map<String, dynamic>> getBookings();
  String get getBackendURL;
}

// THIS HAS BEEN IMPLEMENTED INSPIRED BY BOX_COMMUNICATOR BUT IS NOT ACTUALLY USED IN THE CODE!

class BackendCommunicatorImpl implements BackendCommunicator {
  Dio dio = new Dio();

  BackendCommunicatorImpl({required this.dio});

  String get getBackendURL => "http://10.0.2.2/api/1"; // Replace with actual production endpoint for production

  @override
  Future<Map<String, dynamic>> getBookings() async {
    String bookingURL = getBackendURL + "/bookings";
    Response response;

    response = await dio.get(bookingURL);
    if (response.statusCode == 200) {
      if (response.data != null) {
        return response.data;
      }
      else{
        ExceptionHandler().handle("Did receive null response from backend, was this intended?", log:true, show:true);
      }
    } else {
      ExceptionHandler().handle("Could not get response from backend with statuscode: " 
        + response.statusCode.toString() 
        + " with response"
        + response.data['response'], log:true, show:true);
      return response.data;
    }
    return response.data;
  }
}
