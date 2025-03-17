// ignore_for_file: type_literal_in_constant_pattern
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:univs/core/resources/repositories/repository.dart';
import 'package:univs/core/routes/router_import.gr.dart';
import 'package:univs/core/utils/enum_state.dart';
import 'package:auto_route/auto_route.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  ForgotPasswordProvider({required this.repository});

  final Repository repository;

  // state
  RequestState _doForgotPassword = RequestState.Empty;
  RequestState get doForgotPassword => _doForgotPassword;

  String _errMsg = "";
  String get errMsg => _errMsg;

  bool get isLoading => _doForgotPassword == RequestState.Loading;
  bool get isError => _doForgotPassword == RequestState.Error;
  bool get isLoaded => _doForgotPassword == RequestState.Loaded;

  Future<void> doForgotPasswords(
      {BuildContext? context,
      required String emailUser,
      required int otp,
      required String password,
      required String passwordConfirmation}) async {
    _doForgotPassword = RequestState.Loading;
    notifyListeners();

    final result = await repository.doForgotPassword(
        email: emailUser,
        otp: otp,
        password: password,
        passwordConfirmation: passwordConfirmation);

    result.fold(
      (failure) {
        _doForgotPassword = RequestState.Error;
        _errMsg = failure.message.toString();
        Fluttertoast.showToast(msg: failure.message.toString());
        notifyListeners();
      },
      (success) async {
        log('success: ${success.response}');
        Fluttertoast.showToast(msg: 'Berhasil ubah password');
        context?.router.replace(const LoginRoute());

        _doForgotPassword = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
