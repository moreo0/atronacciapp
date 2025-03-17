// ignore_for_file: type_literal_in_constant_pattern
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:univs/core/helpers/secure_storage/storage_helper.dart';
import 'package:univs/core/helpers/secure_storage/storage_key_helper.dart';
import 'package:univs/core/resources/repositories/repository.dart';
import 'package:univs/core/utils/enum_state.dart';
import 'package:univs/features/home/model/post_model.dart';
import 'package:univs/features/home/model/post_response.dart';

class GetPostProvider extends ChangeNotifier {
  GetPostProvider({required this.repository});

  final Repository repository;

  // state
  RequestState _doGetPost = RequestState.Empty;
  RequestState get doGetPost => _doGetPost;

  String _errMsg = "";
  String get errMsg => _errMsg;

  bool get isLoading => _doGetPost == RequestState.Loading;
  bool get isError => _doGetPost == RequestState.Error;
  bool get isLoaded => _doGetPost == RequestState.Loaded;

  List<PostModel> _allPosts = [];
  List<PostModel> get allPosts => _allPosts;

  List<PostModel> _filteredPosts = [];
  List<PostModel> get filteredPosts => _filteredPosts;

  PostResponse? _postResponse;
  PostResponse? get postResponse => _postResponse;

  Future<void> doGetPosts({
    BuildContext? context,
  }) async {
    _doGetPost = RequestState.Loading;
    notifyListeners();

    final String? token = await storage.read(StorageKey.authToken);

    final result = await repository.doGetPosts(token: token);

    result.fold(
      (failure) {
        _doGetPost = RequestState.Error;
        _errMsg = failure.message.toString();
        Fluttertoast.showToast(msg: failure.message.toString());
        notifyListeners();
      },
      (success) async {
        log('success: ${success.response}');

        _postResponse = success.response;
        _allPosts = success.response!.data;
        _filteredPosts = success.response!.data;

        _doGetPost = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  Future<void> filterPosts(String query) async {
    _filteredPosts = _allPosts
        .where((posts) =>
            posts.description.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
