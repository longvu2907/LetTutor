import "dart:convert";

import "package:http/http.dart";
import "package:lettutor/models/auth.dart";

Future<Auth> login(String email, String password) async {
  var url = Uri.https('sandbox.api.lettutor.com', '/auth/login');

  var response = await post(
    url,
    body: {
      'email': email,
      'password': password,
    },
  );

  if (response.statusCode == 200) {
    return Auth.fromJson(json.decode(response.body));
  } else {
    throw (json.decode(response.body)['message']);
  }
}

Future<Auth> signUp(String? email, String? password) async {
  var url = Uri.https('sandbox.api.lettutor.com', '/auth/register');

  var response = await post(
    url,
    body: {
      'email': email,
      'password': password,
    },
  );

  if (response.statusCode == 201) {
    return Auth.fromJson(json.decode(response.body));
  } else {
    throw (json.decode(response.body)['message']);
  }
}

Future<String> forgotPassword(String email) async {
  var url = Uri.https('sandbox.api.lettutor.com', '/user/forgotPassword');

  var response = await post(
    url,
    body: {
      'email': email,
    },
  );

  if (response.statusCode == 200) {
    return json.decode(response.body)['message'];
  } else {
    throw (json.decode(response.body)['message']);
  }
}
