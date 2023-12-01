import 'package:flutter/material.dart';
import 'package:lettutor/models/course.dart';

class CourseCard extends StatelessWidget {
  final CourseModel courseData;

  const CourseCard({
    super.key,
    required this.courseData,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 150,
                  child: Image.network(
                    courseData.image,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: ListTile(
                    title: Text(
                      courseData.name,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    subtitle: Text(
                      courseData.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      courseData.level,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Text(
                      '${courseData.topics.length} Lessons',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                )
              ],
            ),
            ButtonBar(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      'course-detail',
                      arguments: courseData.id,
                    );
                  },
                  child: const Text('View'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Enroll'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
