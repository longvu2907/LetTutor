import 'package:flutter/material.dart';
import 'package:lettutor/widgets/button.dart';
import 'package:lettutor/widgets/custom_expansion_tile.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        children: [
          // Schedule date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tue, 02 May 23',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Text(
                '1 lesson',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
              ),
            ],
          ),
          Divider(
            color: Colors.grey.shade300,
            thickness: 1,
          ),

          // Teacher info
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 15),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: const NetworkImage(
                      'https://api.app.lettutor.com/avatar/8c4e58c4-e9d1-4353-b64d-41b573c5a3e9avatar1632284832414.jpg',
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Wrap(
                  direction: Axis.vertical,
                  spacing: 5,
                  children: [
                    Text(
                      'Joan Gacer',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Text(
                      'Taiwan',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.chat,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Direct Message',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 14,
                              ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),

          // Schedule time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '21:00 - 21:25',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Button(
                text: 'Cancel',
                onPressed: () {},
                color: ButtonColor.danger,
                type: ButtonType.outlined,
              )
            ],
          ),
          Divider(
            color: Colors.grey.shade300,
            thickness: 1,
          ),

          const CustomExpansionTile(),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Button(text: 'Go to meeting', onPressed: () {}),
            ],
          )
        ],
      ),
    );
  }
}
