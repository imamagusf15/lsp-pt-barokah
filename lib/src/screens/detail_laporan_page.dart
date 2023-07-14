import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lsp_pt_barokah/src/models/laporan_model.dart';
import 'package:lsp_pt_barokah/src/utils/create_pdf.dart';
import 'package:lsp_pt_barokah/src/utils/currency_format.dart';
import 'package:lsp_pt_barokah/src/widgets/show_snackbar.dart';

class DetailLaporanGajiPage extends StatefulWidget {
  const DetailLaporanGajiPage({super.key, required this.dataLaporan});

  final Laporan dataLaporan;

  @override
  State<DetailLaporanGajiPage> createState() => _DetailLaporanGajiPageState();
}

class _DetailLaporanGajiPageState extends State<DetailLaporanGajiPage> {
  LaporanSource? dataSource;
  bool sortAsc = true;
  int colIndex = 0;
  String? sortedField;
  DateTime? tglLaporan;

  final snackBar = ShowSnackBar();

  @override
  void initState() {
    // TODO: implement initState
    dataSource = LaporanSource(laporan: widget.dataLaporan);
    tglLaporan = widget.dataLaporan.tglLaporan!;
    super.initState();
  }

  void _sort(Comparable Function(Map<String, dynamic> map) getField,
      int columnIndex, bool ascending, String field) {
    dataSource!._sort(getField, ascending);
    setState(() {
      colIndex = columnIndex;
      sortAsc = ascending;
      sortedField = field;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Laporan Bulan ${tglLaporan!.month}"),
      ),
      body: PaginatedDataTable(
        sortAscending: sortAsc,
        sortColumnIndex: colIndex,
        header: Text(
          "Laporan Tanggal\n${DateFormat('dd-MM-yyyy').format(tglLaporan!)} - ${DateFormat('dd-MM-yyyy').format(DateTime(tglLaporan!.year, tglLaporan!.month + 1, tglLaporan!.day))}",
          style: const TextStyle(fontSize: 14),
        ),
        actions: [
          IconButton(
              onPressed: () {
                final pdf = PdfDoc();
                pdf.createPdf(
                    dataSource!.getData, tglLaporan!, sortedField, sortAsc);
                snackBar.showMsg(context, 'Laporan berhasil di export');
              },
              icon: const Icon(Icons.picture_as_pdf))
        ],
        rowsPerPage: 8,
        columns: [
          const DataColumn(
            label: Text('No'),
          ),
          DataColumn(
            label: const Text('NIP'),
            onSort: (columnIndex, ascending) {
              _sort((map) => map['nip'], columnIndex, ascending, 'nip');
            },
          ),
          DataColumn(
            label: const Text('Nama'),
            onSort: (columnIndex, ascending) {
              _sort((map) => map['nama'], columnIndex, ascending, 'nama');
            },
          ),
          DataColumn(
            label: const Text('Jabatan'),
            onSort: (columnIndex, ascending) {
              _sort((map) => map['jabatan'], columnIndex, ascending, 'jabatan');
            },
          ),
          DataColumn(
            label: const Text('Gaji Pokok'),
            onSort: (columnIndex, ascending) {
              _sort((map) => map['gaji_pokok'], columnIndex, ascending,
                  'gaji_pokok');
            },
          ),
          DataColumn(
            label: const Text('Bonus Gaji'),
            onSort: (columnIndex, ascending) {
              _sort((map) => map['bonus_gaji'], columnIndex, ascending,
                  'bonus_gaji');
            },
          ),
          DataColumn(
            label: const Text('PPN'),
            onSort: (columnIndex, ascending) {
              _sort(
                  (map) => map['ppn_gaji'], columnIndex, ascending, 'ppn_gaji');
            },
          ),
          DataColumn(
            label: const Text('Total Gaji'),
            onSort: (columnIndex, ascending) {
              _sort((map) => map['total_gaji'], columnIndex, ascending,
                  'total_gaji');
            },
          ),
        ],
        source: dataSource!,
      ),
    );
  }
}

class LaporanSource extends DataTableSource {
  Laporan laporan;

  LaporanSource({required this.laporan});

  late final _data = List.generate(
    laporan.listGajiKaryawan.length,
    (index) {
      var dataKaryawan = laporan.listGajiKaryawan[index];
      return {
        "nama": dataKaryawan['nama'],
        "nip": dataKaryawan['nip'],
        "jabatan": dataKaryawan['jabatan'],
        "gaji_pokok": dataKaryawan['gaji_pokok'],
        "bonus_gaji": dataKaryawan['bonus_gaji'],
        "ppn_gaji": dataKaryawan['ppn_gaji'],
        "total_gaji": dataKaryawan['total_gaji'],
      };
    },
  );

  void _sort(
      Comparable Function(Map<String, dynamic> map) getField, bool ascending) {
    _data.sort((a, b) {
      if (!ascending) {
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
  List<Map<String, dynamic>> get getData => _data;
  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text("${index + 1}")),
      DataCell(Text(_data[index]['nip'])),
      DataCell(Text(_data[index]["nama"])),
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
    ]);
  }
}
