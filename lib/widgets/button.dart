import 'package:flutter/material.dart';

enum ButtonType { filled, outlined }

enum ButtonColor { primary, danger, white }

class Button extends StatelessWidget {
  final bool isFullWidth;
  final String text;
  final VoidCallback? onPressed;
  final bool rounded;
  final double? width;
  final ButtonType type;
  final ButtonColor color;
  final Widget? prefix;
  final Widget? suffix;
  final bool isLoading;

  const Button({
    super.key,
    required this.text,
    required this.onPressed,
    this.isFullWidth = false,
    this.rounded = false,
    this.isLoading = false,
    this.type = ButtonType.filled,
    this.color = ButtonColor.primary,
    this.width,
    this.prefix,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: isFullWidth ? double.infinity : width,
        child: _getButtonWidget(context));
  }

  _getButtonWidget(BuildContext context) {
    late Color buttonColor;
    switch (color) {
      case ButtonColor.primary:
        buttonColor = Theme.of(context).colorScheme.primary;
        break;
      case ButtonColor.danger:
        buttonColor = Colors.red.shade400;
        break;
      case ButtonColor.white:
        buttonColor = Colors.white;
        break;
      default:
        buttonColor = Theme.of(context).colorScheme.primary;
    }

    switch (type) {
      // Filled button
      case ButtonType.filled:
        return FilledButton(
          onPressed: isLoading ? null : onPressed,
          style: ButtonStyle(
            // backgroundColor: MaterialStatePropertyAll(buttonColor),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: rounded
                    ? BorderRadius.circular(50)
                    : BorderRadius.circular(10),
              ),
            ),
          ),
          child: isLoading
              ? Container(
                  width: 20,
                  height: 20,
                  padding: const EdgeInsets.all(2.0),
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                )
              : Text(text,
                  style: TextStyle(
                      color: color == ButtonColor.white
                          ? Theme.of(context).colorScheme.primary
                          : Colors.white)),
        );

      // Outlined button
      case ButtonType.outlined:
        return OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            side: MaterialStateProperty.all(
              BorderSide(
                color: buttonColor,
              ),
            ),
            overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
              if (states.contains(MaterialState.pressed)) {
                return buttonColor.withOpacity(0.2);
              }
              return Colors.transparent;
            }),
          ),
          child: isLoading
              ? Container(
                  width: 20,
                  height: 20,
                  padding: const EdgeInsets.all(2.0),
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                )
              : Text(
                  text,
                  style: TextStyle(
                    color: buttonColor,
                  ),
                ),
        );
    }
  }
}
