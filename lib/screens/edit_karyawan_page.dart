import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lsp_pt_barokah/db/karyawan_service.dart';
import 'package:lsp_pt_barokah/models/karyawan_model.dart';
import 'package:lsp_pt_barokah/widgets/inputformfield.dart';

class EditKaryawanPage extends StatefulWidget {
  const EditKaryawanPage({super.key, required this.karyawan, required this.id});

  final Karyawan karyawan;
  final String id;

  @override
  State<EditKaryawanPage> createState() => _EditKaryawanPageState();
}

class _EditKaryawanPageState extends State<EditKaryawanPage> {
  TextEditingController nipController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController telpController = TextEditingController();

  GlobalKey formKey = GlobalKey<FormState>();

  late Karyawan karyawan = widget.karyawan;
  late String id = widget.id;

  late String? jenisKelamin = karyawan.jenisKelamin;
  late String? jabatan = karyawan.jabatan;
  int gajiPokok = 0;

  @override
  void initState() {
    super.initState();
    nipController.text = karyawan.nip;
    namaController.text = karyawan.nama;
    dateController.text = DateFormat("dd-MM-yyyy").format((karyawan.tglLahir));
    alamatController.text = karyawan.alamat;
    telpController.text = karyawan.noTelp;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Update"),
        ),
        backgroundColor: Colors.blue,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "NIP",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                InputFormField(
                  controller: nipController,
                  keyboardType: TextInputType.number,
                  maxLength: 15,
                  hintText: 'Masukkan NIP Anda..',
                ),
                const Text(
                  "Nama",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                InputFormField(
                  controller: namaController,
                  keyboardType: TextInputType.name,
                  maxLength: 25,
                  hintText: 'Masukkan nama Anda..',
                ),
                const Text(
                  "Tanggal Lahir",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                InputFormField(
                  controller: dateController,
                  keyboardType: TextInputType.datetime,
                  hintText: 'Masukkan tanggal lahir Anda..',
                  suffixIcon: IconButton(
                    onPressed: () {
                      showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950, 1),
                          lastDate: DateTime.now(),
                          builder: (context, picker) {
                            return Theme(
                              data: ThemeData.light().copyWith(
                                dialogBackgroundColor: Colors.white,
                              ),
                              child: picker!,
                            );
                          }).then((selectedDate) {
                        if (selectedDate != null) {
                          dateController.text =
                              DateFormat('dd-MM-yyyy').format(selectedDate);
                        }
                      });
                    },
                    icon: const Icon(
                      Icons.date_range,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Jenis Kelamin",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: const Text("Masukkan Jenis Kelamin"),
                      borderRadius: BorderRadius.circular(10),
                      items: <String>['L', 'P'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: jenisKelamin,
                      onChanged: (index) {
                        setState(() {
                          jenisKelamin = index;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Jabatan",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: const Text("Input Jabatan"),
                      borderRadius: BorderRadius.circular(10),
                      items: <String>['Staff', 'Supervisor', 'Manager']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: jabatan,
                      onChanged: (index) {
                        setState(() {
                          jabatan = index;
                          switch (jabatan) {
                            case 'Manager':
                              gajiPokok = 7000000;
                              break;
                            case 'Supervisor':
                              gajiPokok = 5000000;
                              break;
                            case 'Staff':
                              gajiPokok = 4000000;
                              break;
                            default:
                          }
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Alamat",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                InputFormField(
                  controller: alamatController..text,
                  keyboardType: TextInputType.streetAddress,
                  hintText: 'Masukkan alamat rumah Anda..',
                ),
                const SizedBox(height: 8),
                const Text(
                  "No. Telepon",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                InputFormField(
                  controller: telpController,
                  keyboardType: TextInputType.phone,
                  maxLength: 15,
                  hintText: 'Masukkan nomor telepon Anda..',
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: MaterialButton(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: Colors.white,
                    onPressed: () {
                      final karyawanCollection = KaryawanCollection();

                      final tglLahir =
                          DateFormat("dd-MM-yyyy").parse(dateController.text);

                      karyawanCollection.updateKaryawan(
                        id,
                        nipController.text,
                        namaController.text,
                        Timestamp.fromDate(
                          tglLahir,
                        ),
                        jabatan!,
                        jenisKelamin!,
                        alamatController.text,
                        telpController.text,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Data berhasil diupdate')));
                    },
                    child: const Text(
                      'Ubah',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
