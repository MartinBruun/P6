import '../../domain/entities/booking.dart';

class BookingModel extends Booking {
  final int id;
  final DateTime start_time;
  final DateTime end_time;
  final DateTime created;
  final DateTime last_updated;
  final String machine;
  final String service;
  final String account;

  BookingModel(
      {required this.start_time,
      required this.end_time,
      required this.last_updated,
      required this.id,
      required this.account,
      required this.created,
      required this.machine,
      required this.service})
      : super(
            start_time: start_time,
            end_time: end_time,
            last_updated: last_updated,
            id: id,
            machine: machine,
            service: service,
            account: account,
            created: created);

  @override
  List<Object?> get props => [
        start_time,
        end_time,
        last_updated,
        id,
        account,
        created,
        machine,
        service
      ];

  factory BookingModel.fromJSON(Map<String, dynamic> json) {
    return BookingModel(
      start_time: DateTime.parse(json['start_time']),
      end_time: DateTime.parse(json['end_time']),
      last_updated: DateTime.parse(json['last_updated']),
      machine: (json['machine']).split("/").last,
      service: (json['service']).split("/").last,
      created: DateTime.parse(json['created']),
      account: (json['account']).split("/").last,
      id: int.parse(json['id']),
    );
  }
}
