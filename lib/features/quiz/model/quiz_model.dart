import 'package:univs/features/login/model/user_model.dart';

class QuizModel {
  int id;
  int userId;
  String title;
  String imageUrl;
  String category;
  DateTime createdAt;
  DateTime updatedAt;
  UserModel user;

  QuizModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.imageUrl,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
        id: json["id"],
        userId: json["userId"],
        title: json["title"],
        imageUrl: json["imageUrl"],
        category: json["category"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        user: UserModel.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "title": title,
        "imageUrl": imageUrl,
        "category": category,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "user": user.toJson(),
      };
}
