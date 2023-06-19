import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lsp_pt_barokah/models/laporan_model.dart';

class LaporanCollection {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<Laporan> getLaporan(String id) {
    final colRef = db.collection("laporan-gaji-karyawan").doc(id);
    return colRef.snapshots().map(
      (doc) {
        final data = Laporan.fromJson(doc.data()!);
        // print(data);
        return data;
      },
    );
  }

  Stream<List<Laporan>> getAllLaporan() {
    return db.collection("laporan-gaji-karyawan").snapshots().map(
      (querySnapshot) {
        // print("Successfully completed");
        final allLaporan = querySnapshot.docs
            .map((doc) => Laporan.fromJson(doc.data()))
            .toList();
        return allLaporan;
      },
    );
  }
}
