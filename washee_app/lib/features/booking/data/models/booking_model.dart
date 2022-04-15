import 'package:washee/features/booking/data/models/booking_entity.dart';

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

  BookingModel({
    this.bookingID,
    required this.startTime,
    this.endTime,
    this.created,
    this.lastUpdated,
    required this.machineResource,
    required this.serviceResource,
    required this.accountResource
    }): super(
            bookingID: bookingID,
            startTime: startTime,
            endTime: endTime,
            created: created,
            lastUpdated: lastUpdated,
            machineResource: machineResource,
            serviceResource: serviceResource,
            accountResource: accountResource);

  @override
  List<Object?> get props =>
      [startTime, endTime, created, lastUpdated, bookingID, accountResource, machineResource, serviceResource];

  Map<String, dynamic> toJson() => {
        'id': bookingID,
        'start_time': startTime.toString(),
        'end_time': endTime.toString(),
        'created': created.toString(),
        'last_updated': lastUpdated.toString(),
        'machine': machineResource,
        'service': serviceResource,
        'account': accountResource
      };

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    print("CONTENT OF JSON");
    print(json);
    print("PARSE INT");
    print(int.parse(json["id"]));
    print("DONE PARSING");

    return BookingModel(
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      lastUpdated: DateTime.parse(json['last_updated']),
      machineResource: json['machine'],
      serviceResource: json['service'],
      created: DateTime.parse(json['created']),
      accountResource: json['account'],
      bookingID: int.parse(json['id']),
    );
  }
}
