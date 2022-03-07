import 'package:flutter/material.dart';
import 'package:washee/core/washee_box/machine_entity.dart';

class UnlockProvider extends ChangeNotifier {
  bool _isUnlocking = false;

  bool get isUnlocking => _isUnlocking;

  set isUnlocking(bool value) {
    _isUnlocking = value;
    notifyListeners();
  }
}
