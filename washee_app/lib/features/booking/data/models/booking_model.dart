import '../../domain/entities/booking.dart';

class BookingModel extends Booking {
  final int id;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime created;
  final DateTime lastUpdated;
  final String machine;
  final String service;
  final String account;

  BookingModel(
      {required this.startTime,
      required this.endTime,
      required this.lastUpdated,
      required this.id,
      required this.account,
      required this.created,
      required this.machine,
      required this.service})
      : super(
            startTime: startTime,
            endTime: endTime,
            lastUpdated: lastUpdated,
            id: id,
            machine: machine,
            service: service,
            account: account,
            created: created);

  @override
  List<Object?> get props =>
      [startTime, endTime, lastUpdated, id, account, created, machine, service];

  factory BookingModel.fromJSON(Map<String, dynamic> json) {
    return BookingModel(
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      lastUpdated: DateTime.parse(json['last_updated']),
      machine: (json['machine']).split("/").last,
      service: (json['service']).split("/").last,
      created: DateTime.parse(json['created']),
      account: (json['account']).split("/").last,
      id: int.parse(json['id']),
    );
  }
}
