import 'package:flutter/material.dart';
import 'package:zegocloud_uikit/src/auth/views/login_view.dart';
import 'package:zegocloud_uikit/src/home/views/home_page.dart';

class AppRouter {
  static Map<String, WidgetBuilder> routes = {
    LoginPage.routeName: (context) => const LoginPage(),
    HomePage.routeName: (context) => const HomePage(),
  };
}
