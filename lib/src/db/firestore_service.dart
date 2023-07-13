import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lsp_pt_barokah/src/models/karyawan_model.dart';
import 'package:lsp_pt_barokah/src/models/laporan_model.dart';

class FirestoreService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<List<Karyawan>> getAllKaryawan() {
    return db.collection("karyawan").snapshots().map(
      (querySnapshot) {
        // print("Successfully completed");
        final documents = querySnapshot.docs
            .map((doc) => Karyawan.fromFirestore(doc.data()))
            .toList();
        return documents;
      },
    );
  }

  Future<void> addKaryawan(Karyawan karyawan) async {
    db.collection("karyawan").doc(karyawan.nip).set(karyawan.karyawanToMap());
  }

  Future<void> updateKaryawan(Karyawan karyawan) async {
    db
        .collection("karyawan")
        .doc(karyawan.nip)
        .update(karyawan.karyawanToMap());
  }

  Future<void> deleteKaryawan(id) async {
    db.collection("karyawan").doc(id).delete();
  }

  Stream<Laporan> getLaporan(String id) {
    final colRef = db.collection("laporan").doc(id);
    return colRef.snapshots().map(
      (doc) {
        final data = Laporan.fromFirestore(doc.data()!);
        return data;
      },
    );
  }

  Stream<List<Laporan>> getAllLaporan() {
    return db.collection("laporan").orderBy("tgl_laporan").snapshots().map(
      (querySnapshot) {
        final allLaporan = querySnapshot.docs
            .map((doc) => Laporan.fromFirestore(doc.data()))
            .toList();

        return allLaporan;
      },
    );
  }

  Stream<List<String>> getAllLaporanId() {
    return db.collection("laporan").orderBy("tgl_laporan").snapshots().map(
      (querySnapshot) {
        final laporanId =
            querySnapshot.docs.map((doc) => doc.reference.id).toList();
        return laporanId;
      },
    );
  }

  Future<void> createLaporan(Laporan laporan) {
    return db
        .collection("laporan")
        .doc(laporan.laporanId)
        .set(laporan.laporanToMap());
  }

  Future<void> deleteLaporan(id) async {
    db.collection("laporan").doc(id).delete();
  }
}
