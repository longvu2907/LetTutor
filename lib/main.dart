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
      home: LoginPage(),
      // initialRoute: 'login',
      // routes: routes,
      onGenerateRoute: (RouteSettings settings) {
        print(settings.name);
        switch (settings.name) {
          case 'login':
            return SlideRightRoute(widget: const LoginPage());
          case 'register':
            return SlideRightRoute(widget: const RegisterPage());
        }
      },
    );
  }
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget widget;

  SlideRightRoute({required this.widget})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
}
