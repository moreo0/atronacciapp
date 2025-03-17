import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:univs/app.dart';
import 'package:univs/core/resources/env/env.dart';
import 'package:univs/firebase_options.dart';
import 'core/resources/injector/di.dart' as di;
import 'package:intl/date_symbol_data_local.dart';

Future<void> mainCommon(EnvConfig env) async {
  di.sl.registerSingleton<EnvConfig>(env);
  di.initilizeDi();

  initializeDateFormatting();

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const AppWidget());
}
