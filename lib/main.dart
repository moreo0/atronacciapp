import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:univs/core/resources/env/env.dart';
import 'package:univs/main_common.dart';

void main() async {
  Gemini.init(
    apiKey: 'AIzaSyCkk9h-vCjVmH9PyWZGsWNtG_s4czFxolY',
  );

  await mainCommon(
    EnvConfig(
      color: Colors.blue,
      server: 'http://194.164.150.141:3000/api',
      values: const EnvValues(titleApp: "PRODUCTION"),
      webApiServer: 'http://194.164.150.141:3000/api',
      webviewServer: 'http://194.164.150.141:3000/api',
    ),
  );
}
