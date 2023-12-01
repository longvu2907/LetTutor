import 'package:intl/intl.dart';

class FeedbackModel {
  final String id;
  final double rating;

  FeedbackModel({
    required this.id,
    required this.rating,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      id: json['id'],
      rating: json['rating']?.toDouble() ?? 0.0,
    );
  }
}

class TutorInfo {
  final String id;
  final String name;
  final String country;
  final String avatar;

  const TutorInfo({
    required this.id,
    required this.name,
    required this.country,
    required this.avatar,
  });

  factory TutorInfo.fromJson(Map<String, dynamic> json) {
    return TutorInfo(
      id: json['id'],
      name: json['name'],
      country: json['country'],
      avatar: json['avatar'],
    );
  }
}

class ScheduleEvent {
  final String id;
  final DateTime start;
  final DateTime end;
  final bool isBooked;
  final TutorInfo? tutor;
  final List<FeedbackModel> feedbacks;
  final String? studentRequest;

  const ScheduleEvent({
    required this.id,
    required this.start,
    required this.end,
    required this.isBooked,
    this.tutor,
    this.feedbacks = const [],
    this.studentRequest,
  });

  factory ScheduleEvent.fromJson(Map<String, dynamic> json) {
    int startTimestamp = json['startTimestamp'] ??
        json['scheduleDetailInfo']['startPeriodTimestamp'];
    int endTimestamp = json['endTimestamp'] ??
        json['scheduleDetailInfo']['endPeriodTimestamp'];

    return ScheduleEvent(
      id: json['scheduleDetailId'] ?? json['scheduleDetails'][0]['id'],
      start: DateTime.fromMillisecondsSinceEpoch(startTimestamp),
      end: DateTime.fromMillisecondsSinceEpoch(endTimestamp),
      isBooked: json['isBooked'] ?? false,
      tutor: json["scheduleDetailInfo"]?["scheduleInfo"]?["tutorInfo"] != null
          ? TutorInfo.fromJson(
              json["scheduleDetailInfo"]["scheduleInfo"]["tutorInfo"])
          : null,
      feedbacks: json['feedbacks'] != null
          ? json['feedbacks']
              .map<FeedbackModel>((e) => FeedbackModel.fromJson(e))
              .toList()
          : [],
      studentRequest: json['studentRequest'],
    );
  }

  @override
  String toString() =>
      "${DateFormat('HH:mm').format(start)} - ${DateFormat('HH:mm').format(end)}";
}
