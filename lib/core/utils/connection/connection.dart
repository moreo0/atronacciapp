import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkConnectivity {
  Future<bool> get isConnected async {
    final connection = await Connectivity().checkConnectivity();
    return (connection == ConnectivityResult.mobile ||
        connection == ConnectivityResult.wifi);
  }
}
