import 'package:flutter/material.dart';
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
      initialRoute: 'discover',
      routes: routes,
    );
  }
}
