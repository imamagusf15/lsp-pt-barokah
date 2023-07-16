import 'package:cloud_firestore/cloud_firestore.dart';

class Karyawan {
  String? id;
  String nip, nama, jabatan, jenisKelamin, alamat, noTelp;
  int gajiPokok;
  double bonusGaji;
  DateTime tglLahir;

  Karyawan({
    this.id,
    required this.nip,
    required this.nama,
    required this.tglLahir,
    required this.jenisKelamin,
    required this.jabatan,
    required this.alamat,
    required this.noTelp,
    required this.gajiPokok,
    required this.bonusGaji,
  });

  factory Karyawan.fromFirestore(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final map = doc.data();
    return Karyawan(
      id: doc.reference.id,
      nip: map['nip'],
      nama: map['nama'],
      tglLahir: (map['tgl_lahir'] as Timestamp).toDate(),
      jenisKelamin: map['jenis_kelamin'],
      jabatan: map['jabatan'],
      alamat: map['alamat'],
      noTelp: map['no_telp'],
      gajiPokok: map['gaji_pokok'],
      bonusGaji: map['bonus_gaji'],
    );
  }

  Map<String, dynamic> karyawanToMap() {
    return {
      'nip': nip,
      'nama': nama,
      'tgl_lahir': tglLahir,
      'jenis_kelamin': jenisKelamin,
      'jabatan': jabatan,
      'alamat': alamat,
      'no_telp': noTelp,
      'gaji_pokok': gajiPokok,
      'bonus_gaji': bonusGaji,
    };
  }
}
