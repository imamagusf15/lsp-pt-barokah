import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lsp_pt_barokah/src/db/firestore_service.dart';
import 'package:lsp_pt_barokah/src/models/karyawan_model.dart';
import 'package:lsp_pt_barokah/src/models/laporan_model.dart';
import 'package:lsp_pt_barokah/src/screens/detail_laporan_page.dart';
import 'package:lsp_pt_barokah/src/widgets/show_snackbar.dart';
import 'package:provider/provider.dart';

class LaporanPage extends StatefulWidget {
  const LaporanPage({super.key});

  @override
  State<LaporanPage> createState() => _LaporanPageState();
}

class _LaporanPageState extends State<LaporanPage> {
  final db = FirestoreService();
  final snackBar = ShowSnackBar();

  final List<Karyawan> listKaryawan = [];
  List<String> months = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12'
  ];

  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final _rnd = Random();

  @override
  void initState() {
    // TODO: implement initState
    final karyawan = Provider.of<List<Karyawan>?>(context, listen: false) ?? [];

    for (var element in karyawan) {
      listKaryawan.add(element);
    }

    super.initState();
  }

  setRandomId(int length) {
    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  setGaji(List<Karyawan> listKaryawan) {
    List<Map<String, dynamic>> listGajiKaryawan = [];
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
      listGajiKaryawan.add(dataKaryawan);
    }
    return listGajiKaryawan;
  }

  @override
  Widget build(BuildContext context) {
    final listLaporan = Provider.of<List<Laporan>?>(context) ?? [];
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.665,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: listLaporan.length,
              itemBuilder: (context, index) {
                var laporan = listLaporan[index];
                return Column(
                  children: [
                    ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      leading:
                          CircleAvatar(child: Text((index + 1).toString())),
                      title: Text(
                          "Laporan Bulan ${DateFormat("MM").format(laporan.tglLaporan!)}"),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailLaporanGajiPage(dataLaporan: laporan),
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Hapus Laporan"),
                                content: const Text(
                                    "Apakah anda yakin ingin menghapus laporan ini?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      db.deleteLaporan(laporan.laporanId);
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      "Hapus",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text("Batal"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ),
                    const Divider()
                  ],
                );
              },
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
                String? selectedMonth;
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      child: Container(
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: StatefulBuilder(
                            builder: (context, setState) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Pilih Bulan Laporan",
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 12),
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        menuMaxHeight: 200,
                                        hint: const Text("Pilih Bulan"),
                                        borderRadius: BorderRadius.circular(10),
                                        items: months.map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text("Bulan $value"),
                                          );
                                        }).toList(),
                                        value: selectedMonth,
                                        onChanged: (index) {
                                          setState((() {
                                            selectedMonth = index!;
                                          }));
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: ElevatedButton(
                                      onPressed: selectedMonth == null
                                          ? null
                                          : () {
                                              final tglLaporan =
                                                  DateFormat("yyyy-MM").parse(
                                                      "${DateTime.now().year}-${selectedMonth!}");
                                              final newLaporan = Laporan(
                                                  laporanId: setRandomId(10),
                                                  listGajiKaryawan:
                                                      setGaji(listKaryawan),
                                                  tglLaporan: tglLaporan);
                                              db.createLaporan(newLaporan);
                                              Navigator.of(context).pop();
                                              snackBar.showMsg(context,
                                                  'Laporan Berhasil dibuat');
                                            },
                                      child: const Text("Buat"),
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Text("Buat Laporan"),
            ),
          )
        ],
      ),
    );
  }
}
