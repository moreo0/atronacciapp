// ignore_for_file: type_literal_in_constant_pattern
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:univs/core/helpers/secure_storage/storage_helper.dart';
import 'package:univs/core/helpers/secure_storage/storage_key_helper.dart';
import 'package:univs/core/resources/repositories/repository.dart';
import 'package:univs/core/utils/enum_state.dart';
import 'package:univs/features/profile/model/reminder_response.dart';

class GetReminderByIdProvider extends ChangeNotifier {
  GetReminderByIdProvider({required this.repository});

  final Repository repository;

  // state
  RequestState _doGetReminderById = RequestState.Empty;
  RequestState get doGetReminderById => _doGetReminderById;

  String _errMsg = "";
  String get errMsg => _errMsg;

  bool get isLoading => _doGetReminderById == RequestState.Loading;
  bool get isError => _doGetReminderById == RequestState.Error;
  bool get isLoaded => _doGetReminderById == RequestState.Loaded;

  ReminderResponse? _reminderResponse;
  ReminderResponse? get reminderResponse => _reminderResponse;

  Future<void> doGetReminderByIds({
    required String id,
  }) async {
    _doGetReminderById = RequestState.Loading;
    notifyListeners();

    final String? token = await storage.read(StorageKey.authToken);

    final result = await repository.doGetReminderById(token: token, id: id);

    result.fold(
      (failure) {
        _doGetReminderById = RequestState.Error;
        _errMsg = failure.message.toString();
        Fluttertoast.showToast(msg: failure.message.toString());
        notifyListeners();
      },
      (success) async {
        log('success: ${success.response}');

        _reminderResponse = success.response;

        _doGetReminderById = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
