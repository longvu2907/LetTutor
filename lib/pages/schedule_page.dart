import 'package:flutter/material.dart';
import 'package:lettutor/models/auth.dart';
import 'package:lettutor/models/schedule_event.dart';
import 'package:lettutor/services/booking.dart';
import 'package:lettutor/widgets/page_header.dart';
import 'package:lettutor/widgets/schedule_card.dart';
import 'package:lettutor/widgets/snackbar_notify.dart';
import 'package:provider/provider.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  List<ScheduleEvent> _bookings = [];
  bool _isLoading = true;
  final GetBookingQuery _query = GetBookingQuery();

  void getScheduleList() async {
    var res = await getBookings(
      accessToken: context.read<Auth>().accessToken.toString(),
      bookingQuery: _query,
    );

    setState(() {
      _bookings = res;
    });
  }

  void fetchData({bool isRefresh = false}) {
    try {
      getScheduleList();

      if (isRefresh) {
        ScaffoldMessenger.of(context).showSnackBar(
          successMessage('Refresh data success'),
        );
      }
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        errorMessage(e.toString()),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      fetchData();
    }

    return RefreshIndicator(
      onRefresh: () {
        fetchData(isRefresh: true);

        return Future.delayed(const Duration(seconds: 1));
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
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
              // Pagination
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: _query.page <= 1
                        ? null
                        : () {
                            setState(() {
                              _query.page = _query.page - 1;
                            });

                            getScheduleList();
                          },
                  ),
                  Text(
                    _query.page.toString(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: _bookings.length < _query.perPage
                        ? null
                        : () {
                            setState(() {
                              _query.page = _query.page + 1;
                            });

                            getScheduleList();
                          },
                  ),
                ],
              ),

              // Booking card list
              ListView.separated(
                padding: const EdgeInsets.only(top: 10),
                primary: false,
                shrinkWrap: true,
                itemCount: _bookings.length,
                itemBuilder: (context, index) {
                  return ScheduleCard(
                    schedule: _bookings[index],
                    onCancel: (value) {
                      if (value) {
                        setState(() {
                          _isLoading = true;
                        });
                      }
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 20);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
