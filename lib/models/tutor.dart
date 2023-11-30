import 'package:lettutor/models/user.dart';

class Tutor {
  String? video;
  String? bio;
  String? education;
  String? experience;
  String? profession;
  String? accent;
  String? targetStudent;
  String? interests;
  List<String>? languages;
  List<String>? specialties;
  double? rating;
  bool? isNative;
  bool? isFavorite;
  String? youtubeVideoId;
  double? avgRating;
  int? totalFeedback;
  User? user;

  Tutor({
    this.video,
    this.bio,
    this.education,
    this.experience,
    this.profession,
    this.accent,
    this.targetStudent,
    this.interests,
    this.languages,
    this.specialties = const [],
    this.rating,
    this.isNative,
    this.youtubeVideoId,
    this.avgRating,
    this.totalFeedback,
    this.user,
    this.isFavorite,
  });

  factory Tutor.fromJson(Map<String, dynamic> json) {
    return Tutor(
      video: json['video'],
      bio: json['bio'],
      education: json['education'],
      experience: json['experience'],
      profession: json['profession'],
      accent: json['accent'],
      targetStudent: json['targetStudent'],
      interests: json['interests'],
      languages: json['languages'] != null
          ? json['languages']
              ?.split(',')
              ?.map<String>((e) => e.toString())
              .toList()
          : [],
      specialties: json['specialties'] != null
          ? json['specialties']
              ?.split(',')
              ?.map<String>((e) => e.toString())
              .toList()
          : [],
      rating: json['rating']?.toDouble(),
      isNative: json['isNative'],
      youtubeVideoId: json['youtubeVideoId'],
      avgRating: json['rating']?.toDouble(),
      totalFeedback: json['totalFeedback'],
      user: json['User'] != null ? User.fromJson(json['User']) : null,
      isFavorite: json['isFavorite'],
    );
  }
}
