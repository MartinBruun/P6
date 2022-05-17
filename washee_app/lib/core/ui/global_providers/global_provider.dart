import 'package:flutter/material.dart';
import 'package:washee/core/washee_box/machine_model.dart';
import 'package:washee/features/booking/data/models/booking_model.dart';

class GlobalProvider extends ChangeNotifier {
  List<MachineModel> _machines = [];
  List<BookingModel> _bookings = [];
  bool _isConnectingToBox = true;
  bool _isRefreshing = false;
  bool _fetchedMachines = false;
  bool _fetchedBookings = false;

  List<MachineModel> get machines => _machines;
  List<BookingModel> get bookings => _bookings;
  bool get isConnectingToBox => _isConnectingToBox;
  bool get isRefreshing => _isRefreshing;
  bool get fetchedMachines => _fetchedMachines;
  bool get fetchedBookings => _fetchedBookings;

  startConnectingToBox() {
    _isConnectingToBox = true;
    notifyListeners();
  }

  stopConnectingToBox() {
    _isConnectingToBox = false;
  }

  startRefresh() {
    _isRefreshing = true;
    notifyListeners();
  }

  stopRefresh() {
    _isRefreshing = false;
  }

  set fetchedMachines(bool value) {
    _fetchedMachines = value;
    notifyListeners();
  }

  set fetchedBookings(bool value) {
    _fetchedBookings = value;
    notifyListeners();
  }

  updateMachines(List<MachineModel> machines) {
    _machines = machines;
  }

  updateBookings(List<BookingModel> bookings) {
    _bookings = bookings;
    notifyListeners();
  }

  constructMachineList(Map<String, dynamic> machinesAsJson) {
    for (var machine in machinesAsJson['machines']) {
      _machines.add(MachineModel.fromJson(machine));
    }
    notifyListeners();
  }

  updateMachine(MachineModel newMachine){
    machines[machines.indexWhere((element) => element.machineID == newMachine.machineID)] = newMachine;
    notifyListeners();
  }

  bool _isConnectingToWeb = false;
  bool _isRefreshingWeb = false;
  bool _fetchedRegisteredBookings = false;

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

  List<Map<String, dynamic>> getMockBookings() {
    return [
      {
        "start_time": "2022-04-14T12:00:00Z",
        "end_time": "2022-04-14T15:00:00Z",
        "created": "2022-04-14T13:07:08.711Z",
        "last_updated": "2022-04-14T13:07:08.711Z",
        "machine": "http://localhost:8000/api/1/machines/1/",
        "service": "http://localhost:8000/api/1/services/1/",
        "account": "http://localhost:8000/api/1/accounts/1/",
        "id": "1"
      },
      {
        "start_time": "2022-04-14T15:00:00Z",
        "end_time": "2022-04-14T17:00:00Z",
        "created": "2022-04-14T13:07:08.711Z",
        "last_updated": "2022-04-14T13:07:08.711Z",
        "machine": "http://localhost:8000/api/1/machines/2/",
        "service": "http://localhost:8000/api/1/services/2/",
        "account": "http://localhost:8000/api/1/accounts/2/",
        "id": "2"
      },
      {
        "start_time": "2022-04-14T15:00:00Z",
        "end_time": "2022-04-14T17:00:00Z",
        "created": "2022-04-14T13:07:08.711Z",
        "last_updated": "2022-04-14T13:07:08.711Z",
        "machine": "http://localhost:8000/api/1/machines/2/",
        "service": "http://localhost:8000/api/1/services/2/",
        "account": "http://localhost:8000/api/1/accounts/2/",
        "id": "2"
      },
      {
        "start_time": "2022-04-14T17:00:00Z",
        "end_time": "2022-04-14T19:30:00Z",
        "created": "2022-04-14T13:07:08.711Z",
        "last_updated": "2022-04-14T13:07:08.711Z",
        "machine": "http://localhost:8000/api/1/machines/2/",
        "service": "http://localhost:8000/api/1/services/2/",
        "account": "http://localhost:8000/api/1/accounts/2/",
        "id": "2"
      },
      {
        "start_time": "2022-04-14T20:00:00Z",
        "end_time": "2022-04-14T22:30:00Z",
        "created": "2022-04-14T13:07:08.711Z",
        "last_updated": "2022-04-14T13:07:08.711Z",
        "machine": "http://localhost:8000/api/1/machines/2/",
        "service": "http://localhost:8000/api/1/services/2/",
        "account": "http://localhost:8000/api/1/accounts/2/",
        "id": "2"
      },
      {
        "start_time": "2022-04-14T04:00:00Z",
        "end_time": "2022-04-14T06:30:00Z",
        "created": "2022-04-14T13:07:08.711Z",
        "last_updated": "2022-04-14T13:07:08.711Z",
        "machine": "http://localhost:8000/api/1/machines/2/",
        "service": "http://localhost:8000/api/1/services/2/",
        "account": "http://localhost:8000/api/1/accounts/2/",
        "id": "2"
      },
      {
        "start_time": "2022-04-18T12:00:00Z",
        "end_time": "2022-04-18T15:00:00Z",
        "created": "2022-04-12T13:07:08.711Z",
        "last_updated": "2022-04-12T13:07:08.711Z",
        "machine": "http://localhost:8000/api/1/machines/1/",
        "service": "http://localhost:8000/api/1/services/1/",
        "account": "http://localhost:8000/api/1/accounts/3/",
        "id": "3"
      },
      {
        "start_time": "2022-05-01T12:00:00Z",
        "end_time": "2022-05-01T15:00:00Z",
        "created": "2022-05-01T13:07:08.711Z",
        "last_updated": "2022-05-01T13:07:08.711Z",
        "machine": "http://localhost:8000/api/1/machines/2/",
        "service": "http://localhost:8000/api/1/services/2/",
        "account": "http://localhost:8000/api/1/accounts/4/",
        "id": "4"
      },
      {
        "start_time": "2022-05-10T12:00:00Z",
        "end_time": "2022-05-10T15:00:00Z",
        "created": "2022-05-02T13:07:08.711Z",
        "last_updated": "2022-05-02T13:07:08.711Z",
        "machine": "http://localhost:8000/api/1/machines/2/",
        "service": "http://localhost:8000/api/1/services/2/",
        "account": "http://localhost:8000/api/1/accounts/5/",
        "id": "5"
      },
      {
        "start_time": "2022-05-20T12:00:00Z",
        "end_time": "2022-05-20T15:00:00Z",
        "created": "2022-05-01T13:07:08.711Z",
        "last_updated": "2022-05-01T13:07:08.711Z",
        "machine": "http://localhost:8000/api/1/machines/1/",
        "service": "http://localhost:8000/api/1/services/1/",
        "account": "http://localhost:8000/api/1/accounts/6/",
        "id": "6"
      }
    ];
  }
}
