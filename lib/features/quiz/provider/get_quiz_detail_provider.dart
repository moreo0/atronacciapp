// ignore_for_file: type_literal_in_constant_pattern
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:univs/core/helpers/secure_storage/storage_helper.dart';
import 'package:univs/core/helpers/secure_storage/storage_key_helper.dart';
import 'package:univs/core/resources/repositories/repository.dart';
import 'package:univs/core/utils/enum_state.dart';
import 'package:univs/features/quiz/model/quiz_detail_response.dart';

class GetQuizDetailProvider extends ChangeNotifier {
  GetQuizDetailProvider({required this.repository});

  final Repository repository;

  // state
  RequestState _doGetQuizDetail = RequestState.Empty;
  RequestState get doGetQuizDetail => _doGetQuizDetail;

  String _errMsg = "";
  String get errMsg => _errMsg;

  bool get isLoading => _doGetQuizDetail == RequestState.Loading;
  bool get isError => _doGetQuizDetail == RequestState.Error;
  bool get isLoaded => _doGetQuizDetail == RequestState.Loaded;

  QuizDetailResponse? _quizDetailResponse;
  QuizDetailResponse? get quizDetailResponse => _quizDetailResponse;

  Future<void> doGetQuizDetails({required String id}) async {
    _doGetQuizDetail = RequestState.Loading;
    notifyListeners();

    final String? token = await storage.read(StorageKey.authToken);

    final result = await repository.doGetExamsDetail(token: token, id: id);

    result.fold(
      (failure) {
        _doGetQuizDetail = RequestState.Error;
        _errMsg = failure.message.toString();
        Fluttertoast.showToast(msg: failure.message.toString());
        notifyListeners();
      },
      (success) async {
        log('success: ${success.response}');

        _quizDetailResponse = success.response;

        _doGetQuizDetail = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
