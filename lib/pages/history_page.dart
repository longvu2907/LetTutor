import 'package:flutter/material.dart';
import 'package:lettutor/widgets/custom_app_bar.dart';
import 'package:lettutor/widgets/history_card.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Schedule header
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'History',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      'The following is a list of lessons you have attended',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      'You can review the details of the lessons you have attended',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
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
                  return const SizedBox(height: 10);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
