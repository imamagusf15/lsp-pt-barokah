import 'package:lsp_pt_barokah/models/karyawan_model.dart';

class Laporan {
  String? id;
  List<Karyawan> listDataKaryawan;
  DateTime? tglLaporan;
  int totalGaji;

  Laporan({
    this.id,
    required this.listDataKaryawan,
    required this.tglLaporan,
    required this.totalGaji,
  });

  factory Laporan.fromJson(Map<String, dynamic> json) {
    return Laporan(
      id: json['nip'],
      listDataKaryawan: json['nama'],
      tglLaporan: json['tgl_lahir'],
      totalGaji: json['jenis_kelamin'],
    );
  }

  List<Karyawan> convertVaccinations(List<dynamic> karyawanMap) {
    final listKaryawan = <Karyawan>[];

    for (final karyawan in karyawanMap) {
      listKaryawan.add(Karyawan.fromJson(karyawan as Map<String, dynamic>));
    }
    return listKaryawan;
  }

  Map<String, dynamic> laporanToJson(Laporan instance) {
    return {
      'id': instance.id,
      'list_karyawan': instance.listDataKaryawan,
      'tgl_laporan': instance.tglLaporan,
      'total_gaji': instance.totalGaji,
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
      id: '001',
      listDataKaryawan: listKaryawan.listDataKaryawan,
      tglLaporan: DateTime.now(),
      totalGaji: 0,
    ),
  ];
}
