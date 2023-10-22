import 'package:flutter/material.dart';
import 'package:lettutor/theme/app_theme.dart';

ThemeData lightTheme = appTheme.copyWith(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.red,
    brightness: Brightness.light,
  ),
);
