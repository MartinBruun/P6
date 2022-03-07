import 'package:flutter/material.dart';
import 'package:washee/core/washee_box/machine_entity.dart';

class UnlockProvider extends ChangeNotifier {
  bool _isUnlocking = false;
  bool _isDoneUnlocking = false;

  bool get isUnlocking => _isUnlocking;
  bool get isDoneUnlocking => _isDoneUnlocking;

  set isUnlocking(bool value) {
    _isUnlocking = value;
    notifyListeners();
  }

  set isDoneUnlocking(bool value) {
    _isDoneUnlocking = value;
    notifyListeners();
  }
}
