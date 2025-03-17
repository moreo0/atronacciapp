import 'package:univs/features/quiz/model/quiz_detail_model.dart';

class QuizDetailResponse {
  String message;
  QuizDetailModel data;

  QuizDetailResponse({
    required this.message,
    required this.data,
  });

  factory QuizDetailResponse.fromJson(Map<String, dynamic> json) =>
      QuizDetailResponse(
        message: json["message"],
        data: QuizDetailModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}
