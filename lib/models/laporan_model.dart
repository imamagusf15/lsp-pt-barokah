import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lsp_pt_barokah/models/karyawan_model.dart';

class Laporan {
  List<dynamic> listDataKaryawan;
  DateTime? tglLaporan;
  int totalGaji;

  Laporan({
    required this.listDataKaryawan,
    required this.tglLaporan,
    this.totalGaji = 0,
  });

  factory Laporan.fromJson(Map<String, dynamic> json) {
    return Laporan(
      listDataKaryawan: json['list_karyawan'] as List<dynamic>,
      // (json['list_karyawan'] as List<Karyawan>)
      //     .map((e) => Karyawan.fromJson(e as Map<String, dynamic>))
      //     .toList(),
      tglLaporan: (json['tgl_laporan'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> laporanToJson(Laporan instance) {
    return {
      'list_karyawan':
          jsonEncode(instance.listDataKaryawan.map((e) => e.karyawanToJson())),
      'tgl_laporan': instance.tglLaporan,
    };
  }

  hitungGaji(String jabatan, int gajiPokok, double bonusGaji) {
    double ppnGaji = 0.05;
    bonusGaji = gajiPokok * bonusGaji;
    ppnGaji = (gajiPokok + bonusGaji) * ppnGaji;
    totalGaji = gajiPokok + bonusGaji.toInt() - ppnGaji.toInt();
    return totalGaji;
  }
}

class ListLaporan {
  static ListKaryawan listKaryawan = ListKaryawan();
  List<Laporan> listLaporan = [
    Laporan(
      listDataKaryawan: listKaryawan.listDataKaryawan,
      tglLaporan: DateTime.now(),
      totalGaji: 0,
    ),
  ];
}
