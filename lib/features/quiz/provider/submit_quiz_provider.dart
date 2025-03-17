// ignore_for_file: type_literal_in_constant_pattern
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:univs/core/helpers/secure_storage/storage_helper.dart';
import 'package:univs/core/helpers/secure_storage/storage_key_helper.dart';
import 'package:univs/core/resources/repositories/repository.dart';
import 'package:univs/core/routes/router_import.gr.dart';
import 'package:univs/core/utils/enum_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:univs/features/quiz/model/quiz_submission_response.dart';

class SubmitQuizProvider extends ChangeNotifier {
  SubmitQuizProvider({required this.repository});

  final Repository repository;

  // state
  RequestState _doSubmitQuiz = RequestState.Empty;
  RequestState get doSubmitQuiz => _doSubmitQuiz;

  String _errMsg = "";
  String get errMsg => _errMsg;

  bool get isLoading => _doSubmitQuiz == RequestState.Loading;
  bool get isError => _doSubmitQuiz == RequestState.Error;
  bool get isLoaded => _doSubmitQuiz == RequestState.Loaded;

  QuizSubmissionResponse? _submissionResponse;
  QuizSubmissionResponse? get submissionResponse => _submissionResponse;

  Future<void> doSubmitQuizs({
    required BuildContext? context,
    required int examId,
    required List<Map<String, dynamic>> examResponses,
    required int totalSoal,
  }) async {
    _doSubmitQuiz = RequestState.Loading;
    notifyListeners();

    final String? token = await storage.read(StorageKey.authToken);

    final result = await repository.doSubmitQuiz(
        token: token!, examId: examId, examResponses: examResponses);

    result.fold(
      (failure) {
        _doSubmitQuiz = RequestState.Error;
        _errMsg = failure.message.toString();
        Fluttertoast.showToast(msg: failure.message.toString());
        notifyListeners();
      },
      (success) async {
        log('success: ${success.response}');
        _submissionResponse = QuizSubmissionResponse.fromJson(success.response);

        _doSubmitQuiz = RequestState.Loaded;
        notifyListeners();

        Fluttertoast.showToast(msg: 'Berhasil menyelesaikan quiz');
        context?.router.replace(QuizNilaiRoute(
            submissionResponse: _submissionResponse!, totalSoal: totalSoal));
      },
    );
  }
}
