import 'package:flutter/material.dart';

SnackBar errorMessage(String message) {
  return SnackBar(
    backgroundColor: Colors.red,
    duration: const Duration(seconds: 5),
    content: Text(message),
  );
}

SnackBar successMessage(String message) {
  return SnackBar(
    backgroundColor: Colors.green,
    duration: const Duration(seconds: 5),
    content: Text(message),
  );
}
