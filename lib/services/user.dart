import 'dart:convert';

import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
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
  var url = Uri.https('sandbox.api.lettutor.com', '/user/info');

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
  var url = Uri.https('sandbox.api.lettutor.com', '/user/uploadAvatar');

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
