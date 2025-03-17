import 'package:flutter/material.dart';

class EnvValues {
  final String titleApp;

  const EnvValues({
    this.titleApp = "Univ-S",
  });
}

class EnvConfig {
  final MaterialColor color;
  final EnvValues values;
  final String server;
  final String webviewServer;
  final String webApiServer;

  static EnvConfig? _instance;

  EnvConfig({
    this.color = Colors.blue,
    this.values = const EnvValues(),
    this.server = '',
    this.webApiServer = '',
    this.webviewServer = '',
  }) {
    _instance = this;
  }

  static EnvConfig get instance => _instance ?? EnvConfig();
}
