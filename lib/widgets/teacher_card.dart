import 'package:flutter/material.dart';
import 'package:lettutor/widgets/rating.dart';

class TeacherCard extends StatelessWidget {
  const TeacherCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 200,
      padding: const EdgeInsets.all(10),
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
          Row(children: [
            Container(
              margin: EdgeInsets.only(right: 10),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/teacher.jpg'),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Teacher Name'),
                Text('Teacher Description'),
                Rating(rating: 4.5),
              ],
            ),
          ]),
        ],
      ),
    );
  }
}
