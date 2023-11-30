class ReviewModel {
  final String id;
  final String bookingId;
  final String firstId;
  final String secondId;
  final double rating;
  final String content;
  final String name;
  final String avatar;
  final String createdAt;
  final String updatedAt;

  ReviewModel({
    required this.id,
    required this.bookingId,
    required this.firstId,
    required this.secondId,
    required this.rating,
    required this.content,
    required this.name,
    required this.avatar,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      bookingId: json['bookingId'],
      firstId: json['firstId'],
      secondId: json['secondId'],
      rating: json['rating']?.toDouble(),
      content: json['content'],
      name: json['firstInfo']['name'],
      avatar: json['firstInfo']['avatar'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
