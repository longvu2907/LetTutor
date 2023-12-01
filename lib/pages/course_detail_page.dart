import 'package:flutter/material.dart';
import 'package:lettutor/models/auth.dart';
import 'package:lettutor/models/course.dart';
import 'package:lettutor/services/course.dart';
import 'package:lettutor/widgets/button.dart';
import 'package:lettutor/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

class CourseDetailPage extends StatefulWidget {
  final String courseId;

  const CourseDetailPage({
    super.key,
    required this.courseId,
  });

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  CourseModel? _courseData;

  void getCourseData() async {
    var res = await getCourse(
      accessToken: context.read<Auth>().accessToken.toString(),
      courseId: widget.courseId,
    );

    setState(() {
      _courseData = res;
    });
  }

  @override
  void initState() {
    super.initState();

    getCourseData();
  }

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
                        _courseData?.image ?? "",
                        fit: BoxFit.cover,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        _courseData?.name ?? "",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      subtitle: Text(
                        _courseData?.description ?? "",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey.shade600,
                            ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Button(
                        text: 'Discover',
                        onPressed: () {
                          Navigator.pushNamed(context, 'lesson-detail');
                        },
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
              const SizedBox(height: 20),
              Text(
                'Overview',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                'Why take this course',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Text(
                _courseData?.reason ?? "",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                'What will you be able to do',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Text(
                _courseData?.purpose ?? "",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 20),

              // course level
              Text(
                'Experience Level',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                _courseData?.level ?? "",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 20),

              // course length
              Text(
                'Course Length',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                '${_courseData?.topics.length ?? 0} topics',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 20),

              // topics
              Text(
                'List Topics',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              ListView.separated(
                shrinkWrap: true,
                primary: false,
                itemCount: _courseData?.topics.length ?? 0,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, 'lesson-detail');
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    tileColor: Colors.grey.shade200,
                    title: Text(
                      '${_courseData?.topics[index].orderCourse}. ${_courseData?.topics[index].name}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
              ),
              const SizedBox(height: 20),

              // suggested tutors
              Text(
                'Suggested Tutors',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                'Keegan',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
