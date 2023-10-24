import 'package:flutter/material.dart';
import 'package:lettutor/widgets/button.dart';
import 'package:lettutor/widgets/rating.dart';

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
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
                onPressed: () => print('Book'),
                rounded: true,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Tag extends StatelessWidget {
  final String text;

  const Tag({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(.1),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).primaryColor,
            ),
      ),
    );
  }
}
