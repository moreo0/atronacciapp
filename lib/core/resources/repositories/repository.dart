import 'package:dartz/dartz.dart';
import 'package:univs/core/resources/network/rest_client.dart';
import 'package:univs/core/resources/repositories/interface.dart';
import 'package:univs/core/utils/base_response/base_response.dart';
import 'package:univs/core/utils/base_response/response_helper.dart';
import 'package:univs/core/utils/errors/failure.dart';
import 'package:univs/features/home/model/post_response.dart';
import 'package:univs/features/login/model/user_response.dart';
import 'package:univs/features/profile/model/reminder_response.dart';
import 'package:univs/features/quiz/model/quiz_detail_response.dart';
import 'package:univs/features/quiz/model/quiz_response.dart';

class Repository extends RepositoryInterface {
  final RestClient restClient;

  Repository({required this.restClient});

  @override
  Future<Either<Failure, BaseResponse>> doLogin({
    required String? email,
    required String? password,
  }) async {
    Map<String, String> params = {
      'email': email.toString(),
      'password': password.toString()
    };
    Object response = await ResponseHelper.getResponse(
        () async => await restClient.doLogin(params));

    if (response is Failure) return Left(response);

    return Right(
      BaseResponse(
        response: response,
        errorMessage: null,
        status: true,
      ),
    );
  }

  @override
  Future<Either<Failure, BaseResponse>> doRegister({
    required String? name,
    required String? dateOfBirth,
    required String? username,
    required String? email,
    required String? password,
    required String? passwordConfirmation,
  }) async {
    Map<String, String> params = {
      'name': name.toString(),
      'dateOfBirth': dateOfBirth.toString(),
      'username': username.toString(),
      'email': email.toString(),
      'password': password.toString(),
      'password_confirmation': passwordConfirmation.toString(),
    };
    Object response = await ResponseHelper.getResponse(
        () async => await restClient.doRegister(params));

    if (response is Failure) return Left(response);

    return Right(
      BaseResponse(
        response: response,
        errorMessage: null,
        status: true,
      ),
    );
  }

  @override
  Future<Either<Failure, BaseResponse>> doCreatePost({
    required String? description,
    required String? attachment,
    required String? token,
  }) async {
    Map<String, String> params = {
      'description': description.toString(),
      'attachment': attachment.toString(),
    };
    Object response = await ResponseHelper.getResponse(
        () async => await restClient.doCreatePost(token!, params));

    if (response is Failure) return Left(response);

    return Right(
      BaseResponse(
        response: response,
        errorMessage: null,
        status: true,
      ),
    );
  }

  @override
  Future<Either<Failure, BaseResponse<PostResponse>>> doGetPosts({
    required String? token,
  }) async {
    Object response = await ResponseHelper.getResponse(
        () async => await restClient.doGetPosts(token!));

    if (response is Failure) return Left(response);

    return Right(
      BaseResponse(
        response: PostResponse.fromJson(response as Map<String, dynamic>),
        errorMessage: null,
        status: true,
      ),
    );
  }

  @override
  Future<Either<Failure, BaseResponse<UserResponse>>> doGetUsers({
    required String? token,
    required String? id,
  }) async {
    Object response = await ResponseHelper.getResponse(
        () async => await restClient.doGetUsers(token!, id!));

    if (response is Failure) return Left(response);

    return Right(
      BaseResponse(
        response: UserResponse.fromJson(response as Map<String, dynamic>),
        errorMessage: null,
        status: true,
      ),
    );
  }

  @override
  Future<Either<Failure, BaseResponse>> doUpdateProfile({
    required String? token,
    required String? name,
    required String? image,
    required String? gender,
    required String? university,
    required String? dateOfBirth,
  }) async {
    Map<String, String> params = {
      'name': name.toString(),
      'image': image.toString(),
      'gender': gender.toString(),
      'university': university.toString(),
      'dateOfBirth': dateOfBirth.toString(),
    };
    Object response = await ResponseHelper.getResponse(
        () async => await restClient.doUpdateProfile(token!, params));

    if (response is Failure) return Left(response);

    return Right(
      BaseResponse(
        response: response,
        errorMessage: null,
        status: true,
      ),
    );
  }

  @override
  Future<Either<Failure, BaseResponse<ReminderResponse>>> doGetReminder({
    required String? token,
  }) async {
    Object response = await ResponseHelper.getResponse(
        () async => await restClient.doGetReminder(token!));

    if (response is Failure) return Left(response);

    return Right(
      BaseResponse(
        response: ReminderResponse.fromJson(response as Map<String, dynamic>),
        errorMessage: null,
        status: true,
      ),
    );
  }

  @override
  Future<Either<Failure, BaseResponse>> doCreateReminder({
    required String? token,
    required String? title,
    required String? date,
    required String? time,
  }) async {
    Map<String, String> params = {
      'title': title.toString(),
      'date': date.toString(),
      'time': time.toString(),
    };
    Object response = await ResponseHelper.getResponse(
        () async => await restClient.doCreateReminder(token!, params));

    if (response is Failure) return Left(response);

    return Right(
      BaseResponse(
        response: response,
        errorMessage: null,
        status: true,
      ),
    );
  }

  @override
  Future<Either<Failure, BaseResponse<ReminderResponse>>> doGetReminderById({
    required String? token,
    required String? id,
  }) async {
    Object response = await ResponseHelper.getResponse(
        () async => await restClient.doGetReminderById(token!, id!));

    if (response is Failure) return Left(response);

    return Right(
      BaseResponse(
        response: ReminderResponse.fromJson(response as Map<String, dynamic>),
        errorMessage: null,
        status: true,
      ),
    );
  }

  @override
  Future<Either<Failure, BaseResponse>> doDeleteReminder({
    required String? id,
    required String? token,
  }) async {
    Object response = await ResponseHelper.getResponse(
        () async => await restClient.doDeleteReminder(id!, token!));

    if (response is Failure) return Left(response);

    return Right(
      BaseResponse(
        response: response,
        errorMessage: null,
        status: true,
      ),
    );
  }

  @override
  Future<Either<Failure, BaseResponse>> doComment({
    required int? postId,
    required String? description,
    required String? token,
  }) async {
    Map<String, dynamic> params = {
      'postId': postId,
      'description': description.toString(),
    };
    Object response = await ResponseHelper.getResponse(
        () async => await restClient.doComment(token!, params));

    if (response is Failure) return Left(response);

    return Right(
      BaseResponse(
        response: response,
        errorMessage: null,
        status: true,
      ),
    );
  }

  @override
  Future<Either<Failure, BaseResponse<PostResponse>>> doGetPostsByUser({
    required String? token,
  }) async {
    Object response = await ResponseHelper.getResponse(
        () async => await restClient.doGetPostsByUser(token!));

    if (response is Failure) return Left(response);

    return Right(
      BaseResponse(
        response: PostResponse.fromJson(response as Map<String, dynamic>),
        errorMessage: null,
        status: true,
      ),
    );
  }

  @override
  Future<Either<Failure, BaseResponse>> doDeletePosts({
    required String? id,
    required String? token,
  }) async {
    Object response = await ResponseHelper.getResponse(
        () async => await restClient.doDeletePosts(id!, token!));

    if (response is Failure) return Left(response);

    return Right(
      BaseResponse(
        response: response,
        errorMessage: null,
        status: true,
      ),
    );
  }

  @override
  Future<Either<Failure, BaseResponse<QuizResponse>>> doGetExams({
    required String? token,
  }) async {
    Object response = await ResponseHelper.getResponse(
        () async => await restClient.doGetExams(token!));

    if (response is Failure) return Left(response);

    return Right(
      BaseResponse(
        response: QuizResponse.fromJson(response as Map<String, dynamic>),
        errorMessage: null,
        status: true,
      ),
    );
  }

  @override
  Future<Either<Failure, BaseResponse<QuizDetailResponse>>> doGetExamsDetail({
    required String? token,
    required String? id,
  }) async {
    Object response = await ResponseHelper.getResponse(
        () async => await restClient.doGetExamsDetail(token!, id!));

    if (response is Failure) return Left(response);

    return Right(
      BaseResponse(
        response: QuizDetailResponse.fromJson(response as Map<String, dynamic>),
        errorMessage: null,
        status: true,
      ),
    );
  }

  @override
  Future<Either<Failure, BaseResponse>> doVerifEmail({
    required String? email,
  }) async {
    Map<String, dynamic> params = {
      'email': email,
    };
    Object response = await ResponseHelper.getResponse(
        () async => await restClient.doVerifEmail(params));

    if (response is Failure) return Left(response);

    return Right(
      BaseResponse(
        response: response,
        errorMessage: null,
        status: true,
      ),
    );
  }

  @override
  Future<Either<Failure, BaseResponse>> doForgotPassword({
    required String email,
    required int otp,
    required String password,
    required String passwordConfirmation,
  }) async {
    Map<String, dynamic> params = {
      'email': email,
      'otp': otp,
      'password': password,
      'password_confirmation': passwordConfirmation,
    };
    Object response = await ResponseHelper.getResponse(
        () async => await restClient.doForgotPassowrd(params));

    if (response is Failure) return Left(response);

    return Right(
      BaseResponse(
        response: response,
        errorMessage: null,
        status: true,
      ),
    );
  }

  @override
  Future<Either<Failure, BaseResponse>> doSubmitQuiz({
    required String token,
    required int examId,
    required List<Map<String, dynamic>>? examResponses,
  }) async {
    Map<String, dynamic> params = {
      'examId': examId,
      'examResponses': examResponses,
    };
    Object response = await ResponseHelper.getResponse(
        () async => await restClient.doSubmitQuiz(token, params));

    if (response is Failure) return Left(response);

    return Right(
      BaseResponse(
        response: response,
        errorMessage: null,
        status: true,
      ),
    );
  }

  @override
  Future<Either<Failure, BaseResponse>> doCreateQuiz({
    required String token,
    required String title,
    required String imageUrl,
    required String category,
    required List<Map<String, dynamic>> examDetails,
  }) async {
    Map<String, dynamic> params = {
      'title': title,
      'imageUrl': imageUrl,
      'category': category,
      'examDetails': examDetails,
    };
    Object response = await ResponseHelper.getResponse(
        () async => await restClient.doCreateQuiz(token, params));

    if (response is Failure) return Left(response);

    return Right(
      BaseResponse(
        response: response,
        errorMessage: null,
        status: true,
      ),
    );
  }
}
