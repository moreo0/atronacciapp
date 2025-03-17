import 'package:univs/features/quiz/model/quiz_subminssion_model.dart';

class QuizSubmissionResponse {
  String message;
  QuizSubmission data;

  QuizSubmissionResponse({
    required this.message,
    required this.data,
  });

  factory QuizSubmissionResponse.fromJson(Map<String, dynamic> json) =>
      QuizSubmissionResponse(
        message: json["message"],
        data: QuizSubmission.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}
