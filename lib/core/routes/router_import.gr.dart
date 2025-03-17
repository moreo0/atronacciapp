// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i21;
import 'package:flutter/cupertino.dart' as _i22;
import 'package:flutter/material.dart' as _i23;
import 'package:univs/features/forgot/pages/change_password.dart' as _i1;
import 'package:univs/features/forgot/pages/email_verif.dart' as _i6;
import 'package:univs/features/home/pages/home_page.dart' as _i7;
import 'package:univs/features/login/pages/login_page.dart' as _i9;
import 'package:univs/features/main_page.dart' as _i10;
import 'package:univs/features/notification/pages/notification_page.dart'
    as _i11;
import 'package:univs/features/posting/pages/create_posting_page.dart' as _i3;
import 'package:univs/features/profile/pages/create_set_reminder_page.dart'
    as _i4;
import 'package:univs/features/profile/pages/edit_profile_page.dart' as _i5;
import 'package:univs/features/profile/pages/lihat_postingan_page.dart' as _i8;
import 'package:univs/features/profile/pages/profile_page.dart' as _i12;
import 'package:univs/features/profile/pages/set_reminder_page.dart' as _i20;
import 'package:univs/features/quiz/model/quiz_submission_response.dart'
    as _i24;
import 'package:univs/features/quiz/pages/chatai_page.dart' as _i2;
import 'package:univs/features/quiz/pages/quiz_create_page.dart' as _i13;
import 'package:univs/features/quiz/pages/quiz_detail_page.dart' as _i14;
import 'package:univs/features/quiz/pages/quiz_nilai_page.dart' as _i15;
import 'package:univs/features/quiz/pages/quiz_page.dart' as _i16;
import 'package:univs/features/quiz/pages/quiz_soal_page.dart' as _i17;
import 'package:univs/features/register/pages/register_page.dart' as _i18;
import 'package:univs/features/searching/pages/search_page.dart' as _i19;

abstract class $AppRouter extends _i21.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i21.PageFactory> pagesMap = {
    ChangePasswordRoute.name: (routeData) {
      final args = routeData.argsAs<ChangePasswordRouteArgs>();
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.ChangePasswordPage(
          key: args.key,
          email: args.email,
        ),
      );
    },
    ChatAIRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.ChatAIPage(),
      );
    },
    CreatePostingRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.CreatePostingPage(),
      );
    },
    CreateSetReminderRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.CreateSetReminderPage(),
      );
    },
    EditProfileRoute.name: (routeData) {
      final args = routeData.argsAs<EditProfileRouteArgs>();
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.EditProfilePage(
          key: args.key,
          name: args.name,
          dateOfBirth: args.dateOfBirth,
          university: args.university,
          gender: args.gender,
          imageUrl: args.imageUrl,
        ),
      );
    },
    EmailVerifRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.EmailVerifPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.HomePage(),
      );
    },
    LihatPostinganRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.LihatPostinganPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.LoginPage(),
      );
    },
    MainRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.MainPage(),
      );
    },
    NotificationRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.NotificationPage(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.ProfilePage(),
      );
    },
    QuizCreateRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.QuizCreatePage(),
      );
    },
    QuizDetailRoute.name: (routeData) {
      final args = routeData.argsAs<QuizDetailRouteArgs>();
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.QuizDetailPage(
          key: args.key,
          id: args.id,
          quizName: args.quizName,
        ),
      );
    },
    QuizNilaiRoute.name: (routeData) {
      final args = routeData.argsAs<QuizNilaiRouteArgs>();
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.QuizNilaiPage(
          key: args.key,
          submissionResponse: args.submissionResponse,
          totalSoal: args.totalSoal,
        ),
      );
    },
    QuizRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.QuizPage(),
      );
    },
    QuizSoalRoute.name: (routeData) {
      final args = routeData.argsAs<QuizSoalRouteArgs>();
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.QuizSoalPage(
          key: args.key,
          id: args.id,
        ),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i18.RegisterPage(),
      );
    },
    SearchRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i19.SearchPage(),
      );
    },
    SetReminderRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i20.SetReminderPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.ChangePasswordPage]
class ChangePasswordRoute extends _i21.PageRouteInfo<ChangePasswordRouteArgs> {
  ChangePasswordRoute({
    _i22.Key? key,
    required String email,
    List<_i21.PageRouteInfo>? children,
  }) : super(
          ChangePasswordRoute.name,
          args: ChangePasswordRouteArgs(
            key: key,
            email: email,
          ),
          initialChildren: children,
        );

  static const String name = 'ChangePasswordRoute';

  static const _i21.PageInfo<ChangePasswordRouteArgs> page =
      _i21.PageInfo<ChangePasswordRouteArgs>(name);
}

class ChangePasswordRouteArgs {
  const ChangePasswordRouteArgs({
    this.key,
    required this.email,
  });

  final _i22.Key? key;

  final String email;

  @override
  String toString() {
    return 'ChangePasswordRouteArgs{key: $key, email: $email}';
  }
}

/// generated route for
/// [_i2.ChatAIPage]
class ChatAIRoute extends _i21.PageRouteInfo<void> {
  const ChatAIRoute({List<_i21.PageRouteInfo>? children})
      : super(
          ChatAIRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatAIRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i3.CreatePostingPage]
class CreatePostingRoute extends _i21.PageRouteInfo<void> {
  const CreatePostingRoute({List<_i21.PageRouteInfo>? children})
      : super(
          CreatePostingRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreatePostingRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i4.CreateSetReminderPage]
class CreateSetReminderRoute extends _i21.PageRouteInfo<void> {
  const CreateSetReminderRoute({List<_i21.PageRouteInfo>? children})
      : super(
          CreateSetReminderRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateSetReminderRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i5.EditProfilePage]
class EditProfileRoute extends _i21.PageRouteInfo<EditProfileRouteArgs> {
  EditProfileRoute({
    _i23.Key? key,
    required String name,
    required String dateOfBirth,
    required String university,
    required String gender,
    required String imageUrl,
    List<_i21.PageRouteInfo>? children,
  }) : super(
          EditProfileRoute.name,
          args: EditProfileRouteArgs(
            key: key,
            name: name,
            dateOfBirth: dateOfBirth,
            university: university,
            gender: gender,
            imageUrl: imageUrl,
          ),
          initialChildren: children,
        );

  static const String name = 'EditProfileRoute';

  static const _i21.PageInfo<EditProfileRouteArgs> page =
      _i21.PageInfo<EditProfileRouteArgs>(name);
}

class EditProfileRouteArgs {
  const EditProfileRouteArgs({
    this.key,
    required this.name,
    required this.dateOfBirth,
    required this.university,
    required this.gender,
    required this.imageUrl,
  });

  final _i23.Key? key;

  final String name;

  final String dateOfBirth;

  final String university;

  final String gender;

  final String imageUrl;

  @override
  String toString() {
    return 'EditProfileRouteArgs{key: $key, name: $name, dateOfBirth: $dateOfBirth, university: $university, gender: $gender, imageUrl: $imageUrl}';
  }
}

/// generated route for
/// [_i6.EmailVerifPage]
class EmailVerifRoute extends _i21.PageRouteInfo<void> {
  const EmailVerifRoute({List<_i21.PageRouteInfo>? children})
      : super(
          EmailVerifRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmailVerifRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i7.HomePage]
class HomeRoute extends _i21.PageRouteInfo<void> {
  const HomeRoute({List<_i21.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i8.LihatPostinganPage]
class LihatPostinganRoute extends _i21.PageRouteInfo<void> {
  const LihatPostinganRoute({List<_i21.PageRouteInfo>? children})
      : super(
          LihatPostinganRoute.name,
          initialChildren: children,
        );

  static const String name = 'LihatPostinganRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i9.LoginPage]
class LoginRoute extends _i21.PageRouteInfo<void> {
  const LoginRoute({List<_i21.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i10.MainPage]
class MainRoute extends _i21.PageRouteInfo<void> {
  const MainRoute({List<_i21.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i11.NotificationPage]
class NotificationRoute extends _i21.PageRouteInfo<void> {
  const NotificationRoute({List<_i21.PageRouteInfo>? children})
      : super(
          NotificationRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotificationRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i12.ProfilePage]
class ProfileRoute extends _i21.PageRouteInfo<void> {
  const ProfileRoute({List<_i21.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i13.QuizCreatePage]
class QuizCreateRoute extends _i21.PageRouteInfo<void> {
  const QuizCreateRoute({List<_i21.PageRouteInfo>? children})
      : super(
          QuizCreateRoute.name,
          initialChildren: children,
        );

  static const String name = 'QuizCreateRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i14.QuizDetailPage]
class QuizDetailRoute extends _i21.PageRouteInfo<QuizDetailRouteArgs> {
  QuizDetailRoute({
    _i23.Key? key,
    required int id,
    required String quizName,
    List<_i21.PageRouteInfo>? children,
  }) : super(
          QuizDetailRoute.name,
          args: QuizDetailRouteArgs(
            key: key,
            id: id,
            quizName: quizName,
          ),
          initialChildren: children,
        );

  static const String name = 'QuizDetailRoute';

  static const _i21.PageInfo<QuizDetailRouteArgs> page =
      _i21.PageInfo<QuizDetailRouteArgs>(name);
}

class QuizDetailRouteArgs {
  const QuizDetailRouteArgs({
    this.key,
    required this.id,
    required this.quizName,
  });

  final _i23.Key? key;

  final int id;

  final String quizName;

  @override
  String toString() {
    return 'QuizDetailRouteArgs{key: $key, id: $id, quizName: $quizName}';
  }
}

/// generated route for
/// [_i15.QuizNilaiPage]
class QuizNilaiRoute extends _i21.PageRouteInfo<QuizNilaiRouteArgs> {
  QuizNilaiRoute({
    _i23.Key? key,
    required _i24.QuizSubmissionResponse submissionResponse,
    required int totalSoal,
    List<_i21.PageRouteInfo>? children,
  }) : super(
          QuizNilaiRoute.name,
          args: QuizNilaiRouteArgs(
            key: key,
            submissionResponse: submissionResponse,
            totalSoal: totalSoal,
          ),
          initialChildren: children,
        );

  static const String name = 'QuizNilaiRoute';

  static const _i21.PageInfo<QuizNilaiRouteArgs> page =
      _i21.PageInfo<QuizNilaiRouteArgs>(name);
}

class QuizNilaiRouteArgs {
  const QuizNilaiRouteArgs({
    this.key,
    required this.submissionResponse,
    required this.totalSoal,
  });

  final _i23.Key? key;

  final _i24.QuizSubmissionResponse submissionResponse;

  final int totalSoal;

  @override
  String toString() {
    return 'QuizNilaiRouteArgs{key: $key, submissionResponse: $submissionResponse, totalSoal: $totalSoal}';
  }
}

/// generated route for
/// [_i16.QuizPage]
class QuizRoute extends _i21.PageRouteInfo<void> {
  const QuizRoute({List<_i21.PageRouteInfo>? children})
      : super(
          QuizRoute.name,
          initialChildren: children,
        );

  static const String name = 'QuizRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i17.QuizSoalPage]
class QuizSoalRoute extends _i21.PageRouteInfo<QuizSoalRouteArgs> {
  QuizSoalRoute({
    _i23.Key? key,
    required int id,
    List<_i21.PageRouteInfo>? children,
  }) : super(
          QuizSoalRoute.name,
          args: QuizSoalRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'QuizSoalRoute';

  static const _i21.PageInfo<QuizSoalRouteArgs> page =
      _i21.PageInfo<QuizSoalRouteArgs>(name);
}

class QuizSoalRouteArgs {
  const QuizSoalRouteArgs({
    this.key,
    required this.id,
  });

  final _i23.Key? key;

  final int id;

  @override
  String toString() {
    return 'QuizSoalRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i18.RegisterPage]
class RegisterRoute extends _i21.PageRouteInfo<void> {
  const RegisterRoute({List<_i21.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i19.SearchPage]
class SearchRoute extends _i21.PageRouteInfo<void> {
  const SearchRoute({List<_i21.PageRouteInfo>? children})
      : super(
          SearchRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i20.SetReminderPage]
class SetReminderRoute extends _i21.PageRouteInfo<void> {
  const SetReminderRoute({List<_i21.PageRouteInfo>? children})
      : super(
          SetReminderRoute.name,
          initialChildren: children,
        );

  static const String name = 'SetReminderRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}
