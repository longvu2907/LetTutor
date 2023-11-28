import 'package:flutter/material.dart';
import 'package:lettutor/models/user.dart';

class Auth extends ChangeNotifier {
  User? user;
  String? accessToken;
  String? refreshToken;

  Auth({this.user, this.accessToken, this.refreshToken});

  factory Auth.fromJson(Map<String, dynamic> json) {
    print(User.fromJson(json['user']));

    return Auth(
      user: null,
      accessToken: json['tokens']['access']['token'],
      refreshToken: json['tokens']['refresh']['token'],
    );
  }

  void setAuth(Auth? auth) {
    user = auth?.user;
    accessToken = auth?.accessToken;
    refreshToken = auth?.refreshToken;
    notifyListeners();
  }

  void setToken(String? token) {
    token = token;
    notifyListeners();
  }

  void setRefreshToken(String? refreshToken) {
    refreshToken = refreshToken;
    notifyListeners();
  }

  void setUser(User? user) {
    user = user;
    notifyListeners();
  }
}
