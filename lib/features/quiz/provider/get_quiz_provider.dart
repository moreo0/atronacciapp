// ignore_for_file: type_literal_in_constant_pattern
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:univs/core/helpers/secure_storage/storage_helper.dart';
import 'package:univs/core/helpers/secure_storage/storage_key_helper.dart';
import 'package:univs/core/resources/repositories/repository.dart';
import 'package:univs/core/utils/enum_state.dart';
import 'package:univs/features/quiz/model/quiz_model.dart';
import 'package:univs/features/quiz/model/quiz_response.dart';

class GetQuizProvider extends ChangeNotifier {
  GetQuizProvider({required this.repository});

  final Repository repository;

  // state
  RequestState _doGetQuiz = RequestState.Empty;
  RequestState get doGetQuiz => _doGetQuiz;

  String _errMsg = "";
  String get errMsg => _errMsg;

  bool get isLoading => _doGetQuiz == RequestState.Loading;
  bool get isError => _doGetQuiz == RequestState.Error;
  bool get isLoaded => _doGetQuiz == RequestState.Loaded;

  List<QuizModel> _allQuiz = [];
  List<QuizModel> get allQuiz => _allQuiz;

  List<QuizModel> _filteredQuiz = [];
  List<QuizModel> get filteredQuiz => _filteredQuiz;

  QuizResponse? _quizResponse;
  QuizResponse? get quizResponse => _quizResponse;

  Future<void> doGetQuizs() async {
    _doGetQuiz = RequestState.Loading;
    notifyListeners();

    final String? token = await storage.read(StorageKey.authToken);

    final result = await repository.doGetExams(token: token);

    result.fold(
      (failure) {
        _doGetQuiz = RequestState.Error;
        _errMsg = failure.message.toString();
        Fluttertoast.showToast(msg: failure.message.toString());
        notifyListeners();
      },
      (success) async {
        log('success: ${success.response}');

        _quizResponse = success.response;

        _allQuiz = success.response!.data;
        _filteredQuiz = success.response!.data;

        _doGetQuiz = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  Future<void> filterQuiz(String query) async {
    _filteredQuiz = _allQuiz
        .where((quiz) => quiz.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
