import 'dart:convert';

class User {
  //final String image;
  final String username;
  final String email;
  final String password;
  final String noTelp;
  final String tglLahir;
  final String profilePath;

  const User({
    required this.username,
    required this.email,
    required this.password,
    required this.noTelp,
    required this.tglLahir,
    required this.profilePath,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));
  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        password: json["password"],
        email: json["email"],
        noTelp: json["no_telp"],
        tglLahir: json["tgl_lahir"],
        profilePath: json["profile_path"],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "email": email,
        "no_telp": noTelp,
        "tgl_lahir": tglLahir,
        "profile_path": profilePath,
      };
}
