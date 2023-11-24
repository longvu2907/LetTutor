class User {
  final String id;
  final String email;
  final String name;
  final String avatar;
  final String country;
  final String phone;
  final List<String> roles;
  final String? language;
  final DateTime birthday;
  final bool isActivated;
  final String level;

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
}
