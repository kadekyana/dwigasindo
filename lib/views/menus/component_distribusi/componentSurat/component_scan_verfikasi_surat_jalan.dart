import 'package:audioplayers/audioplayers.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/providers/provider_scan.dart';
import 'package:dwigasindo/services/permission_service.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

class ComponentScanVerifikasiSuratJalan extends StatefulWidget {
  const ComponentScanVerifikasiSuratJalan({super.key});

  @override
  State<ComponentScanVerifikasiSuratJalan> createState() =>
      _ComponentScanVerifikasiSuratJalanState();
}

class _ComponentScanVerifikasiSuratJalanState
    extends State<ComponentScanVerifikasiSuratJalan> {
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
                                .isCodeScanned(code, 'VERIFIKASI')) {
                              // Jika belum, tambahkan ke list dan tampilkan pesan sukses
                              context
                                  .read<ProviderScan>()
                                  .addScannedData(code, 'VERIFIKASI');
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
              Container(
                width: width,
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05, vertical: height * 0.01),
                height: height * 0.1,
                decoration: BoxDecoration(
                  color: PRIMARY_COLOR,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: width,
                      height: 26,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '23-09-2024',
                          style: titleText,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100,
                            height: 16,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Nama Driver',
                                style: subtitleText,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            height: 16,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                ': Andi',
                                style: subtitleText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100,
                            height: 16,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Dibuat  Oleh',
                                style: subtitleText,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            height: 16,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                ': Ozo',
                                style: subtitleText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              SizedBox(
                width: width,
                height: 26,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Data Surat Jalan',
                    style: titleTextBlack,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Expanded(
                child: Consumer<ProviderScan>(
                  builder: (context, providerScan, child) {
                    return ListView.builder(
                      itemCount: providerScan.verfikasiScannedData.length,
                      itemBuilder: (context, index) {
                        print(providerScan.verfikasiScannedData[index]);
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
            title: 'Selesai Verifikasi',
            onpressed: () {},
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
      height: height * 0.25,
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
                Expanded(
                  child: SizedBox(
                    height: 18,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Text(
                        'CV Solusi Teknologi Bangsa',
                        style: titleTextBlack,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.02,
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
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.05, vertical: height * 0.01),
                      child: Column(
                        children: [
                          Container(
                            width: width,
                            height: height * 0.05,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: COMPLEMENTARY_COLOR2,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    offset: const Offset(0, 2),
                                  )
                                ]),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'DWI-002 - Argon',
                                style: titleText,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Container(
                            width: width,
                            height: height * 0.05,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    offset: const Offset(0, 2),
                                  )
                                ]),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'DWI-002 - Carbondioxide',
                                style: titleTextBlack,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Container(
                            width: width,
                            height: height * 0.05,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    offset: const Offset(0, 2),
                                  )
                                ]),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'DWI-002',
                                style: titleTextBlack,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
