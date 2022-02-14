import 'package:http/http.dart' as http;

const String ENDPOINT = "blabla";

abstract class BookLaundryRemote {
  Future<bool> bookLaundryMachine();
}

class BookLaundryRemoteImpl implements BookLaundryRemote {
  final http.Client client;
  BookLaundryRemoteImpl({required this.client});

  @override
  Future<bool> bookLaundryMachine() {
    return Future.delayed(Duration(seconds: 5)).then((value) => true);
  }
}
