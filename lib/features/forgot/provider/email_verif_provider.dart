// ignore_for_file: type_literal_in_constant_pattern
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:univs/core/resources/repositories/repository.dart';
import 'package:univs/core/routes/router_import.gr.dart';
import 'package:univs/core/utils/enum_state.dart';
import 'package:auto_route/auto_route.dart';

class VerifEmailProvider extends ChangeNotifier {
  VerifEmailProvider({required this.repository});

  final Repository repository;

  // state
  RequestState _doVerifEmail = RequestState.Empty;
  RequestState get doVerifEmail => _doVerifEmail;

  String _errMsg = "";
  String get errMsg => _errMsg;

  bool get isLoading => _doVerifEmail == RequestState.Loading;
  bool get isError => _doVerifEmail == RequestState.Error;
  bool get isLoaded => _doVerifEmail == RequestState.Loaded;

  Future<void> doVerifEmails(
      {BuildContext? context, required String emailUser}) async {
    _doVerifEmail = RequestState.Loading;
    notifyListeners();

    final result = await repository.doVerifEmail(email: emailUser);

    result.fold(
      (failure) {
        _doVerifEmail = RequestState.Error;
        _errMsg = failure.message.toString();
        Fluttertoast.showToast(msg: failure.message.toString());
        notifyListeners();
      },
      (success) async {
        log('success: ${success.response}');
        Fluttertoast.showToast(msg: 'Kode OTP telah dikirim ke email');
        context?.router.replace(ChangePasswordRoute(email: emailUser));

        _doVerifEmail = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
