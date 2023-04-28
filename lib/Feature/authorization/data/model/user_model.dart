import 'package:instgrameclone/Feature/Authorization/data/entities.dart';

class UserModel extends UserEntities {
  UserModel({required super.token,
    required super.image,
    required super.bio,
    required super.cover,
    required super.email,
    required super.name,
    required super.phone,
    required super.verify});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(
          token: json['uID'] ?? "",
          image:json['image'] ?? "",
          bio: json['bio'] ?? "",
          cover: json['cover'] ?? "",
          email: json['email'] ?? "",
          name: json['name'] ?? "",
          phone: json['phone'] ?? "",
          verify: json['verify'] ?? "") ;


}
