import 'dart:async';

import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/providers/provider_scan.dart';
import 'package:dwigasindo/views/menus/component_distribusi/componentBPTK/component_scan_qrcode.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ComponentDetail extends StatefulWidget {
  ComponentDetail({super.key, required this.uuid});
  String? uuid;
  @override
  State<ComponentDetail> createState() => _ComponentDetailState();
}

class _ComponentDetailState extends State<ComponentDetail> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Memanggil data pertama kali setelah widget diinisialisasi
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ProviderDistribusi>(context, listen: false);
      provider.getVerifikasiBPTK(context, widget.uuid!);
    });

    // Memanggil getVerifikasiBPTK setiap 2 detik
    _timer = Timer.periodic(const Duration(milliseconds: 500), (Timer timer) {
      final provider = Provider.of<ProviderDistribusi>(context, listen: false);
      provider.getVerifikasiBPTK(context, widget.uuid!);
    });
  }

  @override
  void dispose() {
    // Hentikan timer ketika widget dihapus
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderDistribusi>(context);
    final providerS = Provider.of<ProviderScan>(context);
    final data = provider.verifikasiBptk?.data;

    return PopScope(
      onPopInvoked: (didPop) async {
        await provider.clearCount('countT');
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: WidgetAppbar(
          title: 'Detail',
          colorBG: Colors.grey.shade100,
          center: true,
          sizefont: 20,
          colorBack: Colors.black,
          colorTitle: Colors.black,
          back: true,
          route: () async {
            await provider.clearCount('countT');
            Navigator.pop(context);
          },
        ),
        body: (provider.isLoadingVer == true)
            ? Center(
                child: Container(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(),
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      width: width,
                      height: height * 0.2,
                      decoration: BoxDecoration(
                        color: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: height * 0.02, horizontal: width * 0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 24,
                              child: FittedBox(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  '${data?.noBptk} | ${(data?.createdAt == null) ? "-" : provider.formatDate(data!.createdAt.toString())}',
                                  style: titleText,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  //Row Pertama
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  'Jenis Gas',
                                                  textAlign: TextAlign.left,
                                                  style: minisubtitleText,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  ': ${data?.gasType}',
                                                  textAlign: TextAlign.start,
                                                  style: minisubtitleText,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Driver',
                                                  textAlign: TextAlign.left,
                                                  style: minisubtitleText,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  ': ${data?.driver?.name}',
                                                  textAlign: TextAlign.start,
                                                  style: minisubtitleText,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: FittedBox(
                                                  child: Text(
                                                    'Jumlah Tabung',
                                                    textAlign: TextAlign.left,
                                                    style: minisubtitleText,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  ': ${data?.count}',
                                                  textAlign: TextAlign.start,
                                                  style: minisubtitleText,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Sumber',
                                                  textAlign: TextAlign.left,
                                                  style: minisubtitleText,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  ': ${data?.customer?.name}',
                                                  textAlign: TextAlign.start,
                                                  style: minisubtitleText,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  WidgetButtonCustom(
                                      FullWidth: width * 0.2,
                                      FullHeight: height * 0.04,
                                      title: 'Tambah',
                                      onpressed: () {
                                        providerS.clearResults();
                                        providerS.clearScannedCount();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ComponentScanQrCode(
                                                    noBptk: data!.noBptk!,
                                                  )),
                                        );
                                      },
                                      bgColor: Color.fromARGB(255, 55, 72, 199),
                                      color: Colors.transparent),
                                  SizedBox(
                                    width: width * 0.02,
                                  ),
                                  WidgetButtonCustom(
                                      FullWidth: width * 0.15,
                                      FullHeight: height * 0.04,
                                      title: 'Ubah',
                                      onpressed: () {},
                                      bgColor: Color.fromARGB(255, 55, 72, 199),
                                      color: Colors.transparent),
                                  SizedBox(
                                    width: width * 0.02,
                                  ),
                                  WidgetButtonCustom(
                                      FullWidth: width * 0.2,
                                      FullHeight: height * 0.04,
                                      title: 'Selesai',
                                      onpressed: () {},
                                      bgColor: SECONDARY_COLOR,
                                      color: Colors.transparent)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    WidgetCard(height: height, width: width),
                  ],
                ),
              ),
      ),
    );
  }
}

class WidgetCard extends StatelessWidget {
  WidgetCard({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;
  TextEditingController reason = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderDistribusi>(context);
    final data = provider.verifikasiBptk?.data;
    return Expanded(
      child: ListView.builder(
        itemCount: data?.details?.length,
        itemBuilder: (context, index) {
          final details = data?.details?[index];
          return Container(
            width: double.maxFinite,
            height: height * 0.2,
            margin: EdgeInsets.only(bottom: height * 0.01),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  color: Colors.grey.shade300,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  width: double.maxFinite,
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        width: width * 0.3,
                        decoration: BoxDecoration(
                          color: (details?.status == 0)
                              ? PRIMARY_COLOR
                              : (details?.status == 1)
                                  ? COMPLEMENTARY_COLOR2
                                  : SECONDARY_COLOR,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomRight: Radius.circular(40),
                          ),
                        ),
                        child: FittedBox(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${details?.tubeCode}',
                            style: titleText,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: height * 0.015, horizontal: width * 0.05),
                        child: WidgetButton(
                            FullWidth: width * 0.05,
                            FullHeight: height,
                            title: 'Lihat Riwayat',
                            onpressed: () {},
                            bgColor: (details?.status == 0)
                                ? PRIMARY_COLOR
                                : (details?.status == 1)
                                    ? COMPLEMENTARY_COLOR2
                                    : SECONDARY_COLOR,
                            color: (details?.status == 0)
                                ? PRIMARY_COLOR
                                : (details?.status == 1)
                                    ? COMPLEMENTARY_COLOR2
                                    : SECONDARY_COLOR),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(8)),
                      border: Border.fromBorderSide(
                        BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.all(6),
                                child: const FittedBox(
                                  alignment: Alignment.centerLeft,
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
                                padding: EdgeInsets.all(6),
                                child: FittedBox(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      ': ${(data?.customer == null) ? "-" : data?.customer?.name}',
                                      style: titleTextBlack),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.all(6),
                                child: const FittedBox(
                                  alignment: Alignment.centerLeft,
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
                                padding: EdgeInsets.all(6),
                                child: FittedBox(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      ': ${(details?.isHasGrade == false) ? "Single" : (details?.tubeGrade == null) ? '-' : details?.tubeGrade}',
                                      style: titleTextBlack),
                                ),
                              ),
                            )
                          ],
                        )),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.all(6),
                                child: const FittedBox(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Kondisi',
                                    style: titleTextBlack,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.all(6),
                                child: const FittedBox(
                                  alignment: Alignment.centerLeft,
                                  child: Text(': -', style: titleTextBlack),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.all(6),
                                child: const FittedBox(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Lokasi',
                                    style: titleTextBlack,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.all(6),
                                child: FittedBox(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      ': ${(details?.lastLocation == null) ? "-" : details!.lastLocation}',
                                      style: titleTextBlack),
                                ),
                              ),
                            )
                          ],
                        )),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.all(6),
                                child: const FittedBox(
                                  alignment: Alignment.centerLeft,
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
                                padding: EdgeInsets.all(6),
                                child: FittedBox(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      ': ${(details?.isOwnership == 0) ? "-" : (details?.isOwnership == 1) ? "Assets" : "Pelanggan"}',
                                      style: titleTextBlack),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(),
                            )
                          ],
                        )),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.all(6),
                                child: FittedBox(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '${(details?.createdAt != null) ? provider.formatDate(details!.createdAt.toString()) : "-"} | ${(details?.createdAt != null) ? provider.formatTime(details!.createdAt.toString()) : "-"}',
                                    style: TextStyle(
                                      fontFamily: 'Manrope',
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.topRight,
                                child: (details?.status == 9)
                                    ? SizedBox.shrink()
                                    : IconButton(
                                        onPressed: () async {
                                          showModalBottomSheet(
                                            context: context,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
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
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // Bagian Atas (Title)
                                                    Center(
                                                      child: Text(
                                                        'Yakin Ingin Menghapus',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 16),
                                                    // Bagian Tengah (Form)
                                                    WidgetForm(
                                                        controller: reason,
                                                        alert:
                                                            'Harus di isi jika ingin menghapus data',
                                                        hint:
                                                            "Masukkan Alasan"),
                                                    SizedBox(height: 16),
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
                                                            onpressed:
                                                                () async {
                                                              if (details
                                                                      ?.status ==
                                                                  1) {
                                                                showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return AlertDialog(
                                                                      title: Text(
                                                                          'Tabung sudah diverifikasi'),
                                                                      content: Text(
                                                                          'Yakin ingin menghapus?'),
                                                                      actions: <Widget>[
                                                                        // Tombol Batal
                                                                        WidgetButtonCustom(
                                                                            FullWidth: width *
                                                                                0.2,
                                                                            FullHeight: height *
                                                                                0.05,
                                                                            title:
                                                                                "Kembali",
                                                                            bgColor:
                                                                                PRIMARY_COLOR,
                                                                            onpressed:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            color:
                                                                                PRIMARY_COLOR),
                                                                        // Tombol Hapus
                                                                        WidgetButtonCustom(
                                                                            FullWidth: width *
                                                                                0.2,
                                                                            FullHeight: height *
                                                                                0.05,
                                                                            bgColor:
                                                                                SECONDARY_COLOR,
                                                                            title:
                                                                                "Hapus",
                                                                            onpressed:
                                                                                () async {
                                                                              Navigator.pop(context);
                                                                              // print("No BPTK : ${data!.noBptk}\nId : ${details!.id}\nReason : ${reason.text}");
                                                                              await provider.deleteDetail(context, data!.noBptk!, details!.id!, reason.text);
                                                                            },
                                                                            color:
                                                                                SECONDARY_COLOR),
                                                                      ],
                                                                    );
                                                                  },
                                                                );
                                                              } else {
                                                                // print(
                                                                //     "No BPTK : ${data!.noBptk}\nId : ${details!.id}\nReason : ${reason.text}");
                                                                await provider
                                                                    .deleteDetail(
                                                                        context,
                                                                        data!
                                                                            .noBptk!,
                                                                        details!
                                                                            .id!,
                                                                        reason
                                                                            .text);
                                                              }
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
                                        icon: Icon(
                                          Icons.delete,
                                          size: 20,
                                          color: SECONDARY_COLOR,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
