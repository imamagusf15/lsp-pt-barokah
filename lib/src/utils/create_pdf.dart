import 'dart:io';

import 'package:intl/intl.dart';
import 'package:lsp_pt_barokah/src/utils/currency_format.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfDoc {
  final pdf = pw.Document();

  Future<File> createPdf(List<Map<String, dynamic>> data, DateTime tgl,
      String? sortedField, bool asc) async {
    int totalGajiKaryawan = 0;
    if (sortedField != null) {
      data.sort((a, b) {
        if (asc) {
          return a[sortedField].compareTo(b[sortedField]);
        } else {
          return b[sortedField].compareTo(a[sortedField]);
        }
      });
    }

    for (var map in data) {
      final gaji = map['total_gaji'] as int;
      totalGajiKaryawan = totalGajiKaryawan + gaji;
    }

    pw.Padding headingColumn(String textContent) {
      return pw.Padding(
        padding: const pw.EdgeInsets.all(4.0),
        child: pw.Center(
          child: pw.Text(
            textContent,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),
        ),
      );
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.landscape,
        build: (context) {
          toIdr(number) {
            return CurrencyFormat.convertToIdr(number, 0);
          }

          return [
            pw.Center(
              child: pw.Column(
                children: [
                  pw.Header(
                    text:
                        "Laporan Bulan ke-${tgl.month}\nTanggal ${DateFormat('dd-MM-yyyy').format(tgl)} - ${DateFormat('dd-MM-yyyy').format(DateTime(tgl.year, tgl.month + 1, tgl.day))}",
                  ),
                  pw.Table(
                    columnWidths: {
                      0: const pw.FlexColumnWidth(1),
                      1: const pw.FlexColumnWidth(4),
                      2: const pw.FlexColumnWidth(5),
                      3: const pw.FlexColumnWidth(3),
                      4: const pw.FlexColumnWidth(4),
                      5: const pw.FlexColumnWidth(4),
                      6: const pw.FlexColumnWidth(4),
                      7: const pw.FlexColumnWidth(4),
                    },
                    border: pw.TableBorder.all(),
                    children: [
                      pw.TableRow(
                        repeat: true,
                        children: [
                          headingColumn("No"),
                          headingColumn("NIP"),
                          headingColumn("Nama"),
                          headingColumn("Jabatan"),
                          headingColumn("Gaji Pokok"),
                          headingColumn("Bonus Gaji"),
                          headingColumn("PPN Gaji"),
                          headingColumn("Total Gaji"),
                        ],
                      ),
                    ],
                  ),
                  pw.Table(
                    columnWidths: {
                      0: const pw.FlexColumnWidth(1),
                      1: const pw.FlexColumnWidth(4),
                      2: const pw.FlexColumnWidth(5),
                      3: const pw.FlexColumnWidth(3),
                      4: const pw.FlexColumnWidth(4),
                      5: const pw.FlexColumnWidth(4),
                      6: const pw.FlexColumnWidth(4),
                      7: const pw.FlexColumnWidth(4),
                    },
                    border: pw.TableBorder.all(),
                    children: List.generate(
                      data.length,
                      (index) {
                        return pw.TableRow(
                          children: [
                            pw.Padding(
                                padding: const pw.EdgeInsets.symmetric(
                                    horizontal: 4),
                                child:
                                    pw.Center(child: pw.Text("${index + 1}"))),
                            pw.Padding(
                                padding: const pw.EdgeInsets.symmetric(
                                    horizontal: 4),
                                child: pw.Text(data[index]['nip'])),
                            pw.Padding(
                                padding: const pw.EdgeInsets.symmetric(
                                    horizontal: 4),
                                child: pw.Text(data[index]['nama'])),
                            pw.Padding(
                                padding: const pw.EdgeInsets.symmetric(
                                    horizontal: 4),
                                child: pw.Center(
                                    child: pw.Text(data[index]['jabatan']))),
                            pw.Padding(
                                padding: const pw.EdgeInsets.symmetric(
                                    horizontal: 4),
                                child:
                                    pw.Text(toIdr(data[index]['gaji_pokok']))),
                            pw.Padding(
                                padding: const pw.EdgeInsets.symmetric(
                                    horizontal: 4),
                                child:
                                    pw.Text(toIdr(data[index]['bonus_gaji']))),
                            pw.Padding(
                                padding: const pw.EdgeInsets.symmetric(
                                    horizontal: 4),
                                child: pw.Text(toIdr(data[index]['ppn_gaji']))),
                            pw.Padding(
                                padding: const pw.EdgeInsets.symmetric(
                                    horizontal: 4),
                                child:
                                    pw.Text(toIdr(data[index]['total_gaji']))),
                          ],
                        );
                      },
                    ),
                  ),
                  pw.Table(
                    columnWidths: {
                      0: const pw.FlexColumnWidth(1),
                      1: const pw.FlexColumnWidth(4),
                      2: const pw.FlexColumnWidth(5),
                      3: const pw.FlexColumnWidth(3),
                      4: const pw.FlexColumnWidth(4),
                      5: const pw.FlexColumnWidth(4),
                      6: const pw.FlexColumnWidth(4),
                      7: const pw.FlexColumnWidth(4),
                    },
                    border: pw.TableBorder.all(),
                    children: [
                      pw.TableRow(
                        children: [
                          pw.Padding(
                            padding:
                                const pw.EdgeInsets.symmetric(horizontal: 4),
                            child: pw.Center(child: pw.Text("")),
                          ),
                          pw.Padding(
                            padding:
                                const pw.EdgeInsets.symmetric(horizontal: 4),
                            child: pw.Center(child: pw.Text("")),
                          ),
                          pw.Padding(
                            padding:
                                const pw.EdgeInsets.symmetric(horizontal: 4),
                            child: pw.Center(child: pw.Text("")),
                          ),
                          pw.Padding(
                            padding:
                                const pw.EdgeInsets.symmetric(horizontal: 4),
                            child: pw.Center(child: pw.Text("")),
                          ),
                          pw.Padding(
                            padding:
                                const pw.EdgeInsets.symmetric(horizontal: 4),
                            child: pw.Center(child: pw.Text("")),
                          ),
                          pw.Padding(
                            padding:
                                const pw.EdgeInsets.symmetric(horizontal: 4),
                            child: pw.Center(child: pw.Text("")),
                          ),
                          pw.Padding(
                            padding:
                                const pw.EdgeInsets.symmetric(horizontal: 4),
                            child: pw.Text("Total Gaji:"),
                          ),
                          pw.Padding(
                            padding:
                                const pw.EdgeInsets.symmetric(horizontal: 4),
                            child: pw.Text(toIdr(totalGajiKaryawan)),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            )
          ];
        },
      ),
    );
    final output = await getExternalStorageDirectory();
    final fileName = DateFormat('dd-MM-yyyy').format(tgl);
    final file = File("${output!.path}/laporan_$fileName.pdf");
    return await file.writeAsBytes(await pdf.save());
  }
}
