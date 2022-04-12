import 'package:washee/features/booking/data/models/booking_entity.dart';

// ignore: must_be_immutable
class BookingModel extends Booking {
  final String bookingID;
  DateTime? startTime;
  DateTime? endTime;
  DateTime? created;
  DateTime? lastUpdated;
  final int machineID;
  final int serviceID;
  final int accountID;

  BookingModel({
    required this.bookingID,
    required this.startTime,
    this.endTime,
    required this.created,
    this.lastUpdated,
    required this.machineID,
    required this.serviceID,
    required this.accountID
  }) : super(
          bookingID: bookingID,
          startTime: startTime,
          endTime: endTime,
          created: created,
          lastUpdated: lastUpdated,
          machineID: machineID,
          serviceID: serviceID,
          accountID: accountID
        );

  @override
  List<Object?> get props => [
        bookingID,
        startTime,
        endTime,
        created,
        lastUpdated,
        machineID,
        serviceID,
        accountID
      ];

  Map<String, dynamic> toJson() => {
        'id': bookingID,
        'start_time': startTime.toString(),
        'end_time': endTime.toString(),
        'created': created.toString(),
        'last_updated': lastUpdated.toString(),
        'machine': machineID,
        'service': serviceID,
        'account': accountID
      };

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      bookingID: json['id'],
      startTime: json['start_time'] != "null"
          ? DateTime.parse(json['start_time'])
          : null,
      endTime: json['end_time'] != "null"
          ? DateTime.parse(json['end_time'])
          : null,
      created: json['created'] != "null"
          ? DateTime.parse(json['created'])
          : null,
      lastUpdated: json['last_updated'] != "null"
          ? DateTime.parse(json['last_updated'])
          : null,
      machineID: json['machine'],
      serviceID: json['service'],
      accountID: json['account']
    );
  }
}
