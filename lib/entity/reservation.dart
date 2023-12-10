import 'dart:convert';

class Reservation{

  final int? id;
  String? date, time, doctorName,userEmail,bpjs;
  Reservation({this.id, this.date, this.time, this.doctorName, this.userEmail, this.bpjs});

  //untuk membuat objek barang dari data json yang diterima dari API
  factory Reservation.fromRawJson(String str) => Reservation.fromJson(json.decode(str));
  factory Reservation.fromJson(Map<String, dynamic> json) => Reservation(
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