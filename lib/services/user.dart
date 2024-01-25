import 'dart:convert';

import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/config/env_config.dart';
import 'package:lettutor/models/user.dart';

class UpdateProfileRequest {
  String name;
  String country;
  String phone;
  late String birthDate;

  UpdateProfileRequest({
    required this.name,
    required this.country,
    required this.phone,
    required DateTime birthDate,
  }) {
    this.birthDate = DateFormat("yyyy-MM-dd").format(birthDate);
  }
}

Future<User> updateProfile({
  required String accessToken,
  required UpdateProfileRequest data,
}) async {
  var url = Uri.https(EnvConfig.baseUrl, '/user/info');

  var response = await put(
    url,
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    },
    body: jsonEncode({
      'name': data.name,
      'country': data.country,
      'phone': data.phone,
      'birthday': data.birthDate,
    }),
  );

  if (response.statusCode == 200) {
    return User.fromJson(json.decode(response.body));
  } else {
    throw (json.decode(response.body)['message']);
  }
}

Future<User> updateAvatar({
  required String accessToken,
  required XFile avatar,
}) async {
  var url = Uri.https(EnvConfig.baseUrl, '/user/uploadAvatar');

  var request = MultipartRequest("POST", url);
  request.headers.addAll({
    "Content-Type": "multipart/form-data",
    "Authorization": "Bearer $accessToken",
  });
  request.files.add(await MultipartFile.fromPath(
    'avatar',
    avatar.path,
  ));

  var streamedResponse = await request.send();
  var response = await Response.fromStream(streamedResponse);

  if (response.statusCode == 200) {
    return User.fromJson(json.decode(response.body));
  } else {
    throw (json.decode(response.body)['message']);
  }
}

class BecomeTutorRequest {
  final String name;
  final String country;
  late String birthday;
  final String interests;
  final String education;
  final String experience;
  final String profession;
  final String languages;
  final String bio;
  final String targetStudent;
  final String specialties;
  final int price;
  final XFile? avatar;
  final XFile? video;

  BecomeTutorRequest({
    required this.name,
    required this.country,
    required DateTime birthday,
    required this.interests,
    required this.education,
    required this.experience,
    required this.profession,
    required this.languages,
    required this.bio,
    required this.targetStudent,
    required this.specialties,
    required this.price,
    this.avatar,
    this.video,
  }) {
    this.birthday = DateFormat("yyyy-MM-dd").format(birthday);
  }
}

Future<User> becomeTutor({
  required String accessToken,
  required BecomeTutorRequest data,
}) async {
  var url = Uri.https(EnvConfig.baseUrl, '/tutor/register');

  var request = MultipartRequest("PUT", url);
  request.headers.addAll({
    "Content-Type": "multipart/form-data",
    "Authorization": "Bearer $accessToken",
  });
  request.fields.addAll({
    'name': data.name,
    'country': data.country,
    'birthday': data.birthday,
    'interests': data.interests,
    'education': data.education,
    'experience': data.experience,
    'profession': data.profession,
    'languages': data.languages,
    'bio': data.bio,
    'targetStudent': data.targetStudent,
    'specialties': data.specialties,
    'price': data.price.toString(),
  });
  if (data.avatar != null) {
    request.files.add(await MultipartFile.fromPath(
      'avatar',
      data.avatar!.path,
    ));
  }
  if (data.video != null) {
    request.files.add(await MultipartFile.fromPath(
      'video',
      data.video!.path,
    ));
  }

  var streamedResponse = await request.send();
  var response = await Response.fromStream(streamedResponse);

  if (response.statusCode == 200) {
    return User.fromJson(json.decode(response.body));
  } else {
    throw (json.decode(response.body)['message']);
  }
}
