import 'package:flutter/material.dart';
import 'package:lettutor/widgets/bottom_navigation.dart';
import 'package:lettutor/widgets/custom_app_bar.dart';
import 'package:lettutor/widgets/tag.dart';
import 'package:lettutor/widgets/teacher_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showLogoutButton: true,
      ),
      bottomNavigationBar: const BottomNavigation(
        currentIndex: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tìm kiếm gia sư',
                    style: Theme.of(context).textTheme.titleLarge,
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
                    'Gia sư được đề xuất',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 10),
                  ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    itemBuilder: ((context, index) {
                      return const TeacherCard();
                    }),
                    separatorBuilder: ((context, index) {
                      return const SizedBox(height: 20);
                    }),
                    itemCount: 5,
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
}
