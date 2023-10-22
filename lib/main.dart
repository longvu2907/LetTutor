import 'package:flutter/material.dart';
import 'package:lettutor/pages/login_page.dart';
import 'package:lettutor/theme/app_theme.dart';
import 'package:lettutor/theme/dark_theme.dart';
import 'package:lettutor/theme/light_theme.dart';

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
      theme: lightTheme,
      darkTheme: appTheme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('LetTutor'),
        ),
        body: const LoginPage(),
      ),
    );
  }
}
