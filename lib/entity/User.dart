import 'dart:convert';

class User{

  final int? id;
  String? username, password, email,tglLahir,noTelp;
  User({this.id,this.username,this.password,this.email,this.tglLahir,this.noTelp});


  //untuk membuat objek barang dari data json yang diterima dari API
  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));
  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    username: json["username"],
    password: json["password"],
    email: json["email"],
    tglLahir: json["tglLahir"],
    noTelp: json["noTelp"]
  );

  //untuk membuat data json dari objek barang yang dikirim ke API
  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "password": password,
    "email": email,
    "tglLahir": tglLahir,
    "noTelp": noTelp
  };
}