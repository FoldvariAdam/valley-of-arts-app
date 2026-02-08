import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NavBarController extends ChangeNotifier {
  bool _isOpen = true;

  bool get isOpen => _isOpen;

  void open() {
    if (!_isOpen) {
      _isOpen = true;
      notifyListeners();
    }
  }

  void close() {
    if (_isOpen) {
      _isOpen = false;
      notifyListeners();
    }
  }

  void toggle() {
    _isOpen = !_isOpen;
    notifyListeners();
  }
}
