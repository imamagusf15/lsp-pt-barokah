import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lsp_pt_barokah/db/connection.dart';
import 'package:lsp_pt_barokah/screens/add_karyawan_page.dart';
import 'package:lsp_pt_barokah/screens/detail_karyawan_page.dart';
import 'package:lsp_pt_barokah/screens/edit_karyawan_page.dart';

class KaryawanPage extends StatefulWidget {
  const KaryawanPage({super.key});

  @override
  State<KaryawanPage> createState() => _KaryawanPageState();
}

class _KaryawanPageState extends State<KaryawanPage> {
  // final ListKaryawan _listKaryawan = ListKaryawan();

  final KaryawanCollection karyawanCollection = KaryawanCollection();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.665,
            child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
              future: karyawanCollection.getAllKaryawan(),
              builder: (context, snapshot) {
                var allDocs = snapshot.data?.docs;
                if (snapshot.hasData) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: allDocs!.length,
                      itemBuilder: (context, index) {
                        var docs = allDocs[index];
                        print('${docs.id} => ${docs.data()}');
                        return Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(child: Text(docs.id)),
                              title: Text(docs.data()['nama']),
                              subtitle: Text(docs.data()['jabatan']),
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailKaryawanPage(karyawan: docs.data()),
                                ),
                              ),
                              trailing: PopupMenuButton(
                                onSelected: (value) {
                                  switch (value) {
                                    case 0:
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EditKaryawanPage(
                                            karyawan: docs.data(),
                                            id: docs.id,
                                          ),
                                        ),
                                      );
                                      break;
                                    case 1:
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text("Hapus Karyawan"),
                                            content: const Text(
                                                "Apakah anda yakin ingin menghapus karyawan ini?"),
                                            actions: [
                                              TextButton(
                                                onPressed: () {},
                                                child: const Text(
                                                  "Hapus",
                                                  style: TextStyle(
                                                      color: Colors.red),
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
                                      break;
                                    default:
                                  }
                                },
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    value: 0,
                                    child: Text("Edit"),
                                  ),
                                  const PopupMenuItem(
                                    value: 1,
                                    child: Text("Delete"),
                                  ),
                                ],
                              ),
                            ),
                            const Divider()
                          ],
                        );
                      },
                    );
                  }
                } else if (snapshot.hasError) {
                  const Text('Tidak ada karyawan.');
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddKaryawanPage(),
                ),
              ),
              child: const Text("Tambah Karyawan"),
            ),
          )
        ],
      ),
    );
  }
}
