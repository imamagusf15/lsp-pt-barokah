import 'package:flutter/material.dart';

class LaporanProvider with ChangeNotifier {
  String? _laporanId;
  List<dynamic>? _listGajiKaryawan;
  DateTime? _tglLaporan;

  String get getLaporanId => _laporanId!;
  List<dynamic> get getListGajiKaryawan => _listGajiKaryawan!;
  DateTime get getTglLaporan => _tglLaporan!;

  void setLaporanId(String val) {
    _laporanId = val;
    notifyListeners();
  }

  void setListGajiKaryawan(List<dynamic> val) {
    _listGajiKaryawan = val;
    notifyListeners();
  }

  void setTglLaporan(DateTime val) {
    _tglLaporan = val;
    notifyListeners();
  }
}
