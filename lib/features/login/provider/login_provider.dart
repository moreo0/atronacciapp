// ignore_for_file: type_literal_in_constant_pattern
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:univs/core/helpers/secure_storage/storage_helper.dart';
import 'package:univs/core/helpers/secure_storage/storage_key_helper.dart';
import 'package:univs/core/resources/network/http_service.dart';
import 'package:univs/core/resources/repositories/repository.dart';
import 'package:univs/core/routes/router_import.gr.dart';
import 'package:univs/core/utils/enum_state.dart';
import 'package:univs/core/resources/injector/di.dart' as di;

class LoginProvider extends ChangeNotifier {
  LoginProvider({required this.repository});

  final Repository repository;

  // state
  RequestState _doLoginState = RequestState.Empty;
  RequestState get doLoginState => _doLoginState;

  String _errMsg = "";
  String get errMsg => _errMsg;

  bool get isLoading => _doLoginState == RequestState.Loading;
  bool get isError => _doLoginState == RequestState.Error;
  bool get isLoaded => _doLoginState == RequestState.Loaded;

  Future<String?> doLogin({
    BuildContext? context,
    String? email,
    String? password,
  }) async {
    _doLoginState = RequestState.Loading;
    notifyListeners();

    String? token;

    final result = await repository.doLogin(email: email, password: password);

    result.fold(
      (failure) {
        _doLoginState = RequestState.Error;
        _errMsg = failure.message.toString();
        Fluttertoast.showToast(msg: failure.message.toString());
        notifyListeners();
      },
      (success) async {
        log('success: ${success.response}');
        await saveToLocalStorage(success.response);
        await storage.write(StorageKey.encryptPassword, password ?? "");

        token = success.response['data']['token'];

        await storage.write(StorageKey.authToken, token ?? '');
        di.sl<HttpService>().setToken(token: token!);

        _doLoginState = RequestState.Loaded;
        notifyListeners();
        log("TOKEN $token");

        Fluttertoast.showToast(msg: 'Login success');
        context?.router.replace(const MainRoute());
      },
    );
    return token;
  }

  Future<void> saveToLocalStorage(Map<String, dynamic> response) async {
    // Extract data from response
    final Map<String, dynamic> data = response['data'];
    final Map<String, dynamic> user = data['payload'];
    final String userId = user['id'].toString();
    final String? email = user['email'];
    final String? fullName = user['name'];
    const bool logged = true;

    // Save data to local storage
    await storage.write(StorageKey.userId, userId);
    await storage.write(StorageKey.emailUser, email ?? '');
    await storage.write(StorageKey.fullName, fullName ?? '');
    await storage.write(StorageKey.logged, logged.toString());
  }

  Future<UserInformation> getUser() async {
    final String? id = await storage.read(StorageKey.userId);
    final String? name = await storage.read(StorageKey.fullName);
    final String? university = await storage.read(StorageKey.university);
    final String? imageUrl = await storage.read(StorageKey.imageUser);
    final String? token = await storage.read(StorageKey.authToken);
    notifyListeners();
    return UserInformation(id, name, university, imageUrl, token);
  }
}

class UserInformation {
  final String? id;
  final String? name;
  final String? university;
  final String? imageUrl;
  final String? token;

  UserInformation(
      this.id, this.name, this.university, this.imageUrl, this.token);
}
