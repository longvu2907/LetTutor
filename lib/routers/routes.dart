import 'package:flutter/material.dart';
import 'package:lettutor/pages/auth/forgot_password_page.dart';
import 'package:lettutor/pages/auth/login_page.dart';
import 'package:lettutor/pages/auth/register_page.dart';
import 'package:lettutor/pages/become_tutor/become_tutor_page.dart';
import 'package:lettutor/pages/discover_page.dart';
import 'package:lettutor/pages/history_page.dart';
import 'package:lettutor/pages/home_page.dart';
import 'package:lettutor/pages/lesson_detail_page.dart';
import 'package:lettutor/pages/schedule_page.dart';
import 'package:lettutor/pages/setting_page.dart';
import 'package:lettutor/pages/tutor_list_page.dart';

Map<String, WidgetBuilder> routes = {
  'login': (context) => const LoginPage(),
  'forgot-password': (context) => const ForgotPasswordPage(),
  'register': (context) => const RegisterPage(),
  'home': (context) => const HomePage(),
  'schedule': (context) => const SchedulePage(),
  'history': (context) => const HistoryPage(),
  'discover': (context) => const DiscoverPage(),
  'lesson-detail': (context) => const LessonDetailPage(),
  'tutor-list': (context) => const TutorListPage(),
  'setting': (context) => const SettingPage(),
  'become-tutor': (context) => const BecomeTutorPage(),
};
