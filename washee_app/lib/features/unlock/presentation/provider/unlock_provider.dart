import 'package:flutter/material.dart';
import 'package:washee/core/washee_box/machine_model.dart';

class UnlockProvider extends ChangeNotifier {
  MachineModel activeMachine = MachineModel(
      machineID: "1234", name: "Vaskemaskine", machineType: "laundry");
  bool _hasInitiatedWash = false;
  bool _isUnlocking = false;
  bool _isDoneUnlocking = false;

  bool get hasInitiatedWash => _hasInitiatedWash;
  bool get isUnlocking => _isUnlocking;
  bool get isDoneUnlocking => _isDoneUnlocking;

  set hasInitiatedWash(bool value) {
    _hasInitiatedWash = value;
    notifyListeners();
  }

  set isUnlocking(bool value) {
    _isUnlocking = value;
    notifyListeners();
  }

  set isDoneUnlocking(bool value) {
    _isDoneUnlocking = value;
    notifyListeners();
  }
}
