import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class ServerFailure extends Failure {
  final String message;
  ServerFailure({this.message = ""});

  @override
  List<Object?> get props => [message];
}

class BookingFailure extends Failure {
  final String message;
  BookingFailure({this.message = ""});

  @override
  List<Object?> get props => [message];
}

class HTTPFailure extends Failure {
  final String message;
  HTTPFailure({this.message = ""});

  @override
  List<Object?> get props => [message];
}
