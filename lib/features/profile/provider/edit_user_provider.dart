// ignore_for_file: type_literal_in_constant_pattern
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:univs/core/helpers/secure_storage/storage_helper.dart';
import 'package:univs/core/helpers/secure_storage/storage_key_helper.dart';
import 'package:univs/core/resources/repositories/repository.dart';
import 'package:univs/core/utils/enum_state.dart';

class EditUserProvider extends ChangeNotifier {
  EditUserProvider({required this.repository});

  final Repository repository;

  // state
  RequestState _doEditUser = RequestState.Empty;
  RequestState get doEditUser => _doEditUser;

  String _errMsg = "";
  String get errMsg => _errMsg;

  bool get isLoading => _doEditUser == RequestState.Loading;
  bool get isError => _doEditUser == RequestState.Error;
  bool get isLoaded => _doEditUser == RequestState.Loaded;

  Future<void> doEditUsers({
    required BuildContext? context,
    required String name,
    required String image,
    required String gender,
    required String university,
    required String dateOfBirth,
  }) async {
    _doEditUser = RequestState.Loading;
    notifyListeners();

    final String? token = await storage.read(StorageKey.authToken);

    final result = await repository.doUpdateProfile(
      token: token,
      name: name,
      image: image,
      gender: gender,
      university: university,
      dateOfBirth: dateOfBirth,
    );

    result.fold(
      (failure) {
        _doEditUser = RequestState.Error;
        _errMsg = failure.message.toString();
        Fluttertoast.showToast(msg: failure.message.toString());
        notifyListeners();
      },
      (success) async {
        log('success: ${success.response}');
        await saveToLocalStorage(success.response);

        _doEditUser = RequestState.Loaded;
        notifyListeners();
        Fluttertoast.showToast(msg: 'Berhasil Update Profile!');
        // ignore: use_build_context_synchronously
        Navigator.pop(context!);
      },
    );
  }

  Future<void> saveToLocalStorage(Map<String, dynamic> response) async {
    // Extract data from response
    final Map<String, dynamic> data = response['data'];
    final String userId = data['id'].toString();
    final String? email = data['email'];
    final String? fullName = data['name'];
    final String? imageUser = data['image'];
    final String? university = data['university'];

    // Save data to local storage
    await storage.write(StorageKey.userId, userId);
    await storage.write(StorageKey.emailUser, email ?? '');
    await storage.write(StorageKey.fullName, fullName ?? '');
    await storage.write(
        StorageKey.imageUser,
        imageUser ??
            'https://cdn.antaranews.com/cache/1200x800/2023/06/18/20230618_080945.jpg');
    await storage.write(StorageKey.university, university ?? '');
  }
}
