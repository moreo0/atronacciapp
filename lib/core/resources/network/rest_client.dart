import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST('/auth/login')
  Future doLogin(@Body() Map<String, dynamic> data);

  @POST('/auth/register')
  Future doRegister(@Body() Map<String, dynamic> data);

  @POST('/posts')
  Future doCreatePost(
    @Header('Authorization') String token,
    @Body() Map<String, dynamic> data,
  );

  @GET('/posts')
  Future doGetPosts(
    @Header('Authorization') String token,
  );

  @GET('/users/{id}')
  Future doGetUsers(
    @Header('Authorization') String token,
    @Path('id') String id,
  );

  @POST('/users/update')
  Future doUpdateProfile(
    @Header('Authorization') String token,
    @Body() Map<String, dynamic> data,
  );

  @GET('/reminders')
  Future doGetReminder(
    @Header('Authorization') String token,
  );

  @POST('/reminders')
  Future doCreateReminder(
    @Header('Authorization') String token,
    @Body() Map<String, dynamic> data,
  );

  @GET('/reminders/{id}')
  Future doGetReminderById(
    @Header('Authorization') String token,
    @Path('id') String id,
  );

  @DELETE('/reminders/{id}')
  Future doDeleteReminder(
    @Path('id') String id,
    @Header('Authorization') String token,
  );

  @POST('/comments')
  Future doComment(
    @Header('Authorization') String token,
    @Body() Map<String, dynamic> data,
  );

  @GET('/posts/get-by-user')
  Future doGetPostsByUser(
    @Header('Authorization') String token,
  );

  @DELETE('/posts/{id}')
  Future doDeletePosts(
    @Path('id') String id,
    @Header('Authorization') String token,
  );

  @GET('/exams')
  Future doGetExams(
    @Header('Authorization') String token,
  );

  @GET('/exams/{id}')
  Future doGetExamsDetail(
    @Header('Authorization') String token,
    @Path('id') String id,
  );

  @POST('/auth/send-email')
  Future doVerifEmail(
    @Body() Map<String, dynamic> data,
  );

  @POST('/auth/reset-password')
  Future doForgotPassowrd(
    @Body() Map<String, dynamic> data,
  );

  @POST('/exams/submit')
  Future doSubmitQuiz(
    @Header('Authorization') String token,
    @Body() Map<String, dynamic> data,
  );

  @POST('/exams')
  Future doCreateQuiz(
    @Header('Authorization') String token,
    @Body() Map<String, dynamic> data,
  );
}
