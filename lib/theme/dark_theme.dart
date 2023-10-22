import 'package:flutter/material.dart';
import 'package:lettutor/theme/app_theme.dart';

ThemeData darkTheme = appTheme.copyWith(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: Brightness.dark,
  ),
);
