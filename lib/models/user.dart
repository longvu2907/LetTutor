import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  String id;
  String email;
  String name;
  String avatar;
  String country;
  String phone;
  List<String> roles;
  String? language;
  DateTime birthday;
  bool isActivated;
  String level;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.avatar,
    required this.country,
    required this.phone,
    required this.roles,
    required this.language,
    required this.birthday,
    required this.isActivated,
    required this.level,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        email: json['email'],
        name: json['name'],
        avatar: json['avatar'],
        country: json['country'],
        phone: json['phone'],
        roles: json['roles'].map<String>((role) => role.toString()).toList(),
        language: json['language'],
        birthday: DateTime.parse(json['birthday']),
        isActivated: json['isActivated'],
        level: json['level'],
      );

  void setUser(User? user) {
    if (user != null) {
      id = user.id;
      email = user.email;
      name = user.name;
      avatar = user.avatar;
      country = user.country;
      phone = user.phone;
      roles = user.roles;
      language = user.language;
      birthday = user.birthday;
      isActivated = user.isActivated;
      level = user.level;
    }
    notifyListeners();
  }
}
