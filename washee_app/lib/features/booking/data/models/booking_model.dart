import '../../domain/entities/booking.dart';

class BookingModel extends Booking {
  final DateTime date;
  final int bookingID;
  final String bookingName;

  BookingModel(
      {required this.date, required this.bookingID, required this.bookingName})
      : super(date: date, bookingID: bookingID, bookingName: bookingName);

  @override
  List<Object?> get props => [date, bookingID, bookingName];

  factory BookingModel.fromJSON(Map<String, dynamic> json) {
    return BookingModel(
        date: json['date'],
        bookingID: int.parse(json['bookingID']),
        bookingName: json['bookingName']);
  }
}
