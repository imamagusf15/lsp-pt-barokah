import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lsp_pt_barokah/src/models/laporan_model.dart';
import 'package:lsp_pt_barokah/src/utils/currency_format.dart';
import 'package:provider/provider.dart';

class GajiKaryawanPage extends StatefulWidget {
  const GajiKaryawanPage({super.key, required this.nip, required this.nama});

  final String nip;
  final String nama;

  @override
  State<GajiKaryawanPage> createState() => _GajiKaryawanPageState();
}

class _GajiKaryawanPageState extends State<GajiKaryawanPage> {
  List<Map<String, dynamic>> gajiKaryawan = [];
  DataSource? dataSource;
  bool sortAsc = false;
  int colIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    final listLaporan =
        Provider.of<List<Laporan>?>(context, listen: false) ?? [];
    for (var element in listLaporan) {
      final mapData =
          element.listGajiKaryawan.where((map) => map['nip'] == widget.nip);
      if (mapData.isNotEmpty) {
        gajiKaryawan.add({
          "gaji_karyawan": mapData.first,
          "tgl_laporan": DateFormat("dd-MM-yyyy").format(element.tglLaporan!),
        });
      }
    }

    dataSource = DataSource(dataGaji: gajiKaryawan);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    gajiKaryawan.clear();
    super.dispose();
  }

  void _sort(Comparable Function(Map<String, dynamic> map) getField,
      int columnIndex, bool ascending) {
    dataSource!._sort(getField, ascending);
    setState(() {
      colIndex = columnIndex;
      sortAsc = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nama),
      ),
      body: PaginatedDataTable(
        sortAscending: sortAsc,
        sortColumnIndex: colIndex,
        rowsPerPage: 10,
        columns: [
          const DataColumn(
            label: Text("No"),
          ),
          DataColumn(
            label: const Text("Jabatan"),
            onSort: (columnIndex, ascending) {
              _sort((map) => map['jabatan'], columnIndex, ascending);
            },
          ),
          DataColumn(
            label: const Text("Gaji Pokok"),
            onSort: (columnIndex, ascending) {
              _sort((map) => map['gaji_pokok'], columnIndex, ascending);
            },
          ),
          DataColumn(
            label: const Text("Bonus Gaji"),
            onSort: (columnIndex, ascending) {
              _sort((map) => map['bonus_gaji'], columnIndex, ascending);
            },
          ),
          DataColumn(
            label: const Text("PPN"),
            onSort: (columnIndex, ascending) {
              _sort((map) => map['ppn_gaji'], columnIndex, ascending);
            },
          ),
          DataColumn(
            label: const Text("Total Gaji"),
            onSort: (columnIndex, ascending) {
              _sort((map) => map['total_gaji'], columnIndex, ascending);
            },
          ),
          DataColumn(
            label: const Text("Tanggal Gajian"),
            onSort: (columnIndex, ascending) {
              _sort((map) => map['tgl_laporan'], columnIndex, ascending);
            },
          ),
        ],
        source: dataSource!,
      ),
    );
  }
}

class DataSource extends DataTableSource {
  List<Map<String, dynamic>> dataGaji;
  DataSource({required this.dataGaji});

  late final _data = List.generate(
    dataGaji.length,
    (index) {
      final karyawan = dataGaji[index]['gaji_karyawan'];
      return {
        "jabatan": karyawan['jabatan'],
        "gaji_pokok": karyawan['gaji_pokok'],
        "bonus_gaji": karyawan['bonus_gaji'],
        "ppn_gaji": karyawan['ppn_gaji'],
        "total_gaji": karyawan['total_gaji'],
        "tgl_laporan": dataGaji[index]['tgl_laporan'],
      };
    },
  );

  void _sort(
      Comparable Function(Map<String, dynamic> map) getField, bool ascending) {
    _data.sort((a, b) {
      if (ascending) {
        final c = a;
        a = b;
        b = c;
      }
      final Comparable aValue = getField(a);
      final Comparable bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    notifyListeners();
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => _data.length;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text("${index + 1}")),
      DataCell(Text(_data[index]['jabatan'])),
      DataCell(
        Text(CurrencyFormat.convertToIdr(_data[index]['gaji_pokok'], 0)),
      ),
      DataCell(
        Text(CurrencyFormat.convertToIdr(_data[index]['bonus_gaji'], 0)),
      ),
      DataCell(Text(CurrencyFormat.convertToIdr(_data[index]['ppn_gaji'], 0))),
      DataCell(
          Text(CurrencyFormat.convertToIdr(_data[index]['total_gaji'], 0))),
      DataCell(Text(_data[index]['tgl_laporan'])),
    ]);
  }
}
