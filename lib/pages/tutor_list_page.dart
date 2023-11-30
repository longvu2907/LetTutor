import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lettutor/models/auth.dart';
import 'package:lettutor/models/tutor.dart';
import 'package:lettutor/models/user.dart';
import 'package:lettutor/services/tutor.dart';
import 'package:lettutor/widgets/page_header.dart';
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

  @override
  void initState() {
    super.initState();

    updateTutorList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
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
                    : ListView.separated(
                        primary: false,
                        shrinkWrap: true,
                        itemBuilder: ((context, index) {
                          return TeacherCard(userData: _tutors[index]);
                        }),
                        separatorBuilder: ((context, index) {
                          return const SizedBox(height: 20);
                        }),
                        itemCount: _tutors.length,
                      ),

                // Footer
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
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
