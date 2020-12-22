import 'dart:io';

import 'package:app/app.dart';
import 'package:app/config/service_locator.dart';
import 'package:app/di/env.dart';
import 'package:app/utils/my_https.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  Injector.configure(Flavor.DEV);
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));
  SystemChrome.setEnabledSystemUIOverlays([]).then((value) => runApp(MyApp()));
}