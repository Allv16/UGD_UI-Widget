import 'dart:convert';

class User{

  final int? id;
  String? date, time, doctorName,userEmail,bpjs;
  User({this.id, this.date, this.time, this.doctorName, this.userEmail, this.bpjs});

  //untuk membuat objek barang dari data json yang diterima dari API
  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));
  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    date: json["date"],
    time: json["time"],
    doctorName: json["doctorName"],
    userEmail: json["userEmail"],
    bpjs: json["bpjs"]
  );

  //untuk membuat data json dari objek barang yang dikirim ke API
  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date,
    "time": time,
    "doctorName": doctorName,
    "userEmail": userEmail,
    "bpjs": bpjs
  };
}