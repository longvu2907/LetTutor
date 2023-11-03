import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;

  const PageHeader({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
          size: 75,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            IntrinsicHeight(
              child: Row(
                children: [
                  Container(
                    width: 3,
                    margin: const EdgeInsets.only(right: 5),
                    color: Colors.black26,
                  ),
                  Expanded(
                    child: Text(
                      subtitle ?? "",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
