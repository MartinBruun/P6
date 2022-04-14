import 'package:equatable/equatable.dart';

class Booking extends Equatable {
  final int id;
  final DateTime start_time;
  final DateTime end_time;
  final DateTime created;
  final DateTime last_updated;
  final String machine;
  final String service;
  final String account;

  Booking(
      {required this.start_time,
      required this.end_time,
      required this.last_updated,
      required this.id,
      required this.account,
      required this.created,
      required this.machine,
      required this.service});

  @override
  List<Object?> get props => [
        start_time,
        end_time,
        last_updated,
        id,
        machine,
        service,
        created,
        account
      ];
}
