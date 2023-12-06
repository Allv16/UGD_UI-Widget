import 'dart:convert';

import 'package:ugd_ui_widget/entity/Praktek.dart';

class Reservation {
  final int id;
  final String date;
  final bool hasBPJS;
  final String userEmail;
  final int idPraktek;
  final Praktek praktek;

  Reservation({
    required this.id,
    required this.date,
    required this.hasBPJS,
    required this.userEmail,
    required this.idPraktek,
    required this.praktek,
  });

  factory Reservation.fromRawJson(String str) =>
      Reservation.fromJson(json.decode(str));

  factory Reservation.fromJson(Map<String, dynamic> json) => Reservation(
        id: json['id'],
        date: json['date'],
        hasBPJS: json['has_bpjs'] == 1,
        userEmail: json['user_email'],
        idPraktek: json['id_praktek'],
        praktek: Praktek.fromJson(json['praktek']),
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "id_praktek": idPraktek,
        "has_bpjs": hasBPJS,
      };
}
