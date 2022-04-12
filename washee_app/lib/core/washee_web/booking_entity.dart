import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Booking extends Equatable {
  final DateTime start_time; //  "2022-04-01T12:00:00Z",
  final DateTime end_time; // "2022-04-01T15:00:00Z",
  final DateTime created; // "2022-04-01T13:07:08.711Z",
  final DateTime last_updated; // 2022-04-01T13:07:08.711Z",
  final String machine;
  final String service;
  final String account;

  Booking(
      {required this.start_time,
      required this.end_time,
      required this.created,
      required this.last_updated,
      required this.machine,
      required this.service,
      required this.account
      });

  @override
  List<Object?> get props => [machine, service, account, created, last_updated, start_time, end_time];
}
