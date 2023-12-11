import 'dart:convert';
import 'package:ugd_ui_widget/entity/Reservation.dart';

class Payments {
  final int id;
  final int amount;
  final DateTime? datePaid; // Use DateTime? for nullable DateTime
  final DateTime dateCreated;
  final String status;
  final String jenisPembayaran;
  final String emailUser;
  final int idReservation;
  final Reservation reservation; // Include a Reservation field

  Payments({
    required this.id,
    required this.amount,
    required this.datePaid,
    required this.dateCreated,
    required this.status,
    required this.jenisPembayaran,
    required this.emailUser,
    required this.idReservation,
    required this.reservation, // Initialize Reservation in the constructor
  });

  factory Payments.fromRawJson(String str) =>
      Payments.fromJson(json.decode(str));

  factory Payments.fromJson(Map<String, dynamic> json) => Payments(
        id: json['id'],
        amount: json['amount'],
        datePaid: json['date_paid'] != null
            ? DateTime.parse(json['date_paid'])
            : null,
        dateCreated: DateTime.parse(json['date_created']),
        status: json['status'],
        jenisPembayaran: json['jenis_pembayaran'],
        emailUser: json['email_user'],
        idReservation: json['id_reservation'],
        reservation:
            Reservation.fromJson(json['reservation']), // Parse Reservation
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "date_paid": datePaid?.toIso8601String(),
        "date_created": dateCreated.toIso8601String(),
        "status": status,
        "jenis_pembayaran": jenisPembayaran,
        "email_user": emailUser,
        "id_reservation": idReservation,
        "reservation": reservation.toJson(), // Convert Reservation to JSON
      };
}
