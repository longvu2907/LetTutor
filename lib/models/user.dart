class User {
  String? id;
  String? email;
  String? name;
  String? avatar;
  String? phone;
  String? country;
  List<String>? roles;
  String? language;
  DateTime? birthday;
  bool? isActivated;
  String? level;
  double? rating;
  String? bio;
  List<String> specialties;

  User({
    this.id,
    this.email,
    this.name,
    this.avatar,
    this.phone,
    this.country,
    this.roles,
    this.language,
    this.birthday,
    this.isActivated,
    this.level,
    this.rating,
    this.bio,
    this.specialties = const [],
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      avatar: json['avatar'],
      phone: json['phone'],
      country: json['country'],
      roles: json['roles']?.map<String>((role) => role.toString()).toList(),
      language: json['language'],
      birthday:
          json['birthday'] != null ? DateTime.parse(json['birthday']) : null,
      level: json['level'],
      isActivated: json['isActivated'],
      rating: json['rating'],
      bio: json['bio'],
      specialties: json['specialties'] != null
          ? json['specialties']
              ?.split(',')
              ?.map<String>((e) => e.toString())
              .toList()
          : [],
    );
  }
}
