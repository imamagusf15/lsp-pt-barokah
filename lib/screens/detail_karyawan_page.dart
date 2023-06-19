import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lsp_pt_barokah/utils/currency_format.dart';

class DetailKaryawanPage extends StatelessWidget {
  const DetailKaryawanPage({super.key, required this.karyawan});

  final Map<String, dynamic> karyawan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(karyawan['nama']),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text("Nomor Induk Pegawai"),
            subtitle: Text(karyawan['nip']),
          ),
          ListTile(
            title: const Text("Tanggal Lahir"),
            subtitle: Text(DateFormat("dd-MM-yyyy")
                .format((karyawan['tgl_lahir'] as Timestamp).toDate())),
          ),
          ListTile(
            title: const Text("Jenis Kelamin"),
            subtitle: Text(karyawan['jenis_kelamin']),
          ),
          ListTile(
            title: const Text("Jabatan"),
            subtitle: Text(karyawan['jabatan']),
          ),
          ListTile(
            title: const Text("Alamat"),
            subtitle: Text(karyawan['alamat']),
          ),
          ListTile(
            title: const Text("No. Telepon"),
            subtitle: Text(karyawan['no_telp']),
          ),
          ListTile(
            title: const Text("Gaji Pokok"),
            subtitle:
                Text(CurrencyFormat.convertToIdr(karyawan['gaji_pokok'], 2)),
          ),
          ListTile(
            title: const Text("Bonus Gaji"),
            subtitle:
                Text("${((karyawan['bonus_gaji'] as double) * 100).toInt()}%"),
          ),
        ],
      ),
    );
  }
}
