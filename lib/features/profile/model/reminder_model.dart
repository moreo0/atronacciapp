class ReminderModel {
  int id;
  int userId;
  String title;
  DateTime date;
  String time;
  DateTime createdAt;
  DateTime updatedAt;

  ReminderModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.date,
    required this.time,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReminderModel.fromJson(Map<String, dynamic> json) => ReminderModel(
        id: json["id"],
        userId: json["userId"],
        title: json["title"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "title": title,
        "date": date.toIso8601String(),
        "time": time,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
