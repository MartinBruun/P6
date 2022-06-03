import 'package:equatable/equatable.dart';
import 'package:washee/features/account/domain/entities/account_entity.dart';
import 'package:washee/features/location/domain/entities/machine_entity.dart';
import 'package:washee/features/location/domain/entities/service_entity.dart';

// ignore: must_be_immutable
class BookingEntity extends Equatable {
  final int id;
  DateTime? startTime;
  DateTime? endTime;
  DateTime? created;
  DateTime? lastUpdated;
  final MachineEntity machine;
  final ServiceEntity service;
  final AccountEntity account;

  BookingEntity({
    required this.id,
    required this.machine,
    required this.service,
    required this.account,
    this.startTime,
    this.endTime,
    this.created,
    this.lastUpdated
  });

  @override
  List<Object?> get props => [id, startTime, endTime, created, lastUpdated, machine, service, account];
}
