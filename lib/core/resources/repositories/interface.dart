import 'package:dartz/dartz.dart';
import 'package:univs/core/utils/base_response/base_response.dart';
import 'package:univs/core/utils/errors/failure.dart';

abstract class RepositoryInterface {
  Future<Either<Failure, BaseResponse<dynamic>>> doLogin({
    required String email,
    required String password,
  });

  Future<Either<Failure, BaseResponse<dynamic>>> doRegister({
    required String name,
    required String dateOfBirth,
    required String username,
    required String email,
    required String password,
    required String passwordConfirmation,
  });

  Future<Either<Failure, BaseResponse<dynamic>>> doCreatePost({
    required String description,
    required String attachment,
    required String token,
  });

  Future<Either<Failure, BaseResponse<dynamic>>> doGetPosts({
    required String token,
  });

  Future<Either<Failure, BaseResponse<dynamic>>> doGetUsers({
    required String token,
    required String id,
  });

  Future<Either<Failure, BaseResponse<dynamic>>> doUpdateProfile({
    required String token,
    required String name,
    required String image,
    required String gender,
    required String university,
    required String dateOfBirth,
  });

  Future<Either<Failure, BaseResponse<dynamic>>> doGetReminder({
    required String token,
  });

  Future<Either<Failure, BaseResponse<dynamic>>> doCreateReminder({
    required String token,
    required String title,
    required String date,
    required String time,
  });

  Future<Either<Failure, BaseResponse<dynamic>>> doGetReminderById({
    required String token,
    required String id,
  });

  Future<Either<Failure, BaseResponse<dynamic>>> doDeleteReminder({
    required String id,
    required String token,
  });

  Future<Either<Failure, BaseResponse<dynamic>>> doComment({
    required int postId,
    required String description,
    required String token,
  });

  Future<Either<Failure, BaseResponse<dynamic>>> doGetPostsByUser({
    required String token,
  });

  Future<Either<Failure, BaseResponse<dynamic>>> doDeletePosts({
    required String id,
    required String token,
  });

  Future<Either<Failure, BaseResponse<dynamic>>> doGetExams({
    required String token,
  });

  Future<Either<Failure, BaseResponse<dynamic>>> doGetExamsDetail({
    required String token,
    required String id,
  });

  Future<Either<Failure, BaseResponse<dynamic>>> doVerifEmail({
    required String email,
  });

  Future<Either<Failure, BaseResponse<dynamic>>> doForgotPassword({
    required String email,
    required int otp,
    required String password,
    required String passwordConfirmation,
  });

  Future<Either<Failure, BaseResponse<dynamic>>> doSubmitQuiz({
    required String token,
    required int examId,
    required List<Map<String, dynamic>> examResponses,
  });

  Future<Either<Failure, BaseResponse<dynamic>>> doCreateQuiz({
    required String token,
    required String title,
    required String imageUrl,
    required String category,
    required List<Map<String, dynamic>> examDetails,
  });
}
