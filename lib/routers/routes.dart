import 'package:flutter/material.dart';
import 'package:lettutor/pages/auth/login_page.dart';
import 'package:lettutor/pages/auth/register_page.dart';
import 'package:lettutor/pages/home_page.dart';

Map<String, WidgetBuilder> routes = {
  'login': (context) => const LoginPage(),
  'register': (context) => const RegisterPage(),
  'home': (context) => const HomePage(),
};