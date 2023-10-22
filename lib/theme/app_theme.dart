import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w500,
      ),
      titleLarge: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    ),
    colorScheme: ColorScheme.light(
      background: Colors.grey.shade100,
      primary: const Color(0xff0071F0),
    ));
