import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TestDatabase extends StatefulWidget {
  const TestDatabase({super.key});

  @override
  State<TestDatabase> createState() => _TestDatabaseState();
}

class _TestDatabaseState extends State<TestDatabase> {
  KaryawanCollection karyawanCollection = KaryawanCollection();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Firestore"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              FutureBuilder(
                future: karyawanCollection.getAllKaryawan(),
                builder: (context, snapshot) {
                  var allDocs = snapshot.data!.docs;
                  print(allDocs);
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: allDocs.length,
                    itemBuilder: (context, index) {
                      var docs = allDocs[index].data();
                      return Text(docs['nama']);
                    },
                  );
                },
              ),
              const Spacer(),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () async {
                      await karyawanCollection.getKaryawan('001');
                    },
                    child: const Text("Test")),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class KaryawanCollection {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getKaryawan(String id) async {
    final colRef = db.collection("karyawan").doc(id);
    return await colRef.get().then(
      (doc) {
        final data = doc.data() as Map<String, dynamic>;
        print(data);
        return data;
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllKaryawan() async {
    return await db.collection("karyawan").get().then(
      (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          // print('${docSnapshot.id} => ${docSnapshot.data()}');
        }
        return querySnapshot;
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  void addKaryawan(
    String docId,
    String nip,
    String nama,
    Timestamp tglLahir,
    String jabatan,
    String jenisKelamin,
    String alamat,
    String noTelp,
  ) {
    final colRef = db.collection('/karyawan');

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

    colRef
        .doc(docId.toString())
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
    final colRef = db.collection('/karyawan');

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

    colRef
        .doc(docId.toString())
        .update(data)
        .onError((e, _) => print("Error writing document: $e"));
  }
}

class LaporanCollection {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getLaporan(String id) async {
    final colRef = db.collection("laporan-gaji-karyawan").doc(id);
    return await colRef.get().then(
      (doc) {
        final data = doc.data() as Map<String, dynamic>;
        print(data);
        return data;
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllLaporan() async {
    return await db.collection("laporan-gaji-karyawan").get().then(
      (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          // print('${docSnapshot.id} => ${docSnapshot.data()}');
        }
        return querySnapshot;
      },
      onError: (e) => print("Error completing: $e"),
    );
  }
}
