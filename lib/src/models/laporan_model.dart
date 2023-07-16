import 'package:cloud_firestore/cloud_firestore.dart';

class Laporan {
  String? id;
  List<dynamic> listGajiKaryawan;
  DateTime? tglLaporan;

  Laporan({
    this.id,
    required this.listGajiKaryawan,
    required this.tglLaporan,
  });

  factory Laporan.fromFirestore(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final map = doc.data();
    return Laporan(
      id: doc.reference.id,
      listGajiKaryawan: map['list_karyawan'] as List<dynamic>,
      tglLaporan: (map['tgl_laporan'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> laporanToMap() {
    return {
      'list_karyawan': listGajiKaryawan
          .map(
            (e) => {
              "nip": e['nip'],
              "nama": e['nama'],
              "jabatan": e['jabatan'],
              "gaji_pokok": e['gaji_pokok'],
              "bonus_gaji": e['bonus_gaji'],
              "ppn_gaji": e['ppn_gaji'],
              "total_gaji": e['total_gaji'],
            },
          )
          .toList(),
      'tgl_laporan': tglLaporan,
    };
  }
}
