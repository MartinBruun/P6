import 'package:flutter/material.dart';
import 'package:washee/core/washee_box/machine_model.dart';

class GlobalProvider extends ChangeNotifier {
  List<MachineModel> _machines = [
    // MachineModel(
    //     machineID: "123",
    //     name: "VaskemaskineUNO",
    //     machineType: "laundry",
    //     startTime: DateTime(2022, 03, 18, 09, 0, 0),
    //     endTime: DateTime(2022, 03, 18, 09, 0, 0).add(Duration(hours: 1))),
    // MachineModel(
    //     machineID: "1234",
    //     name: "VaskemaskineDOS",
    //     machineType: "laundry",
    //     startTime: DateTime(2022, 03, 18, 12, 0, 0),
    //     endTime: DateTime(2022, 03, 18, 12, 0, 0).add(Duration(hours: 2))),
    // MachineModel(
    //     machineID: "1235",
    //     name: "VaskemaskineTRES",
    //     machineType: "laundry",
    //     startTime: DateTime(2022, 03, 18, 12, 0, 0),
    //     endTime: DateTime(2022, 03, 18, 12, 0, 0)
    //         .add(Duration(hours: 2, minutes: 15))),
    // MachineModel(
    //     machineID: "1236",
    //     name: "VaskemaskineQUADRO",
    //     machineType: "laundry",
    //     startTime: DateTime(2022, 03, 18, 12, 0, 0),
    //     endTime: DateTime(2022, 03, 18, 12, 0, 0)
    //         .add(Duration(hours: 3, minutes: 15))),
  ];
  bool _isConnectingToBox = false;
  bool _isRefreshing = false;
  bool _fetchedMachines = false;

  List<MachineModel> get machines => _machines;
  bool get isConnectingToBox => _isConnectingToBox;
  bool get isRefreshing => _isRefreshing;
  bool get fetchedMachines => _fetchedMachines;

  set isConnectingToBox(bool value) {
    _isConnectingToBox = value;
    notifyListeners();
  }

  set isRefreshing(bool value) {
    _isRefreshing = value;
    notifyListeners();
  }

  set fetchedMachines(bool value) {
    _fetchedMachines = value;
    notifyListeners();
  }

  updateMachines(List<MachineModel> machines) {
    _machines = machines;
    notifyListeners();
  }

  constructMachineList(Map<String, dynamic> machinesAsJson) {
    for (var machine in machinesAsJson['machines']) {
      _machines.add(MachineModel.fromJson(machine));
    }
    notifyListeners();
  }

  List<BookingModel> _bookings = [];

  bool _isConnectingToWeb = false;
  bool _isRefreshingWeb = false;
  bool _fetchedRegisteredBookings = false;

  List<BookingModel> get registeredBookings => _bookings;
  bool get isConnectingToWeb => _isConnectingToWeb;
  bool get isRefreshingWeb => _isRefreshingWeb;
  bool get fetchedRegisteredBookings => _fetchedRegisteredBookings;

  set isConnectingToWeb(bool value) {
    _isConnectingToWeb = value;
    notifyListeners();
  }

  set isRefreshingWeb(bool value) {
    _isRefreshingWeb = value;
    notifyListeners();
  }

  set fetchedRegisteredBookings(bool value) {
    _fetchedRegisteredBookings = value;
    notifyListeners();
  }

  updateRegisteredBookings(List<BookingModel> bookings) {
    _bookings = bookings;
    notifyListeners();
  }

  constructBookingsList(Map<String, dynamic> bookingsAsJson) {
    for (var booking in bookingsAsJson['bookings']) {
      _bookings.add(BookingModel.fromJson(booking));
    }
    notifyListeners();
  }
}
