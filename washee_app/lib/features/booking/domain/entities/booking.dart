import 'package:equatable/equatable.dart';

class Booking extends Equatable {
  final DateTime date;
  final bool confirmed;
  final int bookingID;
  final String bookingName;

  Booking(
      {required this.date,
      this.confirmed = false,
      required this.bookingID,
      required this.bookingName});

  @override
  List<Object?> get props => [date, confirmed, bookingID, bookingName];
}
