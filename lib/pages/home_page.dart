import 'package:flutter/material.dart';
import 'package:lettutor/widgets/custom_app_bar.dart';
import 'package:lettutor/widgets/teacher_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView.separated(
            itemBuilder: ((context, index) {
              return TeacherCard();
            }),
            separatorBuilder: ((context, index) {
              return const SizedBox(height: 20);
            }),
            itemCount: 10),
      ),
    );
  }
}
