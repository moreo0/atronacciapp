// ignore_for_file: type_literal_in_constant_pattern
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:univs/core/helpers/secure_storage/storage_helper.dart';
import 'package:univs/core/helpers/secure_storage/storage_key_helper.dart';
import 'package:univs/core/resources/repositories/repository.dart';
import 'package:univs/core/utils/enum_state.dart';
import 'package:univs/features/profile/model/reminder_model.dart';
import 'package:univs/features/profile/model/reminder_response.dart';

class GetReminderProvider extends ChangeNotifier {
  GetReminderProvider({required this.repository});

  final Repository repository;

  // state
  RequestState _doGetReminder = RequestState.Empty;
  RequestState get doGetReminder => _doGetReminder;

  String _errMsg = "";
  String get errMsg => _errMsg;

  bool get isLoading => _doGetReminder == RequestState.Loading;
  bool get isError => _doGetReminder == RequestState.Error;
  bool get isLoaded => _doGetReminder == RequestState.Loaded;

  List<ReminderModel> _allReminder = [];
  List<ReminderModel> get allReminder => _allReminder;

  List<ReminderModel> _filteredReminder = [];
  List<ReminderModel> get filteredReminder => _filteredReminder;

  ReminderResponse? _reminderResponse;
  ReminderResponse? get reminderResponse => _reminderResponse;

  Future<void> doGetReminders() async {
    _doGetReminder = RequestState.Loading;
    notifyListeners();

    final String? token = await storage.read(StorageKey.authToken);

    final result = await repository.doGetReminder(token: token);

    result.fold(
      (failure) {
        _doGetReminder = RequestState.Error;
        _errMsg = failure.message.toString();
        Fluttertoast.showToast(msg: failure.message.toString());
        notifyListeners();
      },
      (success) async {
        log('success: ${success.response}');

        _reminderResponse = success.response;
        _allReminder = success.response!.data;
        _filteredReminder = success.response!.data;

        _doGetReminder = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  Future<void> filterReminder() async {
    final userId = await storage.read(StorageKey.userId);

    _filteredReminder =
        // ignore: unrelated_type_equality_checks
        _allReminder.where((reminder) => reminder.userId == userId).toList();
    notifyListeners();
  }
}
