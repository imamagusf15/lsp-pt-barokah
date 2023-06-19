import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lsp_pt_barokah/widgets/inputformfield.dart';

class AddKaryawanPage extends StatefulWidget {
  const AddKaryawanPage({super.key});

  @override
  State<AddKaryawanPage> createState() => _AddKaryawanPageState();
}

class _AddKaryawanPageState extends State<AddKaryawanPage> {
  TextEditingController nipController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController telpController = TextEditingController();

  String? jenisKelamin = 'L';
  String jabatan = 'Staff';
  int gajiPokok = 0;
  double bonusGaji = 0;

  // final ListKaryawan _listKaryawan = ListKaryawan();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
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
                          jabatan = index!;
                          switch (jabatan) {
                            case 'Manager':
                              gajiPokok = 7000000;
                              bonusGaji = 0.5;
                              break;
                            case 'Supervisor':
                              gajiPokok = 5000000;
                              bonusGaji = 0.4;
                              break;
                            case 'Staff':
                              gajiPokok = 4000000;
                              bonusGaji = 0.3;
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
                          // _listKaryawan.addKaryawan(
                          //   nip: nipController.text,
                          //   nama: namaController.text,
                          //   jabatan: jabatan,
                          //   tglLahir: DateTime.parse(dateController.text),
                          //   jenisKelamin: jenisKelamin!,
                          //   alamat: alamatController.text,
                          //   noTelp: telpController.text,
                          //   gajiPokok: gajiPokok,
                          //   bonusGaji: bonusGaji,
                          // );
                          // final karyawanCollection = KaryawanCollection();

                          final String tglLahir = DateFormat("yyyy-MM-dd")
                              .parse(dateController.text)
                              .toString();
                          setState(() {
                            Navigator.of(context).pop();
                          });

                          // karyawanCollection.addKaryawan(
                          //   '007',
                          //   nipController.text,
                          //   namaController.text,
                          //   Timestamp.fromDate(
                          //     DateTime.parse(tglLahir),
                          //   ),
                          //   jabatan,
                          //   jenisKelamin!,
                          //   alamatController.text,
                          //   telpController.text,
                          // );
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
