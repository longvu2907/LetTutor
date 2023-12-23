import 'package:flutter/material.dart';
import 'package:lettutor/models/auth.dart';
import 'package:lettutor/models/course.dart';
import 'package:lettutor/services/course.dart';
import 'package:lettutor/widgets/course_card.dart';
import 'package:lettutor/widgets/page_header.dart';
import 'package:provider/provider.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late int _activeIndex = 0;
  List<CourseModel> _courses = [];

  void getCourseList() async {
    var res = await getCourses(
      accessToken: context.read<Auth>().accessToken.toString(),
    );

    setState(() {
      _courses = res;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _activeIndex = _tabController.index;
      });
    });
    getCourseList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            // discover course header
            const PageHeader(
              title: 'Discover Courses',
              subtitle:
                  'Discover the courses that are right for you\nYou can search for courses by subject, level, or teacher',
            ),
            const SizedBox(height: 20),

            TabBar(
              isScrollable: true,
              controller: _tabController,
              tabAlignment: TabAlignment.start,
              onTap: (index) => setState(() {}),
              tabs: const [
                Tab(
                  text: 'Course',
                ),
                Tab(
                  text: 'E-Book',
                ),
                Tab(
                  text: 'Interactive E-Book',
                ),
              ],
            ),
            const SizedBox(height: 20),

            _buildTabView(_activeIndex),
          ],
        ),
      ),
    );
  }

  Widget _buildTabView(index) {
    switch (index) {
      case 0:
        return _courseTab();
      case 1:
        return _bookTab();
      case 2:
        return _interactiveBookTab();
      default:
        return _courseTab();
    }
  }

  Widget _courseTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // discover course list
        // English for traveling
        Text(
          'English For Traveling',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(
          height: 350,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              return CourseCard(
                courseData: _courses
                    .where((element) =>
                        element.categories.contains("English for Traveling"))
                    .toList()[index],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 20);
            },
            itemCount: _courses
                .where((element) =>
                    element.categories.contains("English for Traveling"))
                .length,
          ),
        ),
        const SizedBox(height: 30),

        // english for beginners
        Text(
          'English For Beginners',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(
          height: 350,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              return CourseCard(
                courseData: _courses
                    .where((element) =>
                        element.categories.contains("English for Beginners"))
                    .toList()[index],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 20);
            },
            itemCount: _courses
                .where((element) =>
                    element.categories.contains("English for Beginners"))
                .length,
          ),
        ),
        const SizedBox(height: 30),

        // Business english
        Text(
          'Business English',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(
          height: 350,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              return CourseCard(
                courseData: _courses
                    .where((element) =>
                        element.categories.contains("Business English"))
                    .toList()[index],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 20);
            },
            itemCount: _courses
                .where((element) =>
                    element.categories.contains("Business English"))
                .length,
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _bookTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // discover course list
        // English for traveling
        Text(
          'Books',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(
          height: 350,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              return Container();
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 20);
            },
            itemCount: 5,
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _interactiveBookTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // discover course list
        // English for traveling
        Text(
          'Books',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(
          height: 350,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              return Container();
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 20);
            },
            itemCount: 5,
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
