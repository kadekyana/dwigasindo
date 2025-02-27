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

class MenuScan extends StatefulWidget {
  MenuScan({super.key, required this.title, this.idRak});
  String title;
  int? idRak;

  @override
  State<MenuScan> createState() => _MenuScanState();
}

class _MenuScanState extends State<MenuScan> {
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
    print("ID RAK : ${widget.idRak}");
    final provider = Provider.of<ProviderScan>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    // Tentukan ukuran dan posisi area pemindaian relatif terhadap ukuran layar
    final scanWindowHeight = height * 0.25; // 40% dari tinggi layar
    final scanWindowWidth = width * 0.8; // 80% dari lebar layar
    final scanWindowOffset =
        Offset(width / 2, height * 0.3); // Posisikan lebih tinggi dari tengah

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
          if (widget.title == 'C2H2') {
            final provider =
                Provider.of<ProviderProduksi>(context, listen: false);
            await provider.getIsiRak(context, widget.idRak, [0]);
          } else {
            final provider =
                Provider.of<ProviderProduksi>(context, listen: false);
            provider.getTubeShelfMixGas(context, widget.idRak!);
          }
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
                              if (widget.title == 'C2H2') {
                                await provider.scanC2H2(context, code);
                              } else if (widget.title ==
                                  "High Pressure & Mix Gas") {
                                await provider.ScanMixGas(
                                    context, widget.idRak!, code);
                              } else {
                                await provider.scanTubeLoading(context, code);
                              }
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

// class WidgetCard extends StatelessWidget {
//   const WidgetCard({
//     super.key,
//     required this.height,
//     required this.width,
//   });

//   final double height;
//   final double width;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 5),
//       width: double.maxFinite,
//       height: height * 0.25,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         boxShadow: const [
//           BoxShadow(
//             blurRadius: 1,
//             color: Color(0xffE4E4E4),
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           SizedBox(
//             width: double.maxFinite,
//             height: 40,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(10),
//                   width: width * 0.3,
//                   decoration: const BoxDecoration(
//                     color: PRIMARY_COLOR,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(8),
//                       bottomRight: Radius.circular(40),
//                     ),
//                   ),
//                   child: const FittedBox(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       '23G2321',
//                       style: titleText,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(
//                       vertical: height * 0.01, horizontal: width * 0.05),
//                   child: WidgetButton(
//                       FullWidth: width * 0.05,
//                       FullHeight: height,
//                       title: 'Riwayat',
//                       onpressed: () {},
//                       bgColor: PRIMARY_COLOR,
//                       color: PRIMARY_COLOR),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 3,
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
//                 border: Border(
//                   top: BorderSide(color: Colors.grey.shade300),
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(10),
//                       child: Container(
//                         decoration: BoxDecoration(
//                             border: Border.all(color: PRIMARY_COLOR),
//                             borderRadius: BorderRadius.circular(8)),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 2,
//                     child: Column(
//                       children: [
//                         Expanded(
//                             child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               flex: 1,
//                               child: Container(
//                                 padding: EdgeInsets.all(6),
//                                 child: const FittedBox(
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(
//                                     'Produk',
//                                     style: titleTextBlack,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               flex: 2,
//                               child: Container(
//                                 padding: EdgeInsets.all(6),
//                                 child: const FittedBox(
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(': Client/Massal',
//                                       style: titleTextBlack),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )),
//                         Expanded(
//                             child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               flex: 1,
//                               child: Container(
//                                 padding: EdgeInsets.all(6),
//                                 child: const FittedBox(
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(
//                                     'Kondisi',
//                                     style: titleTextBlack,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               flex: 2,
//                               child: Container(
//                                 padding: EdgeInsets.all(6),
//                                 child: const FittedBox(
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(': Baik', style: titleTextBlack),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )),
//                         Expanded(
//                             child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               flex: 1,
//                               child: Container(
//                                 padding: EdgeInsets.all(6),
//                                 child: const FittedBox(
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(
//                                     'Grade',
//                                     style: titleTextBlack,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               flex: 2,
//                               child: Container(
//                                 padding: EdgeInsets.all(6),
//                                 child: const FittedBox(
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(': UHP', style: titleTextBlack),
//                                 ),
//                               ),
//                             )
//                           ],
//                         )),
//                         Expanded(
//                             child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               flex: 1,
//                               child: Container(
//                                 padding: EdgeInsets.all(6),
//                                 child: const FittedBox(
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(
//                                     'Lokasi',
//                                     style: titleTextBlack,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               flex: 2,
//                               child: Container(
//                                 padding: EdgeInsets.all(6),
//                                 child: const FittedBox(
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(': -', style: titleTextBlack),
//                                 ),
//                               ),
//                             )
//                           ],
//                         )),
//                         Expanded(
//                             child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               flex: 1,
//                               child: Container(
//                                 padding: EdgeInsets.all(6),
//                                 child: const FittedBox(
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(
//                                     'Milik',
//                                     style: titleTextBlack,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               flex: 2,
//                               child: Container(
//                                 padding: EdgeInsets.all(6),
//                                 child: const FittedBox(
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(': Asset', style: titleTextBlack),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//               child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 flex: 1,
//                 child: Container(
//                   padding: EdgeInsets.all(13),
//                   child: FittedBox(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       '12-08-2024 10:30:00',
//                       style: TextStyle(
//                         fontFamily: 'Manrope',
//                         color: Colors.grey.shade400,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: Align(
//                   alignment: Alignment.topRight,
//                   child: IconButton(
//                     onPressed: () {},
//                     icon: Icon(
//                       Icons.delete,
//                       size: 20,
//                       color: SECONDARY_COLOR,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           )),
//         ],
//       ),
//     );
//   }
// }
