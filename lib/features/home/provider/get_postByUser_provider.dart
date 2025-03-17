// ignore_for_file: type_literal_in_constant_pattern
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:univs/core/helpers/secure_storage/storage_helper.dart';
import 'package:univs/core/helpers/secure_storage/storage_key_helper.dart';
import 'package:univs/core/resources/repositories/repository.dart';
import 'package:univs/core/utils/enum_state.dart';
import 'package:univs/features/home/model/post_response.dart';

class GetPostByUserProvider extends ChangeNotifier {
  GetPostByUserProvider({required this.repository});

  final Repository repository;

  // state
  RequestState _doGetPostByUser = RequestState.Empty;
  RequestState get doGetPostByUser => _doGetPostByUser;

  String _errMsg = "";
  String get errMsg => _errMsg;

  bool get isLoading => _doGetPostByUser == RequestState.Loading;
  bool get isError => _doGetPostByUser == RequestState.Error;
  bool get isLoaded => _doGetPostByUser == RequestState.Loaded;

  PostResponse? _postResponse;
  PostResponse? get postResponse => _postResponse;

  Future<void> doGetPostByUsers({
    BuildContext? context,
  }) async {
    _doGetPostByUser = RequestState.Loading;
    notifyListeners();

    final String? token = await storage.read(StorageKey.authToken);

    final result = await repository.doGetPostsByUser(token: token);

    result.fold(
      (failure) {
        _doGetPostByUser = RequestState.Error;
        _errMsg = failure.message.toString();
        Fluttertoast.showToast(msg: failure.message.toString());
        notifyListeners();
      },
      (success) async {
        log('success: ${success.response}');

        _postResponse = success.response;

        _doGetPostByUser = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
