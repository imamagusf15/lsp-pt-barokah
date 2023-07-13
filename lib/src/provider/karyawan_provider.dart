import 'package:flutter/material.dart';

class KaryawanProvider with ChangeNotifier {
  String? _nip, _nama, _jabatan, _jenisKelamin, _alamat, _noTelp;
  int? _gajiPokok;
  double? _bonusGaji;
  DateTime? _tglLahir;

  String get getNip => _nip!;
  String get getNama => _nama!;
  String get getJabatan => _jabatan!;
  String get getJenisKelamin => _jenisKelamin!;
  String get getAlamat => _alamat!;
  String get getNoTelp => _noTelp!;
  int get getGajiPokok => _gajiPokok!;
  double get getBonusGaji => _bonusGaji!;
  DateTime get getTglLahir => _tglLahir!;

  void setKaryawanNip(String val) {
    _nip = val;
    notifyListeners();
  }

  void setKaryawanName(String val) {
    _nama = val;
    notifyListeners();
  }

  void setKaryawanJabatan(String val) {
    _jabatan = val;
    notifyListeners();
  }

  void setKaryawanJenisKelamin(String val) {
    _jenisKelamin = val;
    notifyListeners();
  }

  void setKaryawanAlamat(String val) {
    _alamat = val;
    notifyListeners();
  }

  void setKaryawanNoTelp(String val) {
    _noTelp = val;
    notifyListeners();
  }

  void setKaryawanGajiPokok(int val) {
    _gajiPokok = val;
    notifyListeners();
  }

  void setKaryawanBonusGaji(double val) {
    _bonusGaji = val;
    notifyListeners();
  }

  void setKaryawanTglLahir(DateTime val) {
    _tglLahir = val;
    notifyListeners();
  }
}
