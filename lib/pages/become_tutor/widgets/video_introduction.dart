import 'package:flutter/material.dart';
import 'package:lettutor/widgets/page_header.dart';

class VideoIntroduction extends StatefulWidget {
  const VideoIntroduction({super.key});

  @override
  State<VideoIntroduction> createState() => _VideoIntroductionState();
}

class _VideoIntroductionState extends State<VideoIntroduction> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          PageHeader(
            title: 'Set up your tutor profile',
            subtitle:
                """Your tutor profile is your chance to market yourself to students on Tutoring. You can make edits later on your profile settings page.\nNew students may browse tutor profiles to find a tutor that fits their learning goals and personality. Returning students may use the tutor profiles to find tutors they've had great experiences with already.""",
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
