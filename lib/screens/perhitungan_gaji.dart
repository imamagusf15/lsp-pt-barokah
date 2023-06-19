import 'package:flutter/material.dart';
import 'package:lsp_pt_barokah/utils/currency_format.dart';

class PerhitunganGaji extends StatefulWidget {
  const PerhitunganGaji({super.key});

  @override
  State<PerhitunganGaji> createState() => _PerhitunganGajiState();
}

class _PerhitunganGajiState extends State<PerhitunganGaji> {
  TextEditingController nipController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController jabatanController = TextEditingController();

  String nip = '';
  String nama = '';
  String? jabatan = 'Staff';
  int gajiPokok = 0;
  int totalGaji = 0;
  double bonusGaji = 0;
  double ppnGaji = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perhitungan Gaji'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: nipController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'NIP',
                      helperText: 'Masukkan NIP Anda',
                    ),
                  ),
                  TextFormField(
                    controller: namaController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Nama',
                      helperText: 'Masukkan Nama Anda',
                    ),
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
                        items: <String>['Manager', 'Supervisor', 'Staff']
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
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    nip = nipController.text;
                    nama = namaController.text;
                    // hitungGaji();
                    hitungGaji(jabatan!, gajiPokok, bonusGaji);
                  });
                },
                child: const Text('Hitung Gaji'),
              ),
            ),
            const SizedBox(height: 50),
            Column(
              children: [
                Text("NIP Anda: $nip"),
                Text("Nama Anda: $nama"),
                Text(
                    "Gaji Pokok Anda: ${CurrencyFormat.convertToIdr(gajiPokok, 2)}"),
                Text("Bonus Gaji Anda: ${(bonusGaji * 100).toInt()}%"),
                Text("PPN Gaji : 5%"),
                Text(
                    "Total Gaji Anda: ${CurrencyFormat.convertToIdr(totalGaji, 2)}"),
              ],
            )
          ],
        ),
      ),
    );
  }

  hitungGaji(String jabatan, int gajiPokok, double bonusGaji) {
    double ppnGaji = 0.05;
    bonusGaji = gajiPokok * bonusGaji;
    ppnGaji = (gajiPokok + bonusGaji) * ppnGaji;
    totalGaji = gajiPokok + bonusGaji.toInt() - ppnGaji.toInt();
  }
}
