// ignore_for_file: type_literal_in_constant_pattern

import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:univs/core/helpers/secure_storage/storage_helper.dart';
import 'package:univs/core/helpers/secure_storage/storage_key_helper.dart';
import 'package:univs/core/resources/repositories/repository.dart';
import 'package:univs/core/routes/router_import.gr.dart';
import 'package:univs/core/utils/enum_state.dart';

class RegisterProvider extends ChangeNotifier {
  RegisterProvider({required this.repository});

  final Repository repository;

  // state
  RequestState _doRegisterState = RequestState.Empty;
  RequestState get doRegisterState => _doRegisterState;

  String _errMsg = "";
  String get errMsg => _errMsg;

  bool get isLoading => _doRegisterState == RequestState.Loading;
  bool get isError => _doRegisterState == RequestState.Loading;
  bool get isLoaded => _doRegisterState == RequestState.Loaded;

  Future<String?> doRegister({
    BuildContext? context,
    String? name,
    String? dateOfBirth,
    String? username,
    String? email,
    String? password,
    String? passwordConfirmation,
  }) async {
    _doRegisterState = RequestState.Loading;
    notifyListeners();

    String? token;

    final result = await repository.doRegister(
      name: name,
      dateOfBirth: dateOfBirth,
      username: username,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );

    result.fold(
      (failure) {
        _doRegisterState = RequestState.Error;
        _errMsg = failure.message.toString();
        Fluttertoast.showToast(msg: failure.message.toString());
        notifyListeners();
      },
      (success) async {
        log('success: ${success.response}');

        _doRegisterState = RequestState.Loaded;
        notifyListeners();
        Fluttertoast.showToast(msg: 'Berhasil buat akun');
        context?.router.replace(const LoginRoute());
      },
    );
    return token;
  }

  Future<UserInformation> getUser() async {
    final String? name = await storage.read(StorageKey.fullName);
    final String? token = await storage.read(StorageKey.authToken);
    notifyListeners();
    return UserInformation(name, token);
  }
}

class UserInformation {
  final String? name;
  final String? token;

  UserInformation(this.name, this.token);
}
