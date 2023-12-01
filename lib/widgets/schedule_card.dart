import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/models/schedule_event.dart';
import 'package:lettutor/widgets/button.dart';
import 'package:lettutor/widgets/custom_expansion_tile.dart';

class ScheduleCard extends StatelessWidget {
  final ScheduleEvent schedule;

  const ScheduleCard({
    super.key,
    required this.schedule,
  });

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
                DateFormat('E, dd MMM yy').format(schedule.start),
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
                    backgroundImage: NetworkImage(
                      schedule.tutor?.avatar ?? "",
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Wrap(
                  direction: Axis.vertical,
                  spacing: 5,
                  children: [
                    Text(
                      schedule.tutor?.name ?? "",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Text(
                      '${Country.tryParse(schedule.tutor?.country ?? '')?.flagEmoji ?? ""} ${Country.tryParse(schedule.tutor?.country ?? '')?.name ?? schedule.tutor?.country}',
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
                schedule.toString(),
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
              Button(
                text: 'Go to meeting',
                onPressed: () {
                  Navigator.pushNamed(context, 'meeting');
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
