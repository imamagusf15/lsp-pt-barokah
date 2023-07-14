import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lsp_pt_barokah/src/db/firestore_service.dart';
import 'package:lsp_pt_barokah/src/models/karyawan_model.dart';
import 'package:lsp_pt_barokah/src/utils/validator.dart';
import 'package:lsp_pt_barokah/src/widgets/inputformfield.dart';
import 'package:lsp_pt_barokah/src/widgets/show_snackbar.dart';

class AddKaryawanPage extends StatefulWidget {
  const AddKaryawanPage({super.key});

  @override
  State<AddKaryawanPage> createState() => _AddKaryawanPageState();
}

class _AddKaryawanPageState extends State<AddKaryawanPage> {
  final nipController = TextEditingController();
  final namaController = TextEditingController();
  final dateController = TextEditingController();
  final alamatController = TextEditingController();
  final telpController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final validator = Validator();

  final snackBar = ShowSnackBar();

  String jenisKelamin = 'L';
  String jabatan = 'Staff';

  final karyawanCollection = FirestoreService();

  @override
  void dispose() {
    // TODO: implement dispose
    nipController.dispose();
    namaController.dispose();
    dateController.dispose();
    alamatController.dispose();
    telpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
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
                  validator: (field) => validator.validateNip(nip: field!),
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
                  validator: (field) => validator.validateNama(nama: field!),
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
                  validator: (field) => validator.validateField(field: field!),
                  controller: dateController,
                  keyboardType: TextInputType.datetime,
                  hintText: 'Masukkan tanggal lahir Anda..',
                  readOnly: true,
                  suffixIcon: IconButton(
                    onPressed: () {
                      showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950, 1),
                          lastDate: DateTime(2035, 12),
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
                          jenisKelamin = index!;
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
                          jabatan = index!;
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
                  validator: (field) => validator.validateField(field: field!),
                  controller: alamatController,
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
                  validator: (field) => validator.validateTelp(noTelp: field!),
                  controller: telpController,
                  keyboardType: TextInputType.phone,
                  maxLength: 15,
                  hintText: 'Masukkan nomor telepon Anda..',
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.25,
                      child: MaterialButton(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        color: Colors.white,
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          'Kembali',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.25,
                      child: MaterialButton(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        color: Colors.white,
                        onPressed: () {
                          int gajiPokok = 0;
                          double bonusGaji = 0;
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
                          if (_formKey.currentState!.validate()) {
                            final tglLahir = DateFormat("dd-MM-yyyy")
                                .parse(dateController.text);
                            final newKaryawan = Karyawan(
                              nip: nipController.text,
                              nama: namaController.text,
                              tglLahir: tglLahir,
                              jenisKelamin: jenisKelamin,
                              jabatan: jabatan,
                              alamat: alamatController.text,
                              noTelp: telpController.text,
                              gajiPokok: gajiPokok,
                              bonusGaji: bonusGaji,
                            );

                            karyawanCollection.addKaryawan(newKaryawan);
                            snackBar.showMsg(context, 'Data berhasil ditambah');
                          }
                          nipController.clear();
                          namaController.clear();
                          dateController.clear();
                          alamatController.clear();
                          telpController.clear();
                        },
                        child: const Text(
                          'Tambah',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
