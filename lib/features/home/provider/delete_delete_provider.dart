// ignore_for_file: type_literal_in_constant_pattern
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:univs/core/helpers/secure_storage/storage_helper.dart';
import 'package:univs/core/helpers/secure_storage/storage_key_helper.dart';
import 'package:univs/core/resources/repositories/repository.dart';
import 'package:univs/core/utils/enum_state.dart';

class DeletePostsProvider extends ChangeNotifier {
  DeletePostsProvider({required this.repository});

  final Repository repository;

  // state
  RequestState _doDeletePosts = RequestState.Empty;
  RequestState get doDeletePosts => _doDeletePosts;

  String _errMsg = "";
  String get errMsg => _errMsg;

  bool get isLoading => _doDeletePosts == RequestState.Loading;
  bool get isError => _doDeletePosts == RequestState.Error;
  bool get isLoaded => _doDeletePosts == RequestState.Loaded;

  Future<void> doDeletePostss({
    required String id,
  }) async {
    _doDeletePosts = RequestState.Loading;
    notifyListeners();

    final String? token = await storage.read(StorageKey.authToken);

    final result = await repository.doDeletePosts(id: id, token: token);

    result.fold(
      (failure) {
        _doDeletePosts = RequestState.Error;
        _errMsg = failure.message.toString();
        Fluttertoast.showToast(msg: failure.message.toString());
        notifyListeners();
      },
      (success) async {
        log('success: ${success.response}');

        _doDeletePosts = RequestState.Loaded;
        notifyListeners();
        Fluttertoast.showToast(msg: 'Berhasil hapus postingan!');
      },
    );
  }
}
