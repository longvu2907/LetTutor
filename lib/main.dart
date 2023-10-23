import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/pages/auth/register_page.dart';
import 'package:lettutor/pages/auth/login_page.dart';
import 'package:lettutor/routers/routes.dart';
import 'package:lettutor/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      initialRoute: 'home',
      routes: routes,
    );
  }
}
