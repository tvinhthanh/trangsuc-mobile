class BlogModel {
  final String id;
  final String title;
  final String image;
  final DateTime date;

  BlogModel({
    required this.id,
    required this.title,
    required this.image,
    required this.date,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'] as String,
      title: json['title'] as String,
      image: json['image'] as String,
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'date': date.toIso8601String(),
    };
  }
}
