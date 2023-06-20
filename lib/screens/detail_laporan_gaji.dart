import 'package:data_tables/data_tables.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lsp_pt_barokah/models/laporan_model.dart';
import 'package:lsp_pt_barokah/utils/currency_format.dart';

class DetailLaporanGajiPage extends StatelessWidget {
  const DetailLaporanGajiPage({super.key, required this.dataLaporan});

  final Laporan dataLaporan;

  @override
  Widget build(BuildContext context) {
    // final listLaporan = ListLaporan().listLaporan[0];
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          "Laporan Tanggal :\n${DateFormat('dd-MM-yyyy').format(
            dataLaporan.tglLaporan!.subtract(
              const Duration(
                days: 30,
              ),
            ),
          )} - ${DateFormat('dd-MM-yyyy').format(dataLaporan.tglLaporan!)}",
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
          itemCount: dataLaporan.listDataKaryawan.length,
          itemBuilder: (index) {
            var dataKaryawan = dataLaporan.listDataKaryawan;
            return DataRow(
              cells: [
                DataCell(Text(dataKaryawan[index]['nama'])),
                DataCell(Text(dataKaryawan[index]['nip'])),
                DataCell(Text(dataKaryawan[index]['jabatan'])),
                DataCell(Text(
                  CurrencyFormat.convertToIdr(
                      dataKaryawan[index]['gaji_pokok'], 2),
                )),
                DataCell(Text(
                  CurrencyFormat.convertToIdr(
                    dataKaryawan[index]['bonus_gaji'],
                    2,
                  ),
                )),
                DataCell(Text(CurrencyFormat.convertToIdr(
                    dataKaryawan[index]['ppn_gaji'], 2))),
                DataCell(Text(
                  CurrencyFormat.convertToIdr(
                    dataKaryawan[index]['total_gaji'],
                    2,
                  ),
                )),
              ],
            );
          },
        ),
      ),
    );
  }
}
