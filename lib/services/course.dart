import 'dart:convert';

import 'package:http/http.dart';
import 'package:lettutor/config/env_config.dart';
import 'package:lettutor/models/course.dart';

Future<List<CourseModel>> getCourses({required String accessToken}) async {
  var url = Uri.https(EnvConfig.baseUrl, '/course', {
    "page": "1",
    "size": "100",
  });

  var response = await get(
    url,
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    },
  );

  if (response.statusCode == 200) {
    return json
        .decode(response.body)['data']['rows']
        .map<CourseModel>((e) => CourseModel.fromJson(e))
        .toList();
  } else {
    throw (json.decode(response.body)['message']);
  }
}

Future<CourseModel> getCourse(
    {required String accessToken, required String courseId}) async {
  var url = Uri.https(EnvConfig.baseUrl, '/course/$courseId');

  var response = await get(
    url,
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    },
  );

  if (response.statusCode == 200) {
    return CourseModel.fromJson(json.decode(response.body)['data']);
  } else {
    throw (json.decode(response.body)['message']);
  }
}
