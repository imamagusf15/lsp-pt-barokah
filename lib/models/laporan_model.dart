import 'package:lsp_pt_barokah/models/karyawan_model.dart';

class Laporan {
  int? id;
  List<Karyawan>? listDataKaryawan;
  DateTime? tglLaporan;
  int totalGaji;

  Laporan({
    this.id,
    this.listDataKaryawan,
    this.tglLaporan,
    this.totalGaji = 0,
  });

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
      id: 001,
      listDataKaryawan: listKaryawan.listDataKaryawan,
      tglLaporan: DateTime.now(),
      totalGaji: 0,
    ),
  ];
}
