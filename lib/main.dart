import 'package:flutter/material.dart';
import 'package:lettutor/models/auth.dart';
import 'package:lettutor/models/setting.dart';
import 'package:lettutor/pages/course_detail_page.dart';
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
    Auth? auth = context.watch<Auth?>();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth?>(create: (context) => Auth()),
        ChangeNotifierProvider<Setting>(create: (context) => Setting())
      ],
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: appTheme,
          initialRoute: auth != null ? 'home' : 'login',
          routes: routes,
          onGenerateRoute: (settings) {
            if (settings.name == 'teacher-detail') {
              final args = settings.arguments as String;

              return MaterialPageRoute(
                builder: (context) {
                  return TeacherDetailPage(
                    tutorId: args,
                  );
                },
              );
            }
            if (settings.name == 'course-detail') {
              final args = settings.arguments as String;

              return MaterialPageRoute(
                builder: (context) {
                  return CourseDetailPage(
                    courseId: args,
                  );
                },
              );
            }

            return null;
          },
        ),
      ),
    );
  }
}
