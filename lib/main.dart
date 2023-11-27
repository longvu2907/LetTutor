import 'package:flutter/material.dart';
import 'package:lettutor/models/user.dart';
import 'package:lettutor/routers/routes.dart';
import 'package:lettutor/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final User? _userData = null;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // print(_userData);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<User?>(create: (context) => _userData)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        initialRoute: 'home',
        routes: routes,
      ),
    );
  }
}
