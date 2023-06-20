import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lsp_pt_barokah/models/karyawan_model.dart';

class KaryawanCollection {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<Karyawan> getKaryawan(String id) {
    final colRef = db.collection("karyawan").doc(id);
    return colRef.snapshots().map(
      (doc) {
        final data = Karyawan.fromJson(doc.data()!);
        // print(data);
        return data;
      },
    );
  }

  Stream<List<Karyawan>> getAllKaryawan() {
    return db.collection("karyawan").snapshots().map(
      (querySnapshot) {
        // print("Successfully completed");
        final documents = querySnapshot.docs
            .map((doc) => Karyawan.fromJson(doc.data()))
            .toList();
        return documents;
      },
    );
  }

  Stream<List<String>> getAllKaryawanId() {
    return db.collection("karyawan").snapshots().map(
      (querySnapshot) {
        // print("Successfully completed");
        final documents =
            querySnapshot.docs.map((doc) => doc.reference.id).toList();
        return documents;
      },
    );
  }

  void addKaryawan(
    String nip,
    String nama,
    Timestamp tglLahir,
    String jabatan,
    String jenisKelamin,
    String alamat,
    String noTelp,
  ) {
    int? gajiPokok;
    double? bonusGaji;

    switch (jabatan) {
      case 'Staff':
        gajiPokok = 4000000;
        bonusGaji = 0.3;
        break;
      case 'Supervisor':
        gajiPokok = 5000000;
        bonusGaji = 0.4;
        break;
      case 'Manager':
        gajiPokok = 7000000;
        bonusGaji = 0.5;
        break;
      default:
    }
    final data = {
      "nip": nip,
      "nama": nama,
      "tgl_lahir": tglLahir,
      "jabatan": jabatan,
      "jenis_kelamin": jenisKelamin,
      "alamat": alamat,
      "no_telp": noTelp,
      "gaji_pokok": gajiPokok,
      "bonus_gaji": bonusGaji,
    };

    db
        .collection("karyawan")
        .doc()
        .set(data)
        .onError((e, _) => print("Error writing document: $e"));
  }

  void updateKaryawan(
    String docId,
    String nip,
    String nama,
    Timestamp tglLahir,
    String jabatan,
    String jenisKelamin,
    String alamat,
    String noTelp,
  ) {
    int? gajiPokok;
    double? bonusGaji;

    switch (jabatan) {
      case 'Staff':
        gajiPokok = 4000000;
        bonusGaji = 0.3;
        break;
      case 'Supervisor':
        gajiPokok = 5000000;
        bonusGaji = 0.4;
        break;
      case 'Manager':
        gajiPokok = 7000000;
        bonusGaji = 0.5;
        break;
      default:
    }
    final data = <String, dynamic>{
      "nip": nip,
      "nama": nama,
      "tgl_lahir": tglLahir,
      "jabatan": jabatan,
      "jenis_kelamin": jenisKelamin,
      "alamat": alamat,
      "no_telp": noTelp,
      "gaji_pokok": gajiPokok,
      "bonus_gaji": bonusGaji,
    };

    db
        .collection("karyawan")
        .doc(docId.toString())
        .update(data)
        .onError((e, _) => print("Error writing document: $e"));
  }

  void deleteKaryawan(id) {
    db.collection("karyawan").doc(id).delete();
  }
}
