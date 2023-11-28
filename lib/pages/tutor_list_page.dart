import 'package:flutter/material.dart';
import 'package:lettutor/models/auth.dart';
import 'package:lettutor/models/user.dart';
import 'package:lettutor/services/tutor.dart';
import 'package:lettutor/widgets/page_header.dart';
import 'package:lettutor/widgets/tag.dart';
import 'package:lettutor/widgets/teacher_card.dart';
import 'package:provider/provider.dart';

class TutorListPage extends StatefulWidget {
  const TutorListPage({super.key});

  @override
  State<TutorListPage> createState() => _TutorListPageState();
}

class _TutorListPageState extends State<TutorListPage> {
  List<User> _tutors = [];

  @override
  void initState() {
    getTutor(accessToken: context.read<Auth>().accessToken.toString()).then(
      (value) => setState(() {
        print(value.length);
        _tutors = value;
      }),
    );

    super.initState();
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
                const SizedBox(height: 10),
                // Search bar
                const Wrap(
                  spacing: 7,
                  runSpacing: 7,
                  children: [
                    Tag(text: 'IELTS'),
                    Tag(text: 'TOEFL', selected: false),
                    Tag(text: 'TOEFL', selected: false),
                    Tag(text: 'TOEFL', selected: false),
                    Tag(text: 'TOEFL', selected: false),
                    Tag(text: 'TOEFL', selected: false),
                  ],
                ),
                const SizedBox(height: 20),

                // Teacher list
                Text(
                  'Recommended Tutors',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                ListView.separated(
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
}
