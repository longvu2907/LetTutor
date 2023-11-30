import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/models/user.dart';
import 'package:lettutor/widgets/button.dart';
import 'package:lettutor/widgets/rating.dart';
import 'package:lettutor/widgets/tag.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TeacherCard extends StatelessWidget {
  final User userData;

  const TeacherCard({
    super.key,
    required this.userData,
  });

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
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(userData.avatar!),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userData.name!,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  height: 1.4,
                                ),
                      ),
                      Text(
                        '${Country.tryParse(userData.country ?? '')?.flagEmoji ?? ""} ${Country.tryParse(userData.country ?? '')?.name ?? userData.country}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey.shade600,
                            ),
                      ),
                      userData.rating != null
                          ? Rating(
                              rating: userData.rating ?? 0,
                              size: 18,
                            )
                          : const Text(
                              'No reviews yet',
                              style: TextStyle(
                                color: Colors.grey,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                    ],
                  ),
                ],
              ),
              Icon(
                userData.isFavoriteTutor
                    ? MdiIcons.heart
                    : MdiIcons.heartOutline,
                color: Colors.red.shade300,
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Tags
          Align(
            alignment: Alignment.topLeft,
            child: Wrap(
              spacing: 7,
              runSpacing: 7,
              children: userData.specialties.map((e) => Tag(text: e)).toList(),
            ),
          ),
          const SizedBox(height: 15),

          //Description
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              userData.bio ?? '',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                  ),
            ),
          ),

          // Button
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Button(
                text: 'Book',
                onPressed: () => Navigator.pushNamed(
                  context,
                  'teacher-detail',
                  arguments: userData.id,
                ),
                rounded: true,
              ),
            ],
          )
        ],
      ),
    );
  }
}
