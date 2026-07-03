class UserInfoModel {
  String email;
  String role;
  String id;
  String name;

  UserInfoModel({
    required this.email,
    required this.role,
    required this.id,
    required this.name,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
    email: json["email"],
    role: json["role"],
    id: json["id"],
    name: json["name"],
  );
}

class LogoutModel {
  bool success;

  LogoutModel({required this.success});

  factory LogoutModel.fromJson(Map<String, dynamic> json) =>
      LogoutModel(success: json["success"]);
}
