import 'package:get_it/get_it.dart';
import 'package:univs/core/helpers/db/db_helper.dart';
import 'package:univs/core/helpers/secure_storage/storage_helper.dart';
import 'package:univs/core/resources/network/http_service.dart';
import 'package:univs/core/resources/network/navigation_service.dart';
import 'package:univs/core/resources/network/rest_client.dart';
import 'package:univs/core/resources/repositories/repository.dart';
import 'package:univs/features/forgot/provider/email_verif_provider.dart';
import 'package:univs/features/forgot/provider/forgot_password_provider.dart';
import 'package:univs/features/home/provider/comment_provider.dart';
import 'package:univs/features/home/provider/delete_delete_provider.dart';
import 'package:univs/features/home/provider/get_postByUser_provider.dart';
import 'package:univs/features/home/provider/get_post_provider.dart';
import 'package:univs/features/login/provider/login_provider.dart';
import 'package:univs/features/posting/provider/create_post_provider.dart';
import 'package:univs/features/profile/provider/create_reminder_provider.dart';
import 'package:univs/features/profile/provider/delete_reminder_provider.dart';
import 'package:univs/features/profile/provider/edit_user_provider.dart';
import 'package:univs/features/profile/provider/get_reminderById_provider.dart';
import 'package:univs/features/profile/provider/get_reminder_provider.dart';
import 'package:univs/features/profile/provider/get_user_provider.dart';
import 'package:univs/features/quiz/provider/create_quiz_provider.dart';
import 'package:univs/features/quiz/provider/get_quiz_detail_provider.dart';
import 'package:univs/features/quiz/provider/get_quiz_provider.dart';
import 'package:univs/features/quiz/provider/submit_quiz_provider.dart';
import 'package:univs/features/register/provider/register_provider.dart';

final sl = GetIt.instance;

Future<void> initilizeDi() async {
  //database
  sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // Network
  sl.registerLazySingleton<HttpService>(() => HttpService());
  sl.registerSingleton<RestClient>(RestClient(sl<HttpService>().dio));
  sl.registerLazySingleton(() => Repository(restClient: sl<RestClient>()));

  // Provider
  sl.registerFactory<RegisterProvider>(
      () => RegisterProvider(repository: sl<Repository>()));
  sl.registerFactory<LoginProvider>(
      () => LoginProvider(repository: sl<Repository>()));
  sl.registerFactory<CreatePostProvider>(
      () => CreatePostProvider(repository: sl<Repository>()));
  sl.registerFactory<GetPostProvider>(
      () => GetPostProvider(repository: sl<Repository>()));
  sl.registerFactory<GetUserProvider>(
      () => GetUserProvider(repository: sl<Repository>()));
  sl.registerFactory<EditUserProvider>(
      () => EditUserProvider(repository: sl<Repository>()));
  sl.registerFactory<GetReminderProvider>(
      () => GetReminderProvider(repository: sl<Repository>()));
  sl.registerFactory<CreateReminderProvider>(
      () => CreateReminderProvider(repository: sl<Repository>()));
  sl.registerFactory<GetReminderByIdProvider>(
      () => GetReminderByIdProvider(repository: sl<Repository>()));
  sl.registerFactory<DeleteReminderProvider>(
      () => DeleteReminderProvider(repository: sl<Repository>()));
  sl.registerFactory<CommentProvider>(
      () => CommentProvider(repository: sl<Repository>()));
  sl.registerFactory<GetPostByUserProvider>(
      () => GetPostByUserProvider(repository: sl<Repository>()));
  sl.registerFactory<DeletePostsProvider>(
      () => DeletePostsProvider(repository: sl<Repository>()));
  sl.registerFactory<GetQuizProvider>(
      () => GetQuizProvider(repository: sl<Repository>()));
  sl.registerFactory<VerifEmailProvider>(
      () => VerifEmailProvider(repository: sl<Repository>()));
  sl.registerFactory<ForgotPasswordProvider>(
      () => ForgotPasswordProvider(repository: sl<Repository>()));
  sl.registerFactory<GetQuizDetailProvider>(
      () => GetQuizDetailProvider(repository: sl<Repository>()));
  sl.registerFactory<SubmitQuizProvider>(
      () => SubmitQuizProvider(repository: sl<Repository>()));
  sl.registerFactory<CreateQuizProvider>(
      () => CreateQuizProvider(repository: sl<Repository>()));

  //Others
  sl.registerSingleton<NavigationService>(NavigationService());
  sl.registerSingleton<Storage>(Storage());
}
