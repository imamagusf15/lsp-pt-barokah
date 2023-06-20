import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lsp_pt_barokah/db/karyawan_service.dart';
import 'package:lsp_pt_barokah/db/laporan_service.dart';
import 'package:lsp_pt_barokah/models/karyawan_model.dart';
import 'package:lsp_pt_barokah/models/laporan_model.dart';
import 'package:lsp_pt_barokah/screens/detail_laporan_gaji.dart';

class LaporanPage extends StatefulWidget {
  const LaporanPage({super.key});

  @override
  State<LaporanPage> createState() => _LaporanPageState();
}

class _LaporanPageState extends State<LaporanPage> {
  // ListLaporan dataLaporan = ListLaporan();

  LaporanCollection laporanCollection = LaporanCollection();

  final List<Karyawan> listKaryawan = [];

  @override
  void initState() {
    // TODO: implement initState
    KaryawanCollection().getAllKaryawan().listen((event) {
      for (var element in event) {
        listKaryawan.add(element);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.665,
            child: StreamBuilder<List<Laporan>>(
              stream: laporanCollection.getAllLaporan(),
              builder: (context, snapshot) {
                print(snapshot);
                if (snapshot.hasData) {
                  var allLaporan = snapshot.data;
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: allLaporan!.length,
                      itemBuilder: (context, index) {
                        var laporan = allLaporan[index];
                        return Column(
                          children: [
                            ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              leading: CircleAvatar(
                                  child: Text((index + 1).toString())),
                              title: Text(
                                  "Laporan Gaji ${DateFormat("dd-MM-yyyy").format(laporan.tglLaporan!)}"),
                              subtitle: Text(
                                  "${DateFormat('dd/MM/yyyy').format(laporan.tglLaporan!.subtract(
                                const Duration(
                                  days: 30,
                                ),
                              ))} - ${DateFormat("dd-MM-yyyy").format(laporan.tglLaporan!)}"),
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => DetailLaporanGajiPage(
                                      dataLaporan: laporan),
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
                                            onPressed: () {},
                                            child: const Text(
                                              "Hapus",
                                              style:
                                                  TextStyle(color: Colors.red),
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
                    );
                  }
                } else if (snapshot.hasError) {
                  const Text('Terdapat kesalahan.');
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Buat Laporan"),
                      content: Text(
                        "Buat laporan tanggal ${DateFormat('dd-MM-yyyy').format(DateTime.now().subtract(
                          const Duration(
                            days: 30,
                          ),
                        ))} - ${DateFormat('dd-MM-yyyy').format(DateTime.now())} ?",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text(
                            "Batal",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            print(listKaryawan);
                            laporanCollection.addLaporan(
                                DateTime.now(), listKaryawan);
                            Navigator.of(context).pop();
                          },
                          child: const Text("Buat"),
                        ),
                      ],
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
