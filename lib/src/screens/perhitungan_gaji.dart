import 'package:flutter/material.dart';
import 'package:lsp_pt_barokah/src/db/firestore_service.dart';
import 'package:lsp_pt_barokah/src/models/karyawan_model.dart';
import 'package:lsp_pt_barokah/src/widgets/inputformfield.dart';

class PerhitunganGaji extends StatefulWidget {
  const PerhitunganGaji({super.key});

  @override
  State<PerhitunganGaji> createState() => _PerhitunganGajiState();
}

class _PerhitunganGajiState extends State<PerhitunganGaji> {
  TextEditingController nipController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController jabatanController = TextEditingController();

  final karyawanCollection = FirestoreService();

  String? nama;
  String? jabatan;
  int gajiPokok = 0;
  int totalGaji = 0;
  double bonusGaji = 0;
  double ppnGaji = 0;

  List<Karyawan> karyawan = [];
  Karyawan? selectedKaryawan;

  @override
  void initState() {
    // TODO: implement initState
    karyawanCollection.getAllKaryawan().listen((e) {
      for (var element in e) {
        karyawan.add(element);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nipController.dispose();
    namaController.dispose();
    jabatanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.665,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(4)),
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<Karyawan>(
                        isExpanded: true,
                        hint: const Text("Pilih karyawan"),
                        borderRadius: BorderRadius.circular(10),
                        items: karyawan.map((Karyawan value) {
                          return DropdownMenuItem<Karyawan>(
                            value: value,
                            child: Text(value.nama),
                          );
                        }).toList(),
                        value: selectedKaryawan,
                        onChanged: (index) {
                          setState(() {
                            selectedKaryawan = index;
                            nipController.text = selectedKaryawan!.nip;
                            namaController.text = selectedKaryawan!.nama;
                            jabatanController.text = selectedKaryawan!.jabatan;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                InputFormField(
                  controller: nipController,
                  labelText: 'NIP',
                  hintText: 'NIP',
                  enabled: false,
                ),
                const SizedBox(height: 8),
                InputFormField(
                  controller: namaController,
                  labelText: 'Nama',
                  hintText: 'Nama',
                  enabled: false,
                ),
                const SizedBox(height: 8),
                InputFormField(
                  controller: jabatanController,
                  labelText: 'Jabatan',
                  hintText: 'Jabatan',
                  enabled: false,
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
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
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: SingleChildScrollView(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: const [
                                Text("NIP"),
                                Text("Nama"),
                                Text("Jabatan"),
                                Text("Gaji Pokok"),
                                Text("Bonus"),
                                Text(""),
                              ],
                            )),
                      ),
                    );
                  },
                );
              },
              child: const Text('Hitung Gaji'),
            ),
          ),
        ],
      ),
    );
  }
}
