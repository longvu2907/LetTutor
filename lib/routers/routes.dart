import 'package:flutter/material.dart';
import 'package:lettutor/pages/auth/forgot_password_page.dart';
import 'package:lettutor/pages/auth/login_page.dart';
import 'package:lettutor/pages/auth/register_page.dart';
import 'package:lettutor/pages/course_detail_page.dart';
import 'package:lettutor/pages/discover_page.dart';
import 'package:lettutor/pages/history_page.dart';
import 'package:lettutor/pages/home_page.dart';
import 'package:lettutor/pages/lesson_detail_page.dart';
import 'package:lettutor/pages/meeting_page.dart';
import 'package:lettutor/pages/schedule_page.dart';
import 'package:lettutor/pages/tutor_list_page.dart';

Map<String, WidgetBuilder> routes = {
  'login': (context) => const LoginPage(),
  'forgot-password': (context) => const ForgotPasswordPage(),
  'register': (context) => const RegisterPage(),
  'home': (context) => const HomePage(),
  // 'teacher-detail': (context) => const TeacherDetailPage(),
  'schedule': (context) => const SchedulePage(),
  'history': (context) => const HistoryPage(),
  'discover': (context) => const DiscoverPage(),
  'course-detail': (context) => const CourseDetailPage(),
  'lesson-detail': (context) => const LessonDetailPage(),
  'meeting': (context) => const MeetingPage(),
  'tutor-list': (context) => const TutorListPage(),
};
