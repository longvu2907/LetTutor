import 'package:flutter/material.dart';
import 'package:lettutor/models/auth.dart';
import 'package:lettutor/pages/teacher_detail_page.dart';
import 'package:lettutor/routers/routes.dart';
import 'package:lettutor/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider<Auth?>(create: (context) => Auth())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        initialRoute: 'home',
        routes: routes,
        onGenerateRoute: (settings) {
          if (settings.name == 'teacher-detail') {
            final args = settings.arguments as String;

            return MaterialPageRoute(
              builder: (context) {
                return TeacherDetailPage(
                  userId: args,
                );
              },
            );
          }
        },
      ),
    );
  }
}
