import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final bool isFullWidth;
  final String text;
  final VoidCallback onPressed;
  final bool rounded;
  final double? width;
  final bool outlined;
  final Color? color;

  const Button({
    super.key,
    required this.text,
    required this.onPressed,
    this.isFullWidth = false,
    this.rounded = false,
    this.outlined = false,
    this.width,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : width,
      child: outlined
          ? FilledButton(
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
            )
          : OutlinedButton(
              onPressed: () {},
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                side: MaterialStateProperty.all(
                  BorderSide(
                    color: Colors.red.shade400,
                  ),
                ),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.red.shade400,
                ),
              ),
            ),
    );
  }
}
