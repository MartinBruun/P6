import 'package:washee/core/washee_box/machine_entity.dart';

import '../../features/booking/domain/entities/booking.dart';

// ignore: must_be_immutable
class BookingModel extends Booking {
  final DateTime start_time;//  "2022-04-01T12:00:00Z", 
  final DateTime end_time; // "2022-04-01T15:00:00Z", 
  final DateTime created; // "2022-04-01T13:07:08.711Z", 
  final DateTime last_updated;// 2022-04-01T13:07:08.711Z", 
  final String machine; 
  final String service;  
  final String account;

  
  MachineModel({
    required this.start_time,
      required this.end_time,
      required this.created,
      required this.last_updated,
      required this.machine,
      required this.service,
      required this.account,
  }) : super(
          start_time : start_time,
      end_time : end_time,
      created :created,
      last_updated :last_updated,
      machine :machine,
      service :service,
      account :account ,
        );

  @override
  List<Object?> get props => [
        machineID,
        name,
        machineType,
        startTime,
        endTime,
      ];

  Map<String, dynamic> toJson() => {
        'machineID': machineID,
        'name': name,
        'machineType': machineType,
        'startTime': startTime.toString(),
        'endTime': endTime.toString(),
      };

  factory MachineModel.fromJson(Map<String, dynamic> json) {
    return MachineModel(
      machineID: json['machineID'],
      name: json['name'],
      machineType: json['machineType'],
      startTime: json['startTime'] != "null"
          ? DateTime.parse(json['startTime'])
          : null,
      endTime:
          json['endTime'] != "null" ? DateTime.parse(json['endTime']) : null,
    );
  }

  bool get isAvailable {
    if (startTime == null || endTime == null) {
      return true;
    } else if (DateTime.now().isBefore(endTime!) &&
        DateTime.now().isAfter(startTime!)) {
      return false;
    }
    return true;
  }
}
