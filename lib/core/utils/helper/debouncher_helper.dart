import 'dart:async';
import 'package:flutter/material.dart';

class Debouncer {
  static Timer? _timer;

  static void debounce({
    required int milliseconds,
    required VoidCallback action,
  }) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
