import 'package:audioplayers/audioplayers.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/providers/provider_scan.dart';
import 'package:dwigasindo/services/permission_service.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ComponentScanBPTI extends StatefulWidget {
  ComponentScanBPTI({super.key, required this.noBPTI});
  String noBPTI;

  @override
  State<ComponentScanBPTI> createState() => _ComponentScanBPTIState();
}

class _ComponentScanBPTIState extends State<ComponentScanBPTI> {
  final MobileScannerController cameraController = MobileScannerController();
  final AudioPlayer _audioPlayer = AudioPlayer();
  TextEditingController reason = TextEditingController();
  String? lastScannedCode; // Untuk menyimpan kode terakhir yang discan
  int scanCount = 1; // Menghitung berapa kali kode yang sama terdeteksi
  final int maxScanCount = 5; // Set ke 10 kali pengecekan
  bool isCooldown = false; // Untuk menandai apakah sedang dalam cooldown

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
      WidgetsBinding.instance.addPostFrameCallback((_) {
        PermissionService.checkCameraPermission(context);
        final provider =
            Provider.of<ProviderDistribusi>(context, listen: false);
        provider.getAllTube(context);
        provider.getAllTubeGrade(context);
        provider.getAllTubeType(context);
        provider.getAllTubeGas(context);
        provider.getAllCostumer(context);
      });
    });
    cameraController.start();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderScan>(context);
    final providerDis = Provider.of<ProviderDistribusi>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    // Tentukan ukuran dan posisi area pemindaian relatif terhadap ukuran layar
    final scanWindowHeight = height * 0.25; // 40% dari tinggi layar
    final scanWindowWidth = width * 0.8; // 80% dari lebar layar
    final scanWindowOffset =
        Offset(width / 2, height * 0.3); // Posisikan lebih tinggi dari tengah
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: WidgetAppbar(
        title: 'Scan BPTI',
        colorBG: Colors.grey.shade100,
        colorBack: Colors.black,
        colorTitle: Colors.black,
        center: true,
        back: true,
        route: () {
          provider.clearResults();
          provider.clearScannedCount();
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
                      onDetect: (BarcodeCapture barcode) async {
                        if (barcode.barcodes.isNotEmpty && !isCooldown) {
                          // Cek jika tidak sedang cooldown
                          final String? code = barcode.barcodes.last.rawValue;

                          if (code != null) {
                            // Jika kode berbeda dari kode terakhir yang discan, reset hitungan
                            if (code != lastScannedCode) {
                              lastScannedCode = code;
                              scanCount = 1; // Mulai hitung dari 1 lagi
                            } else {
                              // Jika kode sama, tambahkan hitungan
                              scanCount++;
                            }

                            // Jika kode sama sudah terdeteksi sebanyak 10 kali
                            if (scanCount >= maxScanCount) {
                              final cek = await provider.scanBPTI(
                                context,
                                widget.noBPTI,
                                code,
                              );
                              print("RESPONSE VERIFIKASI $cek");
                              if (cek == true) {
                                _playBeep();
                                await provider.getDataCard(context, code);
                                provider.addScannedData(code, "BPTI");
                                provider.resetCount;
                                // Setelah data dikirim ke API, mulai cooldownx
                                setState(() {
                                  isCooldown = true;
                                });
                              } else if (provider.isCodeScanned(code, "BPTI") ||
                                  provider.count == provider.maxcount) {
                                provider.addCount();
                                showTopSnackBar(
                                  Overlay.of(context),
                                  const CustomSnackBar.error(
                                    message: 'QR sudah discan',
                                  ),
                                );
                              } else {
                                showTopSnackBar(
                                  Overlay.of(context),
                                  const CustomSnackBar.error(
                                    message: 'QR Tidak Sesuai',
                                  ),
                                );
                              }

                              // Set cooldown selama 5 detik
                              Future.delayed(const Duration(seconds: 5), () {
                                setState(() {
                                  isCooldown = false; // Akhiri cooldown
                                  scanCount = 0; // Reset hitungan scan
                                  lastScannedCode = null; // Reset kode terakhir
                                });
                              });
                            }
                          }
                        } else if (isCooldown) {
                          print("Menunggu cooldown selesai...");
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
              SizedBox(
                height: height * 0.01,
              ),
              Expanded(
                flex: 3,
                child: Consumer<ProviderScan>(
                  builder: (context, providerScan, child) {
                    return ListView.builder(
                      itemCount: providerScan.scanResults.length,
                      itemBuilder: (context, index) {
                        final data = providerScan.scanResults[index];
                        int? intGrade;
                        int? intGas;
                        if (data.data?.tubeGradeId != null) {
                          intGrade =
                              int.parse(data.data!.tubeGradeId.toString());
                        }
                        if (data.data?.tubeGasId != null) {
                          intGas = int.parse(data.data!.tubeGasId.toString());
                        }
                        print(intGrade);
                        print(intGas);

                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          width: double.maxFinite,
                          height: height * 0.25,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 1,
                                color: Color(0xffE4E4E4),
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.maxFinite,
                                height: 40,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      width: width * 0.3,
                                      decoration: const BoxDecoration(
                                        color: PRIMARY_COLOR,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          bottomRight: Radius.circular(40),
                                        ),
                                      ),
                                      child: FittedBox(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '${data.data?.code}',
                                          style: titleText,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.vertical(
                                        bottom: Radius.circular(8)),
                                    border: Border(
                                      top: BorderSide(
                                          color: Colors.grey.shade300),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: PRIMARY_COLOR),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          children: [
                                            Expanded(
                                                child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(6),
                                                    child: const FittedBox(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'Produk',
                                                        style: titleTextBlack,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(6),
                                                    child: FittedBox(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          ': ${(data.data?.tubeGasId != null) ? providerDis.getGasName(intGas!) : "-"}',
                                                          style:
                                                              titleTextBlack),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )),
                                            Expanded(
                                                child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(6),
                                                    child: const FittedBox(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'Type',
                                                        style: titleTextBlack,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(6),
                                                    child: FittedBox(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          ': ${(data.data?.isHasTubeType == false) ? "VGL" : "-"} ',
                                                          style:
                                                              titleTextBlack),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )),
                                            Expanded(
                                                child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(6),
                                                    child: const FittedBox(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'Grade',
                                                        style: titleTextBlack,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(6),
                                                    child: FittedBox(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          ': ${(data.data?.isHasGrade == true) ? providerDis.getGrade(intGrade!) : "-"}',
                                                          style:
                                                              titleTextBlack),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )),
                                            Expanded(
                                                child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(6),
                                                    child: const FittedBox(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'Milik',
                                                        style: titleTextBlack,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(6),
                                                    child: FittedBox(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          ': ${(data.data?.ownerShipType == 0) ? "-" : (data.data?.ownerShipType == 1) ? "Assets" : "Pelanggan"}',
                                                          style:
                                                              titleTextBlack),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )),
                                            Expanded(
                                                child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(6),
                                                    child: const FittedBox(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'Keterangan',
                                                        style: titleTextBlack,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(6),
                                                    child: const FittedBox(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(': -',
                                                          style:
                                                              titleTextBlack),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: const EdgeInsets.all(13),
                                      child: FittedBox(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '12-08-2024 10:30:00',
                                          style: TextStyle(
                                            fontFamily: 'Manrope',
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.edit,
                                        size: 20,
                                        color: SECONDARY_COLOR,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(20)),
                                          ),
                                          isScrollControlled: true,
                                          builder: (context) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                left: 16,
                                                right: 16,
                                                top: 16,
                                                bottom: MediaQuery.of(context)
                                                        .viewInsets
                                                        .bottom +
                                                    16,
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // Bagian Atas (Title)
                                                  const Center(
                                                    child: Text(
                                                      'Yakin Ingin Menghapus',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 16),
                                                  // Bagian Tengah (Form)
                                                  WidgetForm(
                                                      controller: reason,
                                                      alert:
                                                          'Harus di isi jika ingin menghapus data',
                                                      hint: "Masukkan Alasan"),
                                                  const SizedBox(height: 16),
                                                  // Bagian Bawah (Button Kembali dan Hapus)
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      WidgetButtonCustom(
                                                          FullWidth:
                                                              width * 0.3,
                                                          FullHeight:
                                                              height * 0.05,
                                                          title: "Kembali",
                                                          bgColor:
                                                              PRIMARY_COLOR,
                                                          onpressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          color: Colors
                                                              .transparent),
                                                      WidgetButtonCustom(
                                                          FullWidth:
                                                              width * 0.3,
                                                          FullHeight:
                                                              height * 0.05,
                                                          title: "Hapus",
                                                          bgColor:
                                                              SECONDARY_COLOR,
                                                          onpressed: () async {
                                                            print(
                                                                "No BPTK : ${widget.noBPTI}\nId : ${data.data!.id}\nReason : ${reason.text}");
                                                            await providerDis
                                                                .deleteDetail(
                                                                    context,
                                                                    widget
                                                                        .noBPTI,
                                                                    data.data!
                                                                        .id!,
                                                                    reason
                                                                        .text);
                                                          },
                                                          color: Colors
                                                              .transparent),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        size: 20,
                                        color: SECONDARY_COLOR,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                            ],
                          ),
                        );
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
            title: 'Selesaikan BPTI',
            onpressed: () {
              provider.clearResults();
              provider.clearScannedCount();
              Navigator.pop(context);
            },
            bgColor: PRIMARY_COLOR,
            color: PRIMARY_COLOR),
      ),
    );
  }
}
