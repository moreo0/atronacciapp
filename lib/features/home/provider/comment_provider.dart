// ignore_for_file: type_literal_in_constant_pattern
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:univs/core/helpers/secure_storage/storage_helper.dart';
import 'package:univs/core/helpers/secure_storage/storage_key_helper.dart';
import 'package:univs/core/resources/repositories/repository.dart';
import 'package:univs/core/utils/enum_state.dart';

class CommentProvider extends ChangeNotifier {
  CommentProvider({required this.repository});

  final Repository repository;

  // state
  RequestState _doComment = RequestState.Empty;
  RequestState get doComment => _doComment;

  String _errMsg = "";
  String get errMsg => _errMsg;

  bool get isLoading => _doComment == RequestState.Loading;
  bool get isError => _doComment == RequestState.Error;
  bool get isLoaded => _doComment == RequestState.Loaded;

  Future<void> doComments({
    BuildContext? context,
    required int postId,
    required String description,
  }) async {
    _doComment = RequestState.Loading;
    notifyListeners();

    final String? token = await storage.read(StorageKey.authToken);

    final result = await repository.doComment(
        postId: postId, description: description, token: token);

    result.fold(
      (failure) {
        _doComment = RequestState.Error;
        _errMsg = failure.message.toString();
        Fluttertoast.showToast(msg: failure.message.toString());
        notifyListeners();
      },
      (success) async {
        log('success: ${success.response}');

        _doComment = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
