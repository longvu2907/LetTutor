import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/models/schedule_event.dart';
import 'package:lettutor/widgets/rating.dart';
import 'package:timeago/timeago.dart' as timeago;

class HistoryCard extends StatelessWidget {
  final ScheduleEvent schedule;

  const HistoryCard({
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
                timeago.format(schedule.start),
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
            children: [
              Text(
                'Lesson Time: $schedule',
                style: Theme.of(context).textTheme.bodyLarge,
              )
            ],
          ),
          Divider(
            color: Colors.grey.shade300,
            thickness: 1,
          ),
          const SizedBox(
            height: 20,
          ),

          // Schedule detail
          // Request
          Row(children: [
            Text(schedule.studentRequest ?? 'No request for lesson'),
          ]),
          Divider(
            color: Colors.grey.shade300,
            thickness: 1,
          ),

          // Reviews
          const Row(children: [
            Text("Tutor haven't reviewed yet"),
          ]),
          Divider(
            color: Colors.grey.shade300,
            thickness: 1,
          ),

          // Rating
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: schedule.feedbacks.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  const Text('Rating: '),
                  const SizedBox(width: 10),
                  Rating(rating: schedule.feedbacks[index].rating),
                  const SizedBox(width: 25),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Edit',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                        Text(
                          'Report',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 5,
              );
            },
          ),
          schedule.feedbacks.isEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    Text(
                      'Report',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
