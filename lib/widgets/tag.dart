import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final String text;
  final bool selected;

  const Tag({
    super.key,
    required this.text,
    this.selected = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: selected
              ? Theme.of(context).primaryColor.withOpacity(.1)
              : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: selected ? Theme.of(context).primaryColor : Colors.black,
              ),
        ));
  }
}
