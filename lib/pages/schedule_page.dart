import 'package:flutter/material.dart';
import 'package:lettutor/widgets/page_header.dart';
import 'package:lettutor/widgets/schedule_card.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Schedule header
            const PageHeader(
              title: 'Schedule',
              subtitle:
                  'Here is a list of the sessions you have booked.\nYou can track when the meeting starts, join the meeting with one click or can cancel the meeting before 2 hours',
            ),

            // Schedule list
            const SizedBox(
              height: 25,
            ),
            Text(
              'Latest Book',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),

            // Booking card list
            ListView.separated(
              padding: const EdgeInsets.only(top: 10),
              primary: false,
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return const ScheduleCard();
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 20);
              },
            ),
          ],
        ),
      ),
    );
  }
}
