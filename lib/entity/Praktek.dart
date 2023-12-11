import 'package:ugd_ui_widget/entity/Dokter.dart';

class Praktek {
  final int id;
  final String jamPraktek;
  final String hariPraktek;
  final int idDokter;
  final Dokter dokter;

  Praktek({
    required this.id,
    required this.jamPraktek,
    required this.hariPraktek,
    required this.idDokter,
    required this.dokter,
  });

  factory Praktek.fromJson(Map<String, dynamic> json) => Praktek(
        id: json['id'],
        jamPraktek: json['jam_praktek'],
        hariPraktek: json['hari_praktek'],
        idDokter: json['id_dokter'],
        dokter: Dokter.fromJson(json['dokter']),
      );
  factory Praktek.fromJson2(Map<String, dynamic> json) => Praktek(
        id: json['id'],
        jamPraktek: json['jam_praktek'],
        hariPraktek: json['hari_praktek'],
        idDokter: json['id_dokter'],
        dokter:
            Dokter(id: -1, nama: "-1", spesialis: "-1", profileDokter: "-1"),
      );
}
