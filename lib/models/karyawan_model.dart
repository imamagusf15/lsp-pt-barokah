import 'package:cloud_firestore/cloud_firestore.dart';

class Karyawan {
  String nip, nama, jabatan, jenisKelamin, alamat, noTelp;
  int gajiPokok;
  double bonusGaji;
  DateTime tglLahir;

  Karyawan({
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

  factory Karyawan.fromJson(Map<String, dynamic> json) {
    return Karyawan(
      nip: json['nip'],
      nama: json['nama'],
      tglLahir: (json['tgl_lahir'] as Timestamp).toDate(),
      jenisKelamin: json['jenis_kelamin'],
      jabatan: json['jabatan'],
      alamat: json['alamat'],
      noTelp: json['no_telp'],
      gajiPokok: json['gaji_pokok'],
      bonusGaji: json['bonus_gaji'],
    );
  }

  Map<String, dynamic> karyawanToJson() {
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

class ListKaryawan {
  List<Karyawan> listDataKaryawan = [
    Karyawan(
      nip: '7053240983',
      nama: 'Adiarja Kusumo',
      tglLahir: DateTime.parse("1975-10-24"),
      jenisKelamin: 'L',
      jabatan: 'Staff',
      alamat: 'Jr. Laswi No. 644, Yogyakarta 95899, NTB',
      noTelp: '05204163739',
      gajiPokok: 4000000,
      bonusGaji: 0.3,
    ),
    Karyawan(
      nip: '2684602074',
      nama: 'Gantar Natsir',
      tglLahir: DateTime.parse("1977-03-22"),
      jenisKelamin: 'L',
      jabatan: 'Supervisor',
      alamat: 'Ds. Sentot Alibasa No. 839, Tasikmalaya 99291, Riau',
      noTelp: '099005350241',
      gajiPokok: 5000000,
      bonusGaji: 0.4,
    ),
    Karyawan(
      nip: '3568325179',
      nama: 'Malika Mulyani',
      tglLahir: DateTime.parse("1981-01-01"),
      jenisKelamin: 'P',
      jabatan: 'Staff',
      alamat: 'Psr. Yosodipuro No. 744, Bima 65562, Lampung',
      noTelp: '03775615022',
      gajiPokok: 4000000,
      bonusGaji: 0.3,
    ),
    Karyawan(
      nip: '4345907762',
      nama: 'Lili Halimah',
      tglLahir: DateTime.parse("1980-12-10"),
      jenisKelamin: 'L',
      jabatan: 'Staff',
      alamat: 'Jln. Cut Nyak Dien No. 381, Denpasar 45184, Kalimantan Timur',
      noTelp: '02763370543',
      gajiPokok: 4000000,
      bonusGaji: 0.3,
    ),
    Karyawan(
      nip: '0916427042',
      nama: 'Fitriani Sudiati',
      tglLahir: DateTime.parse("1960-08-11"),
      jenisKelamin: 'P',
      jabatan: 'Manager',
      alamat: 'Kpg. Bakit No. 198, Bandung 40039, Sulawesi Tengah',
      noTelp: '04779857879',
      gajiPokok: 7000000,
      bonusGaji: 0.5,
    ),
    Karyawan(
      nip: '3408593520',
      nama: 'Gamanto Mustofa',
      tglLahir: DateTime.parse("1994-03-14"),
      jenisKelamin: 'L',
      jabatan: 'Staff',
      alamat: 'Jr. Bakau No. 691, Sabang 31488, Kalimantan Timur',
      noTelp: '08124891293',
      gajiPokok: 4000000,
      bonusGaji: 0.3,
    ),
  ];
}
