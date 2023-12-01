import 'package:flutter/material.dart';
import 'package:lettutor/widgets/rating.dart';
import 'package:timeago/timeago.dart' as timeago;

class Review extends StatelessWidget {
  final String name;
  final String content;
  final double rating;
  final DateTime? date;
  final String avatarUrl;

  const Review({
    super.key,
    required this.name,
    required this.content,
    required this.rating,
    required this.avatarUrl,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          child: CircleAvatar(
            radius: 20,
            backgroundImage: Image.network(avatarUrl).image,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 10,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                  ),
                  Text(
                    timeago.format(date ?? DateTime.now()),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                  ),
                ],
              ),
              Rating(rating: rating, size: 18),
              Text(content),
            ],
          ),
        )
      ],
    );
  }
}
