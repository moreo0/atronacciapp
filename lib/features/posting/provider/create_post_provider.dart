// ignore_for_file: type_literal_in_constant_pattern
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:univs/core/helpers/secure_storage/storage_helper.dart';
import 'package:univs/core/helpers/secure_storage/storage_key_helper.dart';
import 'package:univs/core/resources/repositories/repository.dart';
import 'package:univs/core/utils/enum_state.dart';

class CreatePostProvider extends ChangeNotifier {
  CreatePostProvider({required this.repository});

  final Repository repository;

  // state
  RequestState _doCreatePost = RequestState.Empty;
  RequestState get doCreatePost => _doCreatePost;

  String _errMsg = "";
  String get errMsg => _errMsg;

  bool get isLoading => _doCreatePost == RequestState.Loading;
  bool get isError => _doCreatePost == RequestState.Error;
  bool get isLoaded => _doCreatePost == RequestState.Loaded;

  Future<void> doCreatePosts({
    String? description,
    String? attachment,
  }) async {
    _doCreatePost = RequestState.Loading;
    notifyListeners();

    final String? token = await storage.read(StorageKey.authToken);

    final result = await repository.doCreatePost(
        token: token, description: description, attachment: attachment);

    result.fold(
      (failure) {
        _doCreatePost = RequestState.Error;
        _errMsg = failure.message.toString();
        Fluttertoast.showToast(msg: failure.message.toString());
        notifyListeners();
      },
      (success) async {
        log('success: ${success.response}');

        _doCreatePost = RequestState.Loaded;
        notifyListeners();
        Fluttertoast.showToast(msg: 'Berhasil posting!');
      },
    );
  }
}
