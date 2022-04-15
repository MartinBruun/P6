import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Booking extends Equatable {
  final int? bookingID;
  DateTime? startTime;
  DateTime? endTime;
  DateTime? created;
  DateTime? lastUpdated;
  final String machineResource;
  final String serviceResource;
  final String accountResource;

  Booking({
    this.bookingID,
    required this.startTime,
    this.endTime,
    this.created,
    this.lastUpdated,
    required this.machineResource,
    required this.serviceResource,
    required this.accountResource
  });

  @override
  List<Object?> get props => [bookingID, startTime, endTime, created, lastUpdated, machineResource, serviceResource, accountResource];
}
