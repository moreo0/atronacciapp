// ignore_for_file: type_literal_in_constant_pattern
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:univs/core/helpers/secure_storage/storage_helper.dart';
import 'package:univs/core/helpers/secure_storage/storage_key_helper.dart';
import 'package:univs/core/resources/repositories/repository.dart';
import 'package:univs/core/utils/enum_state.dart';

class CreateReminderProvider extends ChangeNotifier {
  CreateReminderProvider({required this.repository});

  final Repository repository;

  // state
  RequestState _doCreateReminder = RequestState.Empty;
  RequestState get doCreateReminder => _doCreateReminder;

  String _errMsg = "";
  String get errMsg => _errMsg;

  bool get isLoading => _doCreateReminder == RequestState.Loading;
  bool get isError => _doCreateReminder == RequestState.Error;
  bool get isLoaded => _doCreateReminder == RequestState.Loaded;

  Future<void> doCreateReminders({
    required BuildContext? context,
    required String? title,
    required String? date,
    required String? time,
  }) async {
    _doCreateReminder = RequestState.Loading;
    notifyListeners();

    final String? token = await storage.read(StorageKey.authToken);

    final result = await repository.doCreateReminder(
      token: token,
      title: title,
      date: date,
      time: time,
    );

    result.fold(
      (failure) {
        _doCreateReminder = RequestState.Error;
        _errMsg = failure.message.toString();
        Fluttertoast.showToast(msg: failure.message.toString());
        notifyListeners();
      },
      (success) async {
        log('success: ${success.response}');

        _doCreateReminder = RequestState.Loaded;
        notifyListeners();
        Fluttertoast.showToast(msg: 'Berhasil buat reminder!');
        Navigator.pop(context!);
      },
    );
  }
}
