class RegistrationModel {
    User user;
    String accessToken;
    String refreshToken;
    int expiresIn;

    RegistrationModel({
        required this.user,
        required this.accessToken,
        required this.refreshToken,
        required this.expiresIn,
    });

    factory RegistrationModel.fromJson(Map<String, dynamic> json) => RegistrationModel(
        user: User.fromJson(json["user"]),
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
        expiresIn: json["expires_in"],
    );
}

class User {
    String email;
    String role;
    String id;
    String name;

    User({
        required this.email,
        required this.role,
        required this.id,
        required this.name,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"],
        role: json["role"],
        id: json["id"],
        name: json["name"],
    );

}
