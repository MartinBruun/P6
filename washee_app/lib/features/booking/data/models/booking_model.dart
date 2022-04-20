import 'package:washee/features/booking/data/models/booking_entity.dart';
import 'package:timezone/timezone.dart' as tz;

// ignore: must_be_immutable
class BookingModel extends Booking {
  final int? bookingID;
  DateTime? startTime;
  DateTime? endTime;
  DateTime? created;
  DateTime? lastUpdated;
  final String machineResource;
  final String serviceResource;
  final String accountResource;
  bool? activated;

  BookingModel(
      {this.bookingID,
      required this.startTime,
      this.endTime,
      this.created,
      this.lastUpdated,
      this.activated,
      required this.machineResource,
      required this.serviceResource,
      required this.accountResource})
      : super(
            bookingID: bookingID,
            startTime: startTime,
            endTime: endTime,
            created: created,
            lastUpdated: lastUpdated,
            machineResource: machineResource,
            serviceResource: serviceResource,
            accountResource: accountResource);

  @override
  List<Object?> get props => [
        startTime,
        endTime,
        created,
        lastUpdated,
        bookingID,
        accountResource,
        machineResource,
        serviceResource
      ];

  Map<String, dynamic> toJson() => {
        'id': bookingID,
        'start_time': startTime.toString(),
        'end_time': endTime.toString(),
        'created': created.toString(),
        'last_updated': lastUpdated.toString(),
        'activated': activated.toString(),
        'machine': machineResource,
        'service': serviceResource,
        'account': accountResource
      };

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    var danishTime = tz.getLocation('Europe/Copenhagen');
    BookingModel booking = BookingModel(
      startTime:
          tz.TZDateTime.from(DateTime.parse(json['start_time']), danishTime),
      endTime: tz.TZDateTime.from(DateTime.parse(json['end_time']), danishTime),
      lastUpdated:
          tz.TZDateTime.from(DateTime.parse(json['last_updated']), danishTime),
      activated: json["activated"],
      machineResource: json['machine'],
      serviceResource: json['service'],
      created: tz.TZDateTime.from(DateTime.parse(json['created']), danishTime),
      accountResource: json['account'],
      bookingID: int.parse(json['id'].toString()),
    );
    return booking;
  }
}
