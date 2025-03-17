// ignore_for_file: type_literal_in_constant_pattern
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:univs/core/helpers/secure_storage/storage_helper.dart';
import 'package:univs/core/helpers/secure_storage/storage_key_helper.dart';
import 'package:univs/core/resources/repositories/repository.dart';
import 'package:univs/core/utils/enum_state.dart';

class DeleteReminderProvider extends ChangeNotifier {
  DeleteReminderProvider({required this.repository});

  final Repository repository;

  // state
  RequestState _doDeleteReminder = RequestState.Empty;
  RequestState get doDeleteReminder => _doDeleteReminder;

  String _errMsg = "";
  String get errMsg => _errMsg;

  bool get isLoading => _doDeleteReminder == RequestState.Loading;
  bool get isError => _doDeleteReminder == RequestState.Error;
  bool get isLoaded => _doDeleteReminder == RequestState.Loaded;

  Future<void> doDeleteReminders({
    required String id,
  }) async {
    _doDeleteReminder = RequestState.Loading;
    notifyListeners();

    final String? token = await storage.read(StorageKey.authToken);

    final result = await repository.doDeleteReminder(id: id, token: token);

    result.fold(
      (failure) {
        _doDeleteReminder = RequestState.Error;
        _errMsg = failure.message.toString();
        Fluttertoast.showToast(msg: failure.message.toString());
        notifyListeners();
      },
      (success) async {
        log('success: ${success.response}');

        _doDeleteReminder = RequestState.Loaded;
        notifyListeners();
        Fluttertoast.showToast(msg: 'Berhasil hapus reminder!');
      },
    );
  }
}
