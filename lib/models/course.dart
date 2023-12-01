final Map<String, String> levelMap = {
  "0": "Any Level",
  "1": "Beginner",
  "4": "Intermediate",
  "7": "Advanced",
};

class TopicModel {
  String id;
  String name;
  String nameFile;
  int orderCourse;

  TopicModel({
    required this.id,
    required this.name,
    required this.nameFile,
    required this.orderCourse,
  });

  factory TopicModel.fromJson(Map<String, dynamic> json) {
    return TopicModel(
      id: json['id'],
      name: json['name'],
      nameFile: json['nameFile'],
      orderCourse: json['orderCourse'],
    );
  }
}

class CourseModel {
  String id;
  String name;
  String level;
  String image;
  String description;
  String? reason;
  String? purpose;
  List<String> categories;
  List<TopicModel> topics;

  CourseModel({
    required this.id,
    required this.name,
    required this.level,
    required this.image,
    required this.description,
    required this.categories,
    this.reason,
    this.purpose,
    this.topics = const [],
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'],
      name: json['name'],
      level: levelMap[json['level']] ?? "Any Level",
      image: json['imageUrl'],
      description: json['description'],
      categories: json['categories'] != null
          ? (json['categories'] as List)
              .map((e) => e['title'] as String)
              .toList()
          : [],
      reason: json['reason'],
      purpose: json['purpose'],
      topics:
          (json['topics'] as List).map((e) => TopicModel.fromJson(e)).toList(),
    );
  }
}
