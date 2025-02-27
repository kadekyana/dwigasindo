import 'package:audioplayers/audioplayers.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/providers/provider_scan.dart';
import 'package:dwigasindo/services/permission_service.dart';
import 'package:dwigasindo/views/menus/component_distribusi/componentSurat/component_verifikasi_surat_jalan.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

class ComponentBuatVerifikasiSuratJalan extends StatefulWidget {
  const ComponentBuatVerifikasiSuratJalan({super.key});

  @override
  State<ComponentBuatVerifikasiSuratJalan> createState() =>
      _ComponentBuatVerifikasiSuratJalanState();
}

class _ComponentBuatVerifikasiSuratJalanState
    extends State<ComponentBuatVerifikasiSuratJalan> {
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
    final provider = Provider.of<ProviderDistribusi>(context);
    final providerScan = Provider.of<ProviderScan>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    // Tentukan ukuran dan posisi area pemindaian relatif terhadap ukuran layar
    final scanWindowHeight = height * 0.25; // 40% dari tinggi layar
    final scanWindowWidth = width * 0.8; // 80% dari lebar layar
    final scanWindowOffset =
        Offset(width / 2, height * 0.3); // Posisikan lebih tinggi dari tengah
    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Verifikasi Surat Jalan',
        colorBG: Colors.grey.shade100,
        colorBack: Colors.black,
        colorTitle: Colors.black,
        center: true,
        back: true,
        route: () {
          provider.clearProgress();
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            children: [
              SizedBox(
                width: width,
                height: height * 0.3,
                child: Stack(
                  children: [
                    // Mobile Scanner dengan ukuran jendela pemindaian
                    MobileScanner(
                      controller: cameraController,
                      onDetect: (BarcodeCapture barcode) {
                        if (barcode.barcodes.isNotEmpty) {
                          final String? code = barcode.barcodes.last.rawValue;

                          if (code != null && code.isNotEmpty) {
                            // Cek apakah kode sudah di-scan sebelumnya
                            if (!context
                                .read<ProviderScan>()
                                .isCodeScanned(code, 'BPTI')) {
                              // Jika belum, tambahkan ke list dan tampilkan pesan sukses
                              context
                                  .read<ProviderScan>()
                                  .addScannedData(code, 'BPTI');
                              _playBeep();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text('Total Tabung\nBerhasil: $code')),
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
                              providerScan.toggleFlash();
                            },
                            icon: (providerScan.isFlashOn)
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
              SizedBox(
                height: height * 0.01,
              ),
              SizedBox(
                height: 26,
                width: width,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Preview Surat Jalan',
                    style: titleTextBlack,
                  ),
                ),
              ),
              Expanded(
                child: Consumer<ProviderScan>(
                  builder: (context, providerScan, child) {
                    return ListView.builder(
                      itemCount: providerScan.bptiScannedData.length,
                      itemBuilder: (context, index) {
                        print(providerScan.bptiScannedData[index]);
                        return CardVerifikasi(
                            provider: providerScan,
                            height: height,
                            width: width);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: WidgetButtonCustom(
            FullWidth: width,
            FullHeight: height * 0.06,
            title: 'Simpan',
            onpressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ComponentVerifikasiSuratJalan(),
                ),
              );
            },
            bgColor: PRIMARY_COLOR,
            color: PRIMARY_COLOR),
      ),
    );
  }
}

// widget verifikasi

class CardVerifikasi extends StatelessWidget {
  const CardVerifikasi({
    super.key,
    required this.provider,
    required this.height,
    required this.width,
  });

  final ProviderScan provider;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: double.maxFinite,
      height: height * 0.125,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.grey.shade300,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  width: width * 0.3,
                  decoration: const BoxDecoration(
                    color: PRIMARY_COLOR,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                    child: Text(
                      'SJ-002',
                      style: titleText,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  width: width * 0.35,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerRight,
                    child: Text(
                      '23-09-2024 | 10:30:00',
                      style: titleTextBlack,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(8)),
                border: Border(
                  top: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                child: Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    'CV Solusi Teknologi Bangsa',
                                    style: titleTextBlack,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: height * 0.008),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Driver',
                                      style: titleTextBlack,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: Alignment.topLeft,
                                    child: Text(': Santoso',
                                        style: titleTextBlack),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
