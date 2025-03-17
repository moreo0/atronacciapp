import 'package:univs/features/quiz/model/quiz_model.dart';

class QuizResponse {
  String message;
  List<QuizModel> data;

  QuizResponse({
    required this.message,
    required this.data,
  });

  factory QuizResponse.fromJson(Map<String, dynamic> json) => QuizResponse(
        message: json["message"],
        data: List<QuizModel>.from(
            json["data"].map((x) => QuizModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
