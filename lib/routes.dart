import 'package:flutter/widgets.dart';
import 'package:template/screen/login/login_screen.dart';
import 'package:template/screen/top/top_screen.dart';

import 'screen/splash/splash_screen.dart';

Map<String, WidgetBuilder> routes = {
  "/": (context) => const SplashScreen(),
  "/login": (context) => const LoginScreen(),
  "/top": (context) => const TopScreen(),
};
