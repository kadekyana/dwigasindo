import 'dart:async';

import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/providers/provider_scan.dart';
import 'package:dwigasindo/views/menus/component_distribusi/componentBPTK/component_scan_qrcode.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: const CircularProgressIndicator(),
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      width: width,
                      height: height * 0.2,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      decoration: BoxDecoration(
                        color: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(),
                          SizedBox(
                            height: 24.h,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                '${data?.noBptk} | ${(data?.createdAt == null) ? "-" : provider.formatDate(data!.createdAt.toString())}',
                                style: titleText,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Jenis',
                                          style: subtitleTextNormalwhite,
                                        ),
                                      ),
                                      Text(
                                        ' : ',
                                        style: subtitleTextNormalwhite,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          '\t${data?.gasType}',
                                          style: subtitleTextNormalwhite,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Driver',
                                          style: subtitleTextNormalwhite,
                                        ),
                                      ),
                                      Text(
                                        ':',
                                        style: subtitleTextNormalwhite,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          '\t${data!.driver?.name}',
                                          overflow: TextOverflow.ellipsis,
                                          style: subtitleTextNormalwhite,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Jumlah',
                                          style: subtitleTextNormalwhite,
                                        ),
                                      ),
                                      Text(
                                        ' : ',
                                        style: titleTextNormalWhite,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          '\t${data.count}',
                                          style: subtitleTextNormalwhite,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Sumber',
                                          style: subtitleTextNormalwhite,
                                        ),
                                      ),
                                      Text(
                                        ' : ',
                                        style: subtitleTextNormalwhite,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          '${data.customer?.name}',
                                          overflow: TextOverflow.ellipsis,
                                          style: subtitleTextNormalwhite,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                WidgetButtonCustom(
                                    FullWidth: width * 0.2,
                                    FullHeight: 30.h,
                                    title: 'Tambah',
                                    onpressed: () async {
                                      if (!mounted) return;

                                      // Tampilkan Dialog Loading
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                      );

                                      try {
                                        await Future.wait([
                                          providerS.clearResults(),
                                          providerS.clearScannedCount(),
                                        ]);

                                        // Navigate sesuai kondisi
                                        Navigator.of(context)
                                            .pop(); // Tutup Dialog Loading
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ComponentScanQrCode(
                                                    noBptk: data.noBptk!,
                                                  )),
                                        );
                                      } catch (e) {
                                        Navigator.of(context)
                                            .pop(); // Tutup Dialog Loading
                                        print('Error: $e');
                                        // Tambahkan pesan error jika perlu
                                      }
                                    },
                                    bgColor:
                                        const Color.fromARGB(255, 55, 72, 199),
                                    color: Colors.transparent),
                                SizedBox(
                                  width: 10.w,
                                ),
                                WidgetButtonCustom(
                                    FullWidth: 60.w,
                                    FullHeight: 30.h,
                                    title: 'Ubah',
                                    onpressed: () {},
                                    bgColor:
                                        const Color.fromARGB(255, 55, 72, 199),
                                    color: Colors.transparent),
                                SizedBox(
                                  width: 10.w,
                                ),
                                WidgetButtonCustom(
                                    FullWidth: 80.w,
                                    FullHeight: 30.h,
                                    title: 'Selesai',
                                    onpressed: () {},
                                    bgColor: SECONDARY_COLOR,
                                    color: Colors.transparent)
                              ],
                            ),
                          ),
                          const Spacer(),
                        ],
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
            height: 200.h,
            margin: EdgeInsets.only(bottom: height * 0.01),
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
                  height: 40.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: width * 0.3,
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: (details?.status == 0)
                              ? PRIMARY_COLOR
                              : (details?.status == 1)
                                  ? COMPLEMENTARY_COLOR2
                                  : SECONDARY_COLOR,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '${details?.tubeCode}',
                            style: titleText,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 5.w),
                        child: WidgetButtonCustom(
                            FullWidth: width * 0.25,
                            FullHeight: 30,
                            title: 'Riwayat',
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
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(8)),
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
                              child: Text(
                                'Produk',
                                style: subtitleTextBlack,
                              ),
                            ),
                            Text(
                              " : ",
                              style: subtitleTextBlack,
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                  '${(data?.customer == null) ? "-" : data?.customer?.name}',
                                  overflow: TextOverflow.ellipsis,
                                  style: subtitleTextBlack),
                            ),
                          ],
                        )),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Grade',
                                style: subtitleTextBlack,
                              ),
                            ),
                            Text(
                              " : ",
                              style: subtitleTextBlack,
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                  '${(details?.isHasGrade == false) ? "Single" : (details?.tubeGrade == null) ? '-' : details?.tubeGrade}',
                                  overflow: TextOverflow.ellipsis,
                                  style: subtitleTextBlack),
                            )
                          ],
                        )),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Kondisi',
                                  style: subtitleTextBlack,
                                ),
                              ),
                              Text(
                                ' : ',
                                style: subtitleTextBlack,
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  '-',
                                  style: subtitleTextBlack,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Lokasi',
                                  style: subtitleTextBlack,
                                ),
                              ),
                              Text(
                                ' : ',
                                style: subtitleTextBlack,
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  '${(details?.lastLocation == null) ? "-" : details!.lastLocation}',
                                  style: subtitleTextBlack,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                'Milik',
                                style: subtitleTextBlack,
                              ),
                            ),
                            Text(
                              ' : ',
                              style: subtitleTextBlack,
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                  (details?.isOwnership == 0)
                                      ? "-"
                                      : (details?.isOwnership == 1)
                                          ? "Assets"
                                          : "Pelanggan",
                                  style: subtitleTextBlack),
                            ),
                          ],
                        )),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Dibuat pada',
                                style: subtitleTextNormal,
                              ),
                            ),
                            Text(
                              ' : ',
                              style: subtitleTextNormal,
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                  "${(details?.createdAt != null) ? provider.formatDate(details!.createdAt.toString()) : "-"} | ${(details?.createdAt != null) ? provider.formatTime(details!.createdAt.toString()) : "-"}",
                                  style: subtitleTextNormal),
                            ),
                            SizedBox(
                              width: 80.w,
                              child: (details?.status == 9)
                                  ? const SizedBox.shrink()
                                  : Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                        onPressed: () async {
                                          showModalBottomSheet(
                                            context: context,
                                            shape: const RoundedRectangleBorder(
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
                                                      16.h,
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
                                                          style:
                                                              titleTextBlack),
                                                    ),
                                                    SizedBox(height: 16.h),
                                                    // Bagian Tengah (Form)
                                                    WidgetForm(
                                                        controller: reason,
                                                        alert:
                                                            'Harus di isi jika ingin menghapus data',
                                                        hint:
                                                            "Masukkan Alasan"),
                                                    SizedBox(height: 16.h),
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
                                                                      title: const Text(
                                                                          'Tabung sudah diverifikasi'),
                                                                      content:
                                                                          const Text(
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
                                        icon: const Icon(
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
