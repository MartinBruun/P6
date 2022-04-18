import 'package:flutter/cupertino.dart';

class BookingProvider extends ChangeNotifier {
  bool _isRefreshing = false;

  bool get isRefreshing => _isRefreshing;

  refreshBookings() {
    _isRefreshing = true;
    notifyListeners();
  }

  stopRefreshBookings() {
    _isRefreshing = false;
  }
}
