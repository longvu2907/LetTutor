import 'package:flutter/material.dart';
import 'package:lettutor/widgets/custom_app_bar.dart';
import 'package:lettutor/widgets/rating.dart';
import 'package:lettutor/widgets/review.dart';
import 'package:lettutor/widgets/tag.dart';
import 'package:lettutor/widgets/video.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TeacherDetailPage extends StatelessWidget {
  const TeacherDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Teacher info
            Wrap(
              spacing: 15,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/teacher.jpg'),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Teacher Name',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            height: 1.4,
                          ),
                    ),
                    Text(
                      'Nationality',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                    ),
                    const Rating(
                      rating: 4.5,
                      size: 18,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              "Hi, My name is Jill I am an experienced English Teacher from Philippine. I would like to share my enthusiasm with the learners in this platform. I've been working with diverse learners of all levels for many years. I am greatly passionate about about profession. I love teaching because I can help others improve their skills and it gives me joy and excitement meeting different learners around the world. In my class I worked with wonderful enthusiasm and positivity, and I'm happy to focus on my learner's goal.",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 10),

            // Favorite and report button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        MdiIcons.heart,
                        size: 28,
                        color: Colors.red.shade300,
                      ),
                    ),
                    Text(
                      'Favorite',
                      style: TextStyle(
                        fontSize: 12,
                        height: 0.4,
                        color: Colors.red.shade300,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.report_problem_outlined,
                        size: 28,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Text('Report',
                        style: TextStyle(
                          fontSize: 12,
                          height: 0.4,
                          color: Theme.of(context).primaryColor,
                        ))
                  ],
                ),
              ],
            ),
            const SizedBox(height: 25),

            // Video
            const Video(
              url:
                  'https://api.app.lettutor.com/video/4d54d3d7-d2a9-42e5-97a2-5ed38af5789avideo1627913015871.mp4',
              height: 200,
            ),

            // Education
            Text(
              'Education',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Certified at English education',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 10),

            // Languages
            Text(
              'Languages',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                Tag(text: 'English'),
              ],
            ),
            const SizedBox(height: 10),

            // Specialties
            Text(
              'Specialties',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                Tag(text: 'English for Business'),
                Tag(text: 'English for kids'),
                Tag(text: 'TOEFL'),
                Tag(text: 'TOEIC'),
              ],
            ),
            const SizedBox(height: 10),

            // Interests
            Text(
              'Interests',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'English, Japanese, Korean, Chinese',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 10),

            // Experience
            Text(
              'Teaching experience',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '5 years in education',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 20),

            // Others review
            Text(
              'Others review',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            ListView.separated(
              primary: false,
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return const Review(
                  name: 'name',
                  content:
                      ' 123 21 321 312 312 312 312 312 3213 21 312 312 321 312 321 312 312 ',
                  rating: 4.5,
                  avatarUrl:
                      'https://sandbox.api.lettutor.com/avatar/cb9e7deb-3382-48db-b07c-90acf52f541cavatar1686550060378.jpg',
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: Colors.grey.shade300,
                  thickness: 1,
                );
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
