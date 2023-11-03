import 'package:flutter/material.dart';

class CustomExpansionTile extends StatefulWidget {
  const CustomExpansionTile({super.key});

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.all(0),
        childrenPadding: const EdgeInsets.all(0),
        initiallyExpanded: _isExpanded,
        onExpansionChanged: (value) {
          setState(() {
            _isExpanded = value;
          });
        },
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Request for lesson',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
        leading: AnimatedRotation(
          turns: _isExpanded ? 0 : 0.5,
          duration: const Duration(milliseconds: 200),
          child: const Icon(Icons.arrow_drop_up),
        ),
        trailing: Text(
          'Edit request',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        expandedAlignment: Alignment.centerLeft,
        children: [
          Text(
            'Currently there are no requests for this class. Please write down any requests for the teacher.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.black45,
                ),
          ),
        ],
      ),
    );
  }
}
