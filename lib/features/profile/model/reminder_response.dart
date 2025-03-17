import 'package:univs/features/profile/model/reminder_model.dart';

class ReminderResponse {
  String message;
  List<ReminderModel> data;

  ReminderResponse({
    required this.message,
    required this.data,
  });

  factory ReminderResponse.fromJson(Map<String, dynamic> json) =>
      ReminderResponse(
        message: json["message"],
        data: List<ReminderModel>.from(
            json["data"].map((x) => ReminderModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
