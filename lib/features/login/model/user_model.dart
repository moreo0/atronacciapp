class UserModel {
  int? id;
  String? email;
  String? name;
  String? username;
  String? image;
  DateTime? dateOfBirth;
  String? gender;
  String? university;
  String? password;
  int? otp;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.username,
    required this.image,
    required this.dateOfBirth,
    required this.gender,
    required this.university,
    required this.password,
    required this.otp,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        username: json["username"],
        image: json["image"],
        dateOfBirth: json["dateOfBirth"] != null
            ? DateTime.parse(json["dateOfBirth"]).toLocal()
            : null,
        gender: json["gender"],
        university: json["university"],
        password: json["password"],
        otp: json["otp"],
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"]).toLocal()
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"]).toLocal()
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "username": username,
        "image": image,
        "dateOfBirth": dateOfBirth!.toIso8601String(),
        "gender": gender,
        "university": university,
        "password": password,
        "otp": otp,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}
