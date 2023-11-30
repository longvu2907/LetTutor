import 'package:flutter/material.dart';
import 'package:lettutor/models/auth.dart';
import 'package:lettutor/models/review.dart';
import 'package:lettutor/models/tutor.dart';
import 'package:lettutor/services/tutor.dart';
import 'package:lettutor/widgets/custom_app_bar.dart';
import 'package:lettutor/widgets/rating.dart';
import 'package:lettutor/widgets/review.dart';
import 'package:lettutor/widgets/table_event.dart';
import 'package:lettutor/widgets/tag.dart';
import 'package:lettutor/widgets/video.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class TeacherDetailPage extends StatefulWidget {
  final String tutorId;

  const TeacherDetailPage({
    super.key,
    required this.tutorId,
  });

  @override
  State<TeacherDetailPage> createState() => _TeacherDetailPageState();
}

class _TeacherDetailPageState extends State<TeacherDetailPage> {
  Tutor? tutorData;
  List<ReviewModel> feedbacks = [];

  void updateTutor() {
    getTutor(
      accessToken: context.read<Auth>().accessToken.toString(),
      tutorId: widget.tutorId,
    ).then(
      (value) {
        setState(() {
          tutorData = value;
        });
      },
    ).catchError((error) {
      print(error);
    });
  }

  void updateReview() {
    getReviews(
      accessToken: context.read<Auth>().accessToken.toString(),
      tutorId: widget.tutorId,
    ).then(
      (value) {
        setState(() {
          feedbacks = value;
        });
      },
    ).catchError((error) {
      print(error);
    });
  }

  void toggleFavorite() {
    manageFavoriteTutor(
      tutorId: widget.tutorId,
      accessToken: context.read<Auth>().accessToken.toString(),
    );
    updateTutor();
  }

  @override
  void initState() {
    super.initState();

    updateTutor();
    updateReview();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Teacher info
            Wrap(
              spacing: 15,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(tutorData?.user?.avatar ?? ''),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tutorData?.user?.name ?? '',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            height: 1.4,
                          ),
                    ),
                    Text(
                      tutorData?.user?.country ?? '',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                    ),
                    Rating(
                      rating: tutorData?.rating ?? 0,
                      size: 18,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              tutorData?.bio ?? '',
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
                      onPressed: toggleFavorite,
                      icon: Icon(
                        tutorData?.isFavorite == true
                            ? MdiIcons.heart
                            : MdiIcons.heartOutline,
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
            Video(
              url: tutorData?.video ?? '',
              height: 200,
            ),
            const SizedBox(height: 25),

            // Education
            Text(
              'Education',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              tutorData?.education ?? '',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 10),

            // Languages
            Text(
              'Languages',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Wrap(
              spacing: 7,
              runSpacing: 7,
              children: tutorData?.languages
                      ?.map((e) => Tag(text: e.toUpperCase()))
                      .toList() ??
                  const [],
            ),
            const SizedBox(height: 10),

            // Specialties
            Text(
              'Specialties',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Wrap(
              spacing: 7,
              runSpacing: 7,
              children: tutorData?.specialties
                      ?.map((e) => Tag(text: e.toUpperCase()))
                      .toList() ??
                  const [],
            ),
            const SizedBox(height: 10),

            // Interests
            Text(
              'Interests',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              tutorData?.interests ?? '',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 10),

            // Experience
            Text(
              'Teaching experience',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              tutorData?.experience ?? '',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 20),

            // Schedule
            Text(
              'Schedule',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            ScheduleTable(
              tutorId: widget.tutorId,
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
              itemCount: feedbacks.length,
              itemBuilder: (context, index) {
                return Review(
                  name: feedbacks[index].name,
                  content: feedbacks[index].content,
                  rating: feedbacks[index].rating,
                  avatarUrl: feedbacks[index].avatar,
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
