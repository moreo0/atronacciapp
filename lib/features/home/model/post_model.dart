import 'package:univs/features/login/model/user_model.dart';

class PostModel {
  int id;
  int userId;
  String description;
  String? attachment;
  DateTime createdAt;
  DateTime updatedAt;
  UserModel user;
  List<Comment> comments;

  PostModel({
    required this.id,
    required this.userId,
    required this.description,
    required this.attachment,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.comments,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json["id"],
        userId: json["userId"],
        description: json["description"],
        attachment: json["attachment"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        user: UserModel.fromJson(json["user"]),
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "description": description,
        "attachment": attachment,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "user": user.toJson(),
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
      };
}

class Comment {
  int id;
  String description;
  UserModel user;
  DateTime createdAt;
  DateTime updatedAt;

  Comment({
    required this.id,
    required this.description,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        description: json["description"],
        user: UserModel.fromJson(json["user"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "user": user.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
