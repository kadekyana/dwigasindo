import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_thermal_printer/flutter_thermal_printer.dart';
import 'package:flutter_thermal_printer/utils/printer.dart';

class ProviderPrinter with ChangeNotifier {
  final _flutterThermalPrinterPlugin = FlutterThermalPrinter.instance;
  Printer? _selectedPrinter;
  List<Printer> _printers = [];
  bool _isPrinterConnected = false;

  Printer? get selectedPrinter => _selectedPrinter;
  List<Printer> get printers => _printers;
  bool get isPrinterConnected => _isPrinterConnected;

  ProviderPrinter() {
    _startScanAndConnect();
  }

  void _startScanAndConnect() async {
    log("Mulai scanning printer USB...");

    // Hentikan pemindaian sebelumnya jika ada
    await _flutterThermalPrinterPlugin.stopScan();

    // Mulai pemindaian printer
    await _flutterThermalPrinterPlugin.getPrinters(
      connectionTypes: [ConnectionType.USB],
    );

    // Dengarkan perubahan daftar printer
    _flutterThermalPrinterPlugin.devicesStream
        .listen((List<Printer> printersList) async {
      log("Printer ditemukan: ${printersList.map((e) => e.name).toList()}");

      if (printersList.isNotEmpty) {
        _printers = printersList;
        notifyListeners();

        // Coba sambungkan ke printer USB pertama yang tersedia
        Printer usbPrinter = _printers.firstWhere(
          (printer) => printer.connectionType == ConnectionType.USB,
          orElse: () =>
              _printers.first, // Gunakan printer pertama jika tidak ada USB
        );

        bool isConnected =
            await _flutterThermalPrinterPlugin.connect(usbPrinter);
        if (isConnected) {
          _selectedPrinter = usbPrinter;
          _isPrinterConnected = true;
          log("Berhasil terhubung ke printer: ${usbPrinter.name}");
        } else {
          _isPrinterConnected = false;
          log("Gagal menghubungkan ke printer: ${usbPrinter.name}");
        }
        notifyListeners();
      }
    });
  }
}
