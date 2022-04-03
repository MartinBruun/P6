import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Booking extends Equatable {
  final String bookingID;
  DateTime? startTime;
  DateTime? endTime;
  DateTime? created;
  DateTime? lastUpdated;
  final int machineID;
  final int serviceID;
  final int accountID;

  Booking({
    required this.bookingID,
    required this.startTime,
    this.endTime,
    required this.created,
    this.lastUpdated,
    required this.machineID,
    required this.serviceID,
    required this.accountID
  });

  @override
  List<Object?> get props => [bookingID, startTime, endTime, created, lastUpdated, machineID, serviceID, accountID];
}
