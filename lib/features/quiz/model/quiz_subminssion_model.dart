class QuizSubmission {
  final int? id;
  final int? userId;
  final int? examId;
  final double? score;
  final int? correct;
  final int? wrong;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final User? user;
  final Exam? exam;

  QuizSubmission({
    required this.id,
    required this.userId,
    required this.examId,
    required this.score,
    required this.correct,
    required this.wrong,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.exam,
  });

  factory QuizSubmission.fromJson(Map<String, dynamic> json) {
    return QuizSubmission(
      id: json['id'],
      userId: json['userId'],
      examId: json['examId'],
      score: json['score'].toDouble(),
      correct: json['correct'],
      wrong: json['wrong'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      user: User.fromJson(json['user']),
      exam: Exam.fromJson(json['exam']),
    );
  }

  toJson() {}
}

class User {
  final String name;
  final String username;
  final String? profileImage;
  final String? university;

  User({
    required this.name,
    required this.username,
    required this.profileImage,
    required this.university,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      username: json['username'],
      profileImage: json['profileImage'],
      university: json['university'],
    );
  }
}

class Exam {
  final String title;
  final String category;

  Exam({
    required this.title,
    required this.category,
  });

  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      title: json['title'],
      category: json['category'],
    );
  }
}
