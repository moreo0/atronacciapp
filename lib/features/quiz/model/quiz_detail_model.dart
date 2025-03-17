class QuizDetailModel {
  int id;
  int userId;
  String title;
  String? imageUrl;
  String category;
  DateTime createdAt;
  DateTime updatedAt;
  List<ExamDetail> examDetails;
  User user;

  QuizDetailModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.imageUrl,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
    required this.examDetails,
    required this.user,
  });

  factory QuizDetailModel.fromJson(Map<String, dynamic> json) =>
      QuizDetailModel(
        id: json["id"],
        userId: json["userId"],
        title: json["title"],
        imageUrl: json["imageUrl"],
        category: json["category"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        examDetails: List<ExamDetail>.from(
            json["examDetails"].map((x) => ExamDetail.fromJson(x))),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "title": title,
        "imageUrl": imageUrl,
        "category": category,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "examDetails": List<dynamic>.from(examDetails.map((x) => x.toJson())),
        "user": user.toJson(),
      };
}

class ExamDetail {
  int id;
  int examId;
  String question;
  String option1;
  String option2;
  String option3;
  String option4;
  String option5;
  String key;
  DateTime createdAt;
  DateTime updatedAt;

  ExamDetail({
    required this.id,
    required this.examId,
    required this.question,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
    required this.option5,
    required this.key,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ExamDetail.fromJson(Map<String, dynamic> json) => ExamDetail(
        id: json["id"],
        examId: json["examId"],
        question: json["question"],
        option1: json["option1"],
        option2: json["option2"],
        option3: json["option3"],
        option4: json["option4"],
        option5: json["option5"],
        key: json["key"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "examId": examId,
        "question": question,
        "option1": option1,
        "option2": option2,
        "option3": option3,
        "option4": option4,
        "option5": option5,
        "key": key,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class User {
  String name;
  String username;
  String? image;
  String? university;

  User({
    required this.name,
    required this.username,
    required this.image,
    required this.university,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        username: json["username"],
        image: json["image"],
        university: json["university"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "username": username,
        "image": image,
        "university": university,
      };
}
