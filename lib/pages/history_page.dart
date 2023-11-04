import 'package:flutter/material.dart';
import 'package:lettutor/widgets/bottom_navigation.dart';
import 'package:lettutor/widgets/custom_app_bar.dart';
import 'package:lettutor/widgets/history_card.dart';
import 'package:lettutor/widgets/main_layout.dart';
import 'package:lettutor/widgets/page_header.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

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
              title: 'History',
              subtitle:
                  'The following is a list of lessons you have attended\nYou can review the details of the lessons you have attended',
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
                return const HistoryCard();
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
