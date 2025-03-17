// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:univs/core/routes/router_import.dart' as app_router;
import 'package:provider/provider.dart';
import 'package:univs/core/resources/injector/di.dart' as di;
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

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final _router = app_router.AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RegisterProvider>(
          create: (_) => di.sl<RegisterProvider>(),
        ),
        ChangeNotifierProvider<LoginProvider>(
          create: (_) => di.sl<LoginProvider>(),
        ),
        ChangeNotifierProvider<CreatePostProvider>(
          create: (_) => di.sl<CreatePostProvider>(),
        ),
        ChangeNotifierProvider<GetPostProvider>(
          create: (_) => di.sl<GetPostProvider>(),
        ),
        ChangeNotifierProvider<GetUserProvider>(
          create: (_) => di.sl<GetUserProvider>(),
        ),
        ChangeNotifierProvider<EditUserProvider>(
          create: (_) => di.sl<EditUserProvider>(),
        ),
        ChangeNotifierProvider<GetReminderProvider>(
          create: (_) => di.sl<GetReminderProvider>(),
        ),
        ChangeNotifierProvider<CreateReminderProvider>(
          create: (_) => di.sl<CreateReminderProvider>(),
        ),
        ChangeNotifierProvider<GetReminderByIdProvider>(
          create: (_) => di.sl<GetReminderByIdProvider>(),
        ),
        ChangeNotifierProvider<DeleteReminderProvider>(
          create: (_) => di.sl<DeleteReminderProvider>(),
        ),
        ChangeNotifierProvider<CommentProvider>(
          create: (_) => di.sl<CommentProvider>(),
        ),
        ChangeNotifierProvider<GetPostByUserProvider>(
          create: (_) => di.sl<GetPostByUserProvider>(),
        ),
        ChangeNotifierProvider<DeletePostsProvider>(
          create: (_) => di.sl<DeletePostsProvider>(),
        ),
        ChangeNotifierProvider<GetQuizProvider>(
          create: (_) => di.sl<GetQuizProvider>(),
        ),
        ChangeNotifierProvider<VerifEmailProvider>(
          create: (_) => di.sl<VerifEmailProvider>(),
        ),
        ChangeNotifierProvider<ForgotPasswordProvider>(
          create: (_) => di.sl<ForgotPasswordProvider>(),
        ),
        ChangeNotifierProvider<GetQuizDetailProvider>(
          create: (_) => di.sl<GetQuizDetailProvider>(),
        ),
        ChangeNotifierProvider<SubmitQuizProvider>(
          create: (_) => di.sl<SubmitQuizProvider>(),
        ),
        ChangeNotifierProvider<CreateQuizProvider>(
          create: (_) => di.sl<CreateQuizProvider>(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        locale: const Locale('id'),
        routerDelegate: _router.delegate(
          navigatorObservers: () => [app_router.RouterObserver()],
        ),
        routeInformationParser: _router.defaultRouteParser(),
      ),
    );
  }
}
