import 'package:data_tables/data_tables.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lsp_pt_barokah/models/laporan_model.dart';
import 'package:lsp_pt_barokah/utils/currency_format.dart';

class DetailLaporanGajiPage extends StatelessWidget {
  const DetailLaporanGajiPage({super.key, required this.dataLaporan});

  final Map<String, dynamic> dataLaporan;

  @override
  Widget build(BuildContext context) {
    final listLaporan = ListLaporan().listLaporan[0];
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          "Laporan Tanggal :\n${DateFormat('dd-MM-yyyy').format(
            listLaporan.tglLaporan!.subtract(
              const Duration(
                days: 30,
              ),
            ),
          )} - ${DateFormat('dd-MM-yyyy').format(listLaporan.tglLaporan!)}",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: NativeDataTable.builder(
          showSelect: false,
          showSort: false,
          columns: const [
            DataColumn(
              label: Text('Nama'),
            ),
            DataColumn(
              label: Text('NIP'),
            ),
            DataColumn(
              label: Text('Jabatan'),
            ),
            DataColumn(
              label: Text('Gaji Pokok'),
            ),
            DataColumn(
              label: Text('Bonus'),
            ),
            DataColumn(
              label: Text('PPN'),
            ),
            DataColumn(
              label: Text('Total Gaji'),
            ),
          ],
          itemCount: listLaporan.listDataKaryawan.length,
          itemBuilder: (index) {
            var dataKaryawan = listLaporan.listDataKaryawan;
            return DataRow(
              cells: [
                DataCell(Text(dataKaryawan[index].nama)),
                DataCell(Text(dataKaryawan[index].nip)),
                DataCell(Text(dataKaryawan[index].jabatan)),
                DataCell(Text(
                  CurrencyFormat.convertToIdr(dataKaryawan[index].gajiPokok, 2),
                )),
                DataCell(
                    Text('${(dataKaryawan[index].bonusGaji * 100).toInt()}%')),
                const DataCell(Text('5%')),
                // DataCell(Text(
                //   CurrencyFormat.convertToIdr(
                //     Laporan().hitungGaji(
                //       dataKaryawan[index].jabatan,
                //       dataKaryawan[index].gajiPokok,
                //       dataKaryawan[index].bonusGaji,
                //     ),
                //     2,
                //   ),
                // )),
              ],
            );
          },
        ),
      ),
    );
  }
}
