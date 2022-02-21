import 'package:http/http.dart' as http;

const String ENDPOINT = "blabla";

abstract class BookRemote {
  Future<bool> book();
  Future<bool> pay();
}

class BookLaundryRemoteImpl implements BookRemote {
  final http.Client client;
  BookLaundryRemoteImpl({required this.client});

  @override
  Future<bool> book() async {
    return Future.delayed(Duration(seconds: 5)).then((value) => true);
  }

  @override
  Future<bool> pay() async {
    return Future.delayed(Duration(seconds: 5)).then((value) => true);
  }
}
