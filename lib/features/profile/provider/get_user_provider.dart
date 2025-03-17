// ignore_for_file: type_literal_in_constant_pattern
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:univs/core/helpers/secure_storage/storage_helper.dart';
import 'package:univs/core/helpers/secure_storage/storage_key_helper.dart';
import 'package:univs/core/resources/repositories/repository.dart';
import 'package:univs/core/utils/enum_state.dart';
import 'package:univs/features/login/model/user_response.dart';

class GetUserProvider extends ChangeNotifier {
  GetUserProvider({required this.repository});

  final Repository repository;

  // state
  RequestState _doGetUser = RequestState.Empty;
  RequestState get doGetUser => _doGetUser;

  String _errMsg = "";
  String get errMsg => _errMsg;

  bool get isLoading => _doGetUser == RequestState.Loading;
  bool get isError => _doGetUser == RequestState.Error;
  bool get isLoaded => _doGetUser == RequestState.Loaded;

  UserResponse? _userResponse;
  UserResponse? get userResponse => _userResponse;

  Future<void> doGetUsers() async {
    _doGetUser = RequestState.Loading;
    notifyListeners();

    final String? token = await storage.read(StorageKey.authToken);
    final String? id = await storage.read(StorageKey.userId);

    final result = await repository.doGetUsers(token: token, id: id);

    result.fold(
      (failure) {
        _doGetUser = RequestState.Error;
        _errMsg = failure.message.toString();
        Fluttertoast.showToast(msg: failure.message.toString());
        notifyListeners();
      },
      (success) async {
        log('success: ${success.response}');

        _userResponse = success.response;

        _doGetUser = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
