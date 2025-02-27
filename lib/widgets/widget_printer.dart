import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_thermal_printer/flutter_thermal_printer.dart';
import 'package:flutter_thermal_printer/utils/printer.dart';

class ReusableZPLPrinter extends StatefulWidget {
  const ReusableZPLPrinter({super.key});

  @override
  State<ReusableZPLPrinter> createState() => _ReusableZPLPrinterState();
}

class _ReusableZPLPrinterState extends State<ReusableZPLPrinter> {
  final _flutterThermalPrinterPlugin = FlutterThermalPrinter.instance;
  List<Printer> printers = [];
  StreamSubscription<List<Printer>>? _devicesStreamSubscription;

  void startScan() async {
    log("Starting printer scan...");
    _devicesStreamSubscription?.cancel();
    await _flutterThermalPrinterPlugin.getPrinters(connectionTypes: [
      ConnectionType.BLE,
      ConnectionType.USB,
    ]);
    _devicesStreamSubscription = _flutterThermalPrinterPlugin.devicesStream
        .listen((List<Printer> event) {
      log("Printers found: ${event.map((e) => e.name).toList()}");
      setState(() {
        printers =
            event.where((e) => e.name != null && e.name!.isNotEmpty).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startScan();
    });
  }

  stopScan() {
    log("Stopping printer scan...");
    _flutterThermalPrinterPlugin.stopScan();
  }

  Future<void> printZPL(Printer printer, String namaProduk, String qrCode,
      String serialNumber, String barcode) async {
    try {
      String zplData = _getZPLTemplate(
        namaProduk: namaProduk,
        qrCode: qrCode,
        serialNumber: serialNumber,
        barcode: barcode,
      );
      log("Sending ZPL data to printer: ${printer.name}");
      await _flutterThermalPrinterPlugin.printData(
        printer,
        zplData.codeUnits,
      );
      log("ZPL print command sent successfully.");
    } catch (e) {
      log("Error while printing ZPL: $e");
    }
  }

  String _getZPLTemplate({
    required String namaProduk,
    required String qrCode,
    required String serialNumber,
    required String barcode,
  }) {
    return '''
^XA

^CF0,25^FO340,68^FD$namaProduk^FS
^CFB,15^FO340,93^FDIndustrial Grade 2^FS

^AN,15^FO340,107^FDNo telp^FS
^AN,15^FO400,107^FD:^FS
^AN,15^FO410,107^FD021 - 89117509^FS

^AN,15^FO340,123^FDNo wa^FS
^AN,15^FO400,123^FD:^FS
^AN,15^FO410,123^FD0812 8000 0429^FS

^AN,15^FO340,137^FDEmail^FS
^AN,15^FO400,137^FD:^FS
^AN,15^FO410,137^FDinfo@dwigasindo.co.id^FS

^FO225,5
^BQN,2,5
^FD5xx$qrCode^FS

^CF0,18
^FB130,1,0,C
^FO215,123
^FD$serialNumber^FS

^CF0N,10
^FB130,1,0,C
^FO213,143
^FDPT. Dwigasindo Abadi^FS

^FO340,15
^BY2
^BCN,50,N,N,N,A^FD$barcode^FS

^XZ
  ''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Printer Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: startScan,
              child: const Text('Scan Printers'),
            ),
            ElevatedButton(
              onPressed: stopScan,
              child: const Text('Stop Scan'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: printers.length,
                itemBuilder: (context, index) {
                  final printer = printers[index];
                  return ListTile(
                    title: Text(printer.name ?? 'No Name'),
                    subtitle:
                        Text("Connected: ${printer.isConnected ?? false}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.print),
                      onPressed: () async {
                        if (printer.isConnected ?? false) {
                          await printZPL(printer, "Produk A", "QR12345",
                              "SN67890", "BC54321");
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "Printer ${printer.name ?? 'Unknown'} is not connected."),
                            ),
                          );
                        }
                      },
                    ),
                    onTap: () async {
                      if (printer.isConnected ?? false) {
                        await _flutterThermalPrinterPlugin.disconnect(printer);
                        setState(() {});
                      } else {
                        bool connected =
                            await _flutterThermalPrinterPlugin.connect(printer);
                        if (connected) {
                          setState(() {});
                        }
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
