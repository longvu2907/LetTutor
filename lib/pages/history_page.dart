import 'package:flutter/material.dart';
import 'package:lettutor/models/auth.dart';
import 'package:lettutor/models/schedule_event.dart';
import 'package:lettutor/services/booking.dart';
import 'package:lettutor/widgets/history_card.dart';
import 'package:lettutor/widgets/page_header.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<ScheduleEvent> _bookings = [];

  void getScheduleList() async {
    var res = await getBookingsHistory(
      accessToken: context.read<Auth>().accessToken.toString(),
    );

    setState(() {
      _bookings = res;
    });
  }

  @override
  void initState() {
    super.initState();

    getScheduleList();
  }

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
              itemCount: _bookings.length,
              itemBuilder: (context, index) {
                return HistoryCard(schedule: _bookings[index]);
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
