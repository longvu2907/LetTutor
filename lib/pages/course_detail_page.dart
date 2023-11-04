import 'package:flutter/material.dart';
import 'package:lettutor/widgets/button.dart';
import 'package:lettutor/widgets/custom_app_bar.dart';
import 'package:lettutor/widgets/page_header.dart';

class CourseDetailPage extends StatelessWidget {
  const CourseDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: Image.network(
                        'https://camblycurriculumicons.s3.amazonaws.com/5e0e8b212ac750e7dc9886ac?h=d41d8cd98f00b204e9800998ecf8427e',
                        fit: BoxFit.cover,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Life in the Internet Age',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      subtitle: Text(
                        "Let's discuss how technology is changing the way we live",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey.shade600,
                            ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Button(
                        text: 'Discover',
                        onPressed: () {},
                        isFullWidth: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Button(
                        text: 'Add to suggested courses',
                        onPressed: () {},
                        isFullWidth: true,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),

              // course overview
              Text(
                'Overview',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                'Why take this course',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                'Our world is rapidly changing thanks to new technology, and the vocabulary needed to discuss modern life is evolving almost daily. In this course you will learn the most up-to-date terminology from expertly crafted lessons as well from your native-speaking tutor.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                'What will you be able to do',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                'You will learn vocabulary related to timely topics like remote work, artificial intelligence, online privacy, and more. In addition to discussion questions, you will practice intermediate level speaking tasks such as using data to describe trends.',
                style: Theme.of(context).textTheme.bodySmall,
              ),

              // course level
              Text(
                'Experience Level',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                'Intermediate',
                style: Theme.of(context).textTheme.titleMedium,
              ),

              // course length
              Text(
                'Course Length',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                '9 topics',
                style: Theme.of(context).textTheme.titleMedium,
              ),

              // topics
              Text(
                'List Topics',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              ListView.separated(
                shrinkWrap: true,
                primary: false,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    tileColor: Colors.grey.shade200,
                    title: Text(
                      '$index. The Internet',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
              ),

              // suggested tutors
              Text(
                'Suggested Tutors',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                'Keegan',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
