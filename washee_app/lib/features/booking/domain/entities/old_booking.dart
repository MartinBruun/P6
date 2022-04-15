import 'package:equatable/equatable.dart';

class Booking extends Equatable {
  final int id;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime created;
  final DateTime lastUpdated;
  final String machine;
  final String service;
  final String account;

  Booking(
      {required this.startTime,
      required this.endTime,
      required this.lastUpdated,
      required this.id,
      required this.account,
      required this.created,
      required this.machine,
      required this.service});

  @override
  List<Object?> get props =>
      [startTime, endTime, lastUpdated, id, machine, service, created, account];
}
