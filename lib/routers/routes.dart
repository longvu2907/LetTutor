import 'package:flutter/material.dart';
import 'package:lettutor/pages/auth/login_page.dart';
import 'package:lettutor/pages/auth/register_page.dart';
import 'package:lettutor/pages/history_page.dart';
import 'package:lettutor/pages/home_page.dart';
import 'package:lettutor/pages/schedule_page.dart';
import 'package:lettutor/pages/teacher_detail_page.dart';

Map<String, WidgetBuilder> routes = {
  'login': (context) => const LoginPage(),
  'register': (context) => const RegisterPage(),
  'home': (context) => const HomePage(),
  'teacher-detail': (context) => const TeacherDetailPage(),
  'schedule': (context) => const SchedulePage(),
  'history': (context) => const HistoryPage(),
};
