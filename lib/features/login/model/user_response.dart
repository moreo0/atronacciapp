import 'package:univs/features/login/model/user_model.dart';

class UserResponse {
  String message;
  List<UserModel> data;

  UserResponse({
    required this.message,
    required this.data,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      message: json["message"],
      data: json["data"] != null ? [UserModel.fromJson(json["data"])] : [],
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
