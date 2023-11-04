import 'package:flutter/material.dart';
import 'package:lettutor/widgets/button.dart';
import 'package:lettutor/widgets/rating.dart';
import 'package:lettutor/widgets/tag.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TeacherCard extends StatelessWidget {
  const TeacherCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
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
              Icon(
                MdiIcons.heart,
                color: Colors.red.shade300,
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Tags
          const Wrap(
            spacing: 7,
            runSpacing: 7,
            children: [
              Tag(text: 'IELTS'),
              Tag(text: 'TOEFL'),
              Tag(text: 'TOEIC'),
              Tag(text: 'TOEIC'),
              Tag(text: 'TOEIC'),
              Tag(text: 'TOEIC'),
              Tag(text: 'TOEIC'),
            ],
          ),
          const SizedBox(height: 15),

          //Description
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vitae nisl eget nunc aliquam aliquet. Sed vitae nisl eget nunc aliquam aliquet.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade600,
                ),
          ),

          // Button
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Button(
                text: 'Đặt lịch',
                onPressed: () => Navigator.pushNamed(context, 'teacher-detail'),
                rounded: true,
              ),
            ],
          )
        ],
      ),
    );
  }
}
