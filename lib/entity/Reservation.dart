import 'dart:convert';

class Reservation {
  String id;
  String date;
  String? time;
  String doctor_name;
  String user_email;
  String bpjs;

  Reservation({
    required this.id,
    required this.date,
    required this.doctor_name,
    required this.user_email,
    required this.bpjs,
    required this.time
  });

  factory Reservation.fromRawJson(String str) => Reservation.fromJson(json.decode(str));

  factory Reservation.fromJson(Map<String, dynamic> json) => Reservation(
        id: json['id'],
        user_email: json['user_email'],
        date: json['date'],
        time: json['time'],
        doctor_name: json['doctor_name'],
        bpjs: json['bpjs'],
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_email": user_email,
        "date": date,
        "time": time,
        "doctor_name": doctor_name,
          "bpjs": bpjs,
      };
}
