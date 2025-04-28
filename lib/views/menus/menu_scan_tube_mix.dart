import 'package:audioplayers/audioplayers.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_produksi.dart';
import 'package:dwigasindo/providers/provider_scan.dart';
import 'package:dwigasindo/services/permission_service.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class MenuScanTubeMix extends StatefulWidget {
  MenuScanTubeMix({super.key, required this.title, required this.fill});
  String title;
  int? fill;

  @override
  State<MenuScanTubeMix> createState() => _MenuScanTubeMixState();
}

class _MenuScanTubeMixState extends State<MenuScanTubeMix> {
  final MobileScannerController cameraController = MobileScannerController();
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Fungsi untuk memutar suara beep
  Future<void> _playBeep() async {
    await _audioPlayer.play(AssetSource('images/beep.mp3'));
  }

  @override
  void initState() {
    super.initState();
    // Cek izin kamera saat halaman dimuat
    WidgetsBinding.instance.addPostFrameCallback((_) {
      PermissionService.checkCameraPermission(context);
    });
    cameraController.start();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderScan>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    // Tentukan ukuran dan posisi area pemindaian relatif terhadap ukuran layar
    final scanWindowHeight = height * 0.25; // 40% dari tinggi layar
    final scanWindowWidth = width * 0.8; // Posisikan lebih tinggi dari tengah

    return Scaffold(
      appBar: WidgetAppbar(
        title: widget.title,
        colorBG: Colors.grey.shade100,
        colorTitle: Colors.black,
        colorBack: Colors.black,
        center: true,
        back: true,
        route: () async {
          Navigator.pop(context);
          provider.clearAllScannedData();
          provider.clearScannedCount();
          dispose();
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.03),
          child: Column(
            children: [
              // Bagian atas: Scanner
              Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    // Mobile Scanner dengan ukuran jendela pemindaian
                    MobileScanner(
                      controller: cameraController,
                      onDetect: (BarcodeCapture barcode) async {
                        if (barcode.barcodes.isNotEmpty) {
                          final String? code = barcode.barcodes.last.rawValue;

                          if (code != null && code.isNotEmpty) {
                            // Cek apakah kode sudah di-scan sebelumnya
                            if (!context
                                .read<ProviderScan>()
                                .isCodeScanned(code, 'QR')) {
                              // Jika belum, tambahkan ke list dan tampilkan pesan sukses
                              context
                                  .read<ProviderScan>()
                                  .addScannedData(code, 'QR');
                              _playBeep();

                              await provider.scanTubeCO2(
                                  context, code, widget.fill!);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Scan\nBerhasil: $code')),
                              );
                            } else {
                              if (context
                                  .read<ProviderScan>()
                                  .shouldShowDuplicateMessage(code)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Kode sudah pernah discan: $code')),
                                );
                              }
                            }
                          } else {
                            // Jika tidak ada code yang terbaca
                            context.read<ProviderScan>().scanFailureCountF();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Gagal membaca barcode atau QR code')),
                            );
                          }
                        } else {
                          // Jika tidak ada barcode yang terdeteksi
                          context.read<ProviderScan>().scanFailureCountF();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Tidak ada barcode yang terdeteksi')),
                          );
                        }
                      },
                    ),
                    // Garis area pemindaian berada di atas scanner
                    Center(
                      child: Container(
                        width: scanWindowWidth,
                        height: scanWindowHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: Colors.red,
                              width: 2), // Garis merah di sekitar area scan
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: 10,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white),
                        child: IconButton(
                            onPressed: () {
                              cameraController.toggleTorch();
                              provider.toggleFlash();
                            },
                            icon: (provider.isFlashOn)
                                ? const Icon(
                                    Icons.flashlight_on_outlined,
                                  )
                                : const Icon(
                                    Icons.flashlight_off_outlined,
                                  )),
                      ),
                    ),
                  ],
                ),
              ),
              // Menampilkan jumlah scan berhasil dan gagal
              SizedBox(
                height: height * 0.125,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.only(bottomLeft: Radius.circular(6)),
                          color: PRIMARY_COLOR,
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: height * 0.0125),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text('Total Scan\nBerhasil',
                                    textAlign: TextAlign.center,
                                    style: titleText),
                              ),
                            ),
                            Expanded(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text('${provider.scanSuccessCount}',
                                    style: titleText),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: height * 0.0125),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(6)),
                          color: PRIMARY_COLOR,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'Total Scan\nDibatalkan',
                                  textAlign: TextAlign.center,
                                  style: titleText,
                                ),
                              ),
                            ),
                            Expanded(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text('${provider.scanFailureCount}',
                                    style: titleText),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Button Simpan
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: double.maxFinite,
                  height: height * 0.05,
                  margin: EdgeInsets.symmetric(vertical: height * 0.025),
                  decoration: BoxDecoration(
                      color: PRIMARY_COLOR,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Text(
                      'Simpan',
                      style: titleText,
                    ),
                  ),
                ),
              ),
              // Bagian bawah: List hasil scan
              // Expanded(
              //   flex: 3,
              //   child: Consumer<ProviderScan>(
              //     builder: (context, providerScan, child) {
              //       return ListView.builder(
              //         itemCount: providerScan.qrScannedData.length,
              //         itemBuilder: (context, index) {
              //           return WidgetCard(height: height, width: width);
              //         },
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
