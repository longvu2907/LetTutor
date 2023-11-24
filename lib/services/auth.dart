import "dart:convert";

import "package:http/http.dart";
import "package:lettutor/models/user.dart";

Future<User> login(String email, String password) async {
  var url = Uri.https('sandbox.api.lettutor.com', '/auth/login');

  var response = await post(
    url,
    body: {
      'email': email,
      'password': password,
    },
  );

  if (response.statusCode == 200) {
    return User.fromJson(json.decode(response.body)['user']);
  } else {
    throw Exception(json.decode(response.body)['message']);
  }
}
