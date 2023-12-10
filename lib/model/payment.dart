import 'dart:convert';
import 'package:ugd_ui_widget/entity/reservation.dart';

class Payment{
   
  final int? id, amount, id_reservation;
  String? nama, status, jenis_pembayaran,email_user;
  DateTime? date_paid, date_created;

  final Reservation? reservation;
  Payment({this.id, this.amount, this.id_reservation, this.nama, this.status, this.jenis_pembayaran, this.email_user, this.date_paid, this.date_created, this.reservation});

  //untuk membuat objek barang dari data json yang diterima dari API
  factory Payment.fromRawJson(String str) => Payment.fromJson(json.decode(str));
  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
    id: json["id"],
    amount: json["amount"],
    id_reservation: json["id_reservation"],
    nama: json["nama"],
    status: json["status"],
    jenis_pembayaran: json["jenis_pembayaran"],
    email_user: json["email_user"],
    date_paid: DateTime.parse(json["date_paid"]),
    date_created: DateTime.parse(json["date_created"]),
    reservation: json["reservation"] != null? Reservation.fromJson(json["reservation"]) : null,
  );

  //untuk membuat data json dari objek barang yang dikirim ke API
  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
    "id": id,
    "amount": amount,
    "id_reservation": id_reservation,
    "nama": nama,
    "status": status,
    "jenis_pembayaran": jenis_pembayaran,
    "email_user": email_user,
    "date_paid": date_paid.toString(),
    "date_created": date_created.toString(),
    "reservation": reservation?.toJson(),
  };
}