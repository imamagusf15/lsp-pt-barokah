import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lsp_pt_barokah/src/models/karyawan_model.dart';
import 'package:lsp_pt_barokah/src/models/laporan_model.dart';

class FirestoreService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<List<Karyawan>> getAllKaryawan() {
    return db.collection("karyawan").snapshots().map(
      (querySnapshot) {
        final documents = querySnapshot.docs
            .map((doc) => Karyawan.fromFirestore(doc))
            .toList();
        return documents;
      },
    );
  }

  Future<void> addKaryawan(Karyawan karyawan) async {
    db.collection("karyawan").doc().set(karyawan.karyawanToMap());
  }

  Future<void> updateKaryawan(Karyawan karyawan) async {
    db.collection("karyawan").doc(karyawan.id).update(karyawan.karyawanToMap());
  }

  Future<void> deleteKaryawan(id) async {
    db.collection("karyawan").doc(id).delete();
  }

  Stream<List<Laporan>> getAllLaporan() {
    return db.collection("laporan").orderBy("tgl_laporan").snapshots().map(
      (querySnapshot) {
        final allLaporan = querySnapshot.docs
            .map((doc) => Laporan.fromFirestore(doc))
            .toList();

        return allLaporan;
      },
    );
  }

  Future<void> createLaporan(Laporan laporan) {
    return db.collection("laporan").doc().set(laporan.laporanToMap());
  }

  Future<void> deleteLaporan(id) async {
    db.collection("laporan").doc(id).delete();
  }
}
