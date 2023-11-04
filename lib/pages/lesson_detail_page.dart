import 'package:flutter/material.dart';
import 'package:lettutor/widgets/custom_app_bar.dart';
import 'package:lettutor/widgets/lesson_drawer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class LessonDetailPage extends StatefulWidget {
  const LessonDetailPage({super.key});

  @override
  State<LessonDetailPage> createState() => _LessonDetailPageState();
}

class _LessonDetailPageState extends State<LessonDetailPage> {
  final List<String> topicList = [
    'Foods You Love',
    'Your jobs',
    'Playing And Watching Sports',
    'The Best Pet',
    'Having Fun in Your Free Time',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackButton: true,
      ),
      endDrawer: Drawer(
        child: LessonDrawer(
          topicList: topicList,
        ),
      ),
      body: SfPdfViewer.network(
        'https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileFoods%20You%20Love.pdf',
      ),
    );
  }
}
