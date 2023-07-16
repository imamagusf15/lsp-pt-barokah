import 'package:flutter/material.dart';
import 'package:lsp_pt_barokah/src/db/firestore_service.dart';
import 'package:lsp_pt_barokah/src/models/karyawan_model.dart';
import 'package:lsp_pt_barokah/src/screens/add_karyawan_page.dart';
import 'package:lsp_pt_barokah/src/screens/detail_karyawan_page.dart';
import 'package:lsp_pt_barokah/src/screens/edit_karyawan_page.dart';
import 'package:lsp_pt_barokah/src/widgets/show_snackbar.dart';
import 'package:provider/provider.dart';

class KaryawanPage extends StatelessWidget {
  const KaryawanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final listKaryawan = Provider.of<List<Karyawan>>(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.665,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: listKaryawan.length,
              itemBuilder: (context, index) {
                var docs = listKaryawan[index];
                return Column(
                  children: [
                    ListTile(
                      leading:
                          CircleAvatar(child: Text((index + 1).toString())),
                      title: Text(docs.nama),
                      subtitle: Text(docs.jabatan),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailKaryawanPage(karyawan: docs),
                        ),
                      ),
                      trailing: PopupMenuButton(
                        onSelected: (value) {
                          switch (value) {
                            case 0:
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => EditKaryawanPage(
                                    karyawan: docs,
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
                                        onPressed: () {
                                          final db = FirestoreService();
                                          final snackBar = ShowSnackBar();
                                          db.deleteKaryawan(docs.nip);
                                          Navigator.of(context).pop();
                                          snackBar.showMsg(context,
                                              'Karyawan berhasil dihapus');
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
                  ],
                );
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
