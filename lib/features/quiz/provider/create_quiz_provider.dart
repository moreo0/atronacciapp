// ignore_for_file: type_literal_in_constant_pattern
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:univs/core/helpers/secure_storage/storage_helper.dart';
import 'package:univs/core/helpers/secure_storage/storage_key_helper.dart';
import 'package:univs/core/resources/repositories/repository.dart';
import 'package:univs/core/utils/enum_state.dart';

class CreateQuizProvider extends ChangeNotifier {
  CreateQuizProvider({required this.repository});

  final Repository repository;

  // state
  RequestState _doCreateQuiz = RequestState.Empty;
  RequestState get doCreateQuiz => _doCreateQuiz;

  String _errMsg = "";
  String get errMsg => _errMsg;

  bool get isLoading => _doCreateQuiz == RequestState.Loading;
  bool get isError => _doCreateQuiz == RequestState.Error;
  bool get isLoaded => _doCreateQuiz == RequestState.Loaded;

  Future<void> doCreateQuizs({
    required BuildContext? context,
    required String title,
    required String imageUrl,
    required String category,
    required List<Map<String, dynamic>> examDetails,
  }) async {
    _doCreateQuiz = RequestState.Loading;
    notifyListeners();

    final String? token = await storage.read(StorageKey.authToken);

    final result = await repository.doCreateQuiz(
        token: token!,
        title: title,
        imageUrl: imageUrl,
        category: category,
        examDetails: examDetails);

    result.fold(
      (failure) {
        _doCreateQuiz = RequestState.Error;
        _errMsg = failure.message.toString();
        Fluttertoast.showToast(msg: failure.message.toString());
        notifyListeners();
      },
      (success) async {
        log('success: ${success.response}');

        _doCreateQuiz = RequestState.Loaded;
        notifyListeners();

        Fluttertoast.showToast(msg: 'Berhasil menambahkan quiz');
        Navigator.pop(context!);
      },
    );
  }
}
