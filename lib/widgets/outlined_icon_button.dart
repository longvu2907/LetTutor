import 'package:flutter/material.dart';

class OutlinedIconButton extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final VoidCallback onPressed;

  const OutlinedIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.iconSize = 25,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        padding: const MaterialStatePropertyAll(
          EdgeInsets.all(10),
        ),
        shape: const MaterialStatePropertyAll(
          CircleBorder(),
        ),
        side: MaterialStatePropertyAll(
          BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
      ),
      onPressed: onPressed,
      child: Icon(
        icon,
        size: iconSize,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
