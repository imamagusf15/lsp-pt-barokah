import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lsp_pt_barokah/models/karyawan_model.dart';
import 'package:lsp_pt_barokah/models/laporan_model.dart';

class LaporanCollection {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<Laporan> getLaporan(String id) {
    final colRef = db.collection("laporan").doc(id);
    return colRef.snapshots().map(
      (doc) {
        final data = Laporan.fromJson(doc.data()!);
        // print(data);
        return data;
      },
    );
  }

  Stream<List<Laporan>> getAllLaporan() {
    return db.collection("laporan").snapshots().map(
      (querySnapshot) {
        // print("Successfully completed");
        final allLaporan = querySnapshot.docs
            .map((doc) => Laporan.fromJson(doc.data()))
            .toList();
        return allLaporan;
      },
    );
  }

  Stream<List<String>> getAllLaporanId() {
    return db.collection("laporan").snapshots().map(
      (querySnapshot) {
        // print("Successfully completed");
        final laporanId =
            querySnapshot.docs.map((doc) => doc.reference.id).toList();
        return laporanId;
      },
    );
  }

  void addLaporan(
    DateTime tglLaporan,
    List<Karyawan> listKaryawan,
  ) {
    List<dynamic> listKaryawanAktif = [];

    for (int i = 0; i < listKaryawan.length; i++) {
      int gajiPokok = listKaryawan[i].gajiPokok;
      double bonusGaji = listKaryawan[i].bonusGaji;
      int totalGaji = 0;
      double ppnGaji = 0.05;
      bonusGaji = gajiPokok * bonusGaji;
      ppnGaji = (gajiPokok + bonusGaji) * ppnGaji;
      totalGaji = gajiPokok + bonusGaji.toInt() - ppnGaji.toInt();

      final dataKaryawan = {
        "nip": listKaryawan[i].nip,
        "nama": listKaryawan[i].nama,
        "jabatan": listKaryawan[i].jabatan,
        "gaji_pokok": gajiPokok,
        "bonus_gaji": bonusGaji,
        "ppn_gaji": ppnGaji,
        "total_gaji": totalGaji,
      };

      listKaryawanAktif.add(dataKaryawan);
    }
    final data = {
      "tgl_laporan": tglLaporan,
      "list_karyawan": listKaryawanAktif
    };

    db
        .collection("laporan")
        .doc()
        .set(data)
        .onError((e, _) => print("Error writing document: $e"));
  }

  void deleteLaporan(id) {
    db.collection("laporan").doc(id).delete();
  }
}
