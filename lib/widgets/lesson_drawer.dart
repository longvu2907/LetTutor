import 'package:flutter/material.dart';

class LessonDrawer extends StatelessWidget {
  final List<String> topicList;

  const LessonDrawer({
    super.key,
    required this.topicList,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 200,
            child: Image.network(
              'https://camblycurriculumicons.s3.amazonaws.com/5e0e8b212ac750e7dc9886ac?h=d41d8cd98f00b204e9800998ecf8427e',
              fit: BoxFit.cover,
            ),
          ),
          ListTile(
            title: Text(
              'Life in the Internet Age',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            subtitle: Text(
              "Let's discuss how technology is changing the way we live",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                  ),
            ),
          ),

          // topics
          const SizedBox(height: 20),
          Text(
            'List Topics',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          ListView.separated(
            shrinkWrap: true,
            primary: false,
            padding: const EdgeInsets.only(bottom: 20),
            itemCount: topicList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListTile(
                  textColor: index == 0 ? Colors.white : Colors.black,
                  tileColor: index == 0
                      ? Theme.of(context).colorScheme.primary
                      : Colors.black12,
                  title: Text(
                    '${index + 1}. ${topicList[index]}',
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
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
        ],
      ),
    );
  }
}
