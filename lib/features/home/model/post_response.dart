import 'package:univs/features/home/model/post_model.dart';

class PostResponse {
  String message;
  List<PostModel> data;

  PostResponse({
    required this.message,
    required this.data,
  });

  factory PostResponse.fromJson(Map<String, dynamic> json) => PostResponse(
        message: json["message"],
        data: List<PostModel>.from(
            json["data"].map((x) => PostModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
