import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final bool isFullWidth;
  final String text;
  final VoidCallback onPressed;
  final bool rounded;
  final double? width;

  const Button({
    super.key,
    required this.text,
    required this.onPressed,
    this.isFullWidth = false,
    this.rounded = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : width,
      child: FilledButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: rounded
                  ? BorderRadius.circular(50)
                  : BorderRadius.circular(10),
            ),
          ),
        ),
        child: Text(text),
      ),
    );
  }
}
