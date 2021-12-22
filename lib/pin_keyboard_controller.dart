import 'package:flutter/material.dart';

class PinKeyboardController {
  VoidCallback? _resetCallback;

  void addResetListener(VoidCallback listener) {
    _resetCallback = listener;
  }

  void reset() {
    if (_resetCallback != null) {
      _resetCallback!();
    }
  }
}
