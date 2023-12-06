class Dokter {
  final int id;
  final String nama;
  final String spesialis;
  final String profileDokter;

  Dokter({
    required this.id,
    required this.nama,
    required this.spesialis,
    required this.profileDokter,
  });

  factory Dokter.fromJson(Map<String, dynamic> json) => Dokter(
        id: json['id'],
        nama: json['nama'],
        spesialis: json['spesialis'],
        profileDokter: json['profile_dokter'],
      );
}
