import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/models/auth.dart';
import 'package:lettutor/models/schedule_event.dart';
import 'package:lettutor/models/user.dart';
import 'package:lettutor/services/booking.dart';
import 'package:lettutor/services/tutor.dart';
import 'package:lettutor/widgets/page_header.dart';
import 'package:lettutor/widgets/snackbar_notify.dart';
import 'package:lettutor/widgets/tag.dart';
import 'package:lettutor/widgets/teacher_card.dart';
import 'package:lettutor/widgets/text_input.dart';
import 'package:provider/provider.dart';

class TutorListPage extends StatefulWidget {
  const TutorListPage({super.key});

  @override
  State<TutorListPage> createState() => _TutorListPageState();
}

class _TutorListPageState extends State<TutorListPage> {
  TutorSearchQuery _query = TutorSearchQuery();
  String _selectedSpecialty = 'All';
  String? _nationality;
  List<User> _tutors = [];
  final List<String> _specialties = [
    'All',
    "English for kids",
    "Business English",
    "Conversational",
    "STARTERS",
    "MOVERS",
    "FLYERS",
    "KET",
    "PET",
    "IELTS",
    "TOEFL",
    "TOEIC",
  ];
  Timer? _timer;
  bool _isLoading = false;
  int _totalTime = 0;
  ScheduleEvent? _nextBooking;
  Duration? _startIn;

  String transformMinutesToString(int minutes) {
    int hours = minutes ~/ 60;
    int mins = minutes % 60;

    return "${hours} hours ${mins} minutes";
  }

  String transformBookingToString(ScheduleEvent? booking) {
    return booking != null
        ? "${DateFormat('E, dd MMM yy').format(booking.start)} ${booking.toString()}"
        : "";
  }

  void updateTutorList() {
    _isLoading = true;

    getTutorList(
      accessToken: context.read<Auth>().accessToken.toString(),
      query: _query,
    )
        .then((value) => setState(() {
              _tutors = value;
            }))
        .catchError(
      (error) {
        print(error);
      },
    ).whenComplete(
      () => setState(() {
        _isLoading = false;
      }),
    );
  }

  void getTotalTime() {
    getTotalLearningTime(
      accessToken: context.read<Auth>().accessToken.toString(),
    ).then((value) {
      setState(() {
        _totalTime = value;
      });
    });
  }

  void getUpcomingBooking() {
    getNextBooking(
      accessToken: context.read<Auth>().accessToken.toString(),
    ).then((value) {
      setState(() {
        _nextBooking = value;
      });
    });
  }

  void fetchData({bool isRefresh = false}) {
    try {
      updateTutorList();
      getTotalTime();
      getUpcomingBooking();

      if (isRefresh) {
        ScaffoldMessenger.of(context).showSnackBar(
          successMessage('Refresh data success'),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(errorMessage(e.toString()));
    }
  }

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _startIn = _nextBooking?.start.difference(DateTime.now());
      });
    });

    fetchData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        fetchData(isRefresh: true);

        return Future.delayed(const Duration(seconds: 1));
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Upcoming class
            Container(
              height: _nextBooking != null ? 225 : 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Upcoming lesson',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    _nextBooking != null
                        ? Column(
                            children: [
                              Text(
                                transformBookingToString(_nextBooking),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(color: Colors.white),
                              ),
                              Text(
                                '(Starts in ${_startIn.toString().split('.').first.padLeft(8, "0")})',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(color: Colors.yellowAccent),
                              ),
                              ElevatedButton(
                                child: const Text('Enter lesson room'),
                                onPressed: () {},
                              ),
                              const SizedBox(height: 10),
                            ],
                          )
                        : Container(),
                    Text(
                      'Total lesson time is ${transformMinutesToString(_totalTime)}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PageHeader(
                    title: 'Find a Tutor',
                    subtitle:
                        'Find the right tutor for you\nYou can search for tutors by subject, level, or teacher',
                  ),
                  const SizedBox(height: 20),

                  // Search bar
                  TextInput(
                    name: "name",
                    labelText: "Search",
                    onChange: _searchByName,
                  ),
                  const SizedBox(height: 20),
                  DropdownButton<String>(
                    value: _nationality,
                    elevation: 16,
                    hint: const Text("Nationality"),
                    onChanged: _searchByNationality,
                    isExpanded: true,
                    items: [
                      "All",
                      "Foreign Tutor",
                      "Vietnamese Tutor",
                      "Native English Tutor"
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 7,
                    runSpacing: 7,
                    children: _specialties
                        .map((e) => GestureDetector(
                              onTap: () {
                                _searchBySpecialties(e);
                              },
                              child: Tag(
                                text: e,
                                selected: _selectedSpecialty == e,
                              ),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 20),

                  // Teacher list
                  Text(
                    'Recommended Tutors',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 10),
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _tutors.isNotEmpty
                          ? ListView.separated(
                              primary: false,
                              shrinkWrap: true,
                              itemBuilder: ((context, index) {
                                return TeacherCard(userData: _tutors[index]);
                              }),
                              separatorBuilder: ((context, index) {
                                return const SizedBox(height: 20);
                              }),
                              itemCount: _tutors.length,
                            )
                          : const Center(
                              child: Text(
                                "Sorry we can't find any tutor with this keywords",
                              ),
                            ),

                  // Footer
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _searchByName(String? keyword) {
    if (_timer?.isActive ?? false) _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _query.search = keyword ?? "";

        updateTutorList();
      });
    });
  }

  void _searchByNationality(String? value) {
    setState(() {
      _nationality = value == "All" ? null : value;

      if (value == "Foreign Tutor") {
        _query.filters?.nationality = {
          "isVietNamese": false,
          "isNative": false
        };
      } else if (value == "Vietnamese Tutor") {
        _query.filters?.nationality = {
          "isVietNamese": true,
        };
      } else if (value == "Native English Tutor") {
        _query.filters?.nationality = {
          "isNative": true,
        };
      } else {
        _query.filters?.nationality = {};
      }
    });

    updateTutorList();
  }

  void _searchBySpecialties(String e) {
    setState(() {
      _query.filters?.specialties =
          e == "All" ? [] : [e.toLowerCase().split(' ').join('-')];
      _selectedSpecialty = e;
    });

    updateTutorList();
  }
}
