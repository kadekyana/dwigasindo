import 'dart:async';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/providers/provider_scan.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_newCard.dart';
import 'package:dwigasindo/widgets/widget_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class ComponentVerifikasi extends StatefulWidget {
  ComponentVerifikasi({super.key, required this.noBptk});
  String noBptk;
  @override
  State<ComponentVerifikasi> createState() => _ComponentVerifikasiState();
}

class _ComponentVerifikasiState extends State<ComponentVerifikasi> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Memanggil data pertama kali setelah widget diinisialisasi
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ProviderDistribusi>(context, listen: false);
      provider.getVerifikasiBPTK(context, widget.noBptk);
    });

    // Memanggil getVerifikasiBPTK setiap 2 detik
    _timer = Timer.periodic(const Duration(milliseconds: 500), (Timer timer) {
      final provider = Provider.of<ProviderDistribusi>(context, listen: false);
      provider.getVerifikasiBPTK(context, widget.noBptk);
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
    final provider = Provider.of<ProviderDistribusi>(context);
    final dataVer = provider.verifikasiBptk?.data;
    final providerS = Provider.of<ProviderScan>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return PopScope(
      onPopInvoked: (didPop) async {
        await provider.clearCount('countT');
      },
      child: Scaffold(
        appBar: WidgetAppbar(
          title: 'Verifikasi Tabung',
          colorBG: Colors.grey.shade100,
          colorBack: Colors.black,
          colorTitle: Colors.black,
          center: true,
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
            : SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Column(
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: height * 0.2,
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                          color: PRIMARY_COLOR,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Spacer(),
                            Expanded(
                                flex: 2,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '${dataVer?.noBptk} | ${(dataVer?.createdAt == null) ? "-" : provider.formatDate(dataVer!.createdAt.toString())}',
                                    style: titleText,
                                  ),
                                )),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Jenis Gas',
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
                                            '\t${dataVer?.gasType}',
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
                                            '\t${dataVer!.driver?.name}',
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
                                            '\t${dataVer.count}',
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
                                            '${dataVer.customer?.name}',
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
                            SizedBox(
                              height: height * 0.02,
                            ),
                            const WidgetProgressBar(),
                            const Spacer(),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        height: height * 0.05,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 25.w,
                              height: 25.h,
                              child: SvgPicture.asset(
                                  'assets/images/button_plus.svg'),
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            Expanded(
                              child: Text(
                                'Verifikasi Tabung',
                                style: titleTextNormal,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                WoltModalSheet.show(
                                  context: context,
                                  pageListBuilder: (bottomSheetContext) => [
                                    SliverWoltModalSheetPage(
                                      topBarTitle: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Filter', style: titleTextBlack),
                                          TextButton(
                                            onPressed: () {},
                                            child: const Text(
                                              'Reset',
                                              style: TextStyle(
                                                  color: COMPLEMENTARY_COLOR3,
                                                  fontFamily: 'Manrope'),
                                            ),
                                          )
                                        ],
                                      ),
                                      isTopBarLayerAlwaysVisible: true,
                                      navBarHeight: 60,
                                      mainContentSliversBuilder: (context) => [
                                        SliverList.builder(
                                          itemCount: 1,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              children: [
                                                SizedBox(
                                                  height: height * 0.02,
                                                ),
                                                Container(
                                                  width: double.maxFinite,
                                                  height: 20,
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: width * 0.04),
                                                  child: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      'Status',
                                                      style: titleTextNormal,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: double.maxFinite,
                                                    height: 80,
                                                    child: GroupButton(
                                                        isRadio: false,
                                                        options:
                                                            GroupButtonOptions(
                                                          buttonWidth:
                                                              width * 0.3,
                                                          unselectedTextStyle:
                                                              subtitleTextBlack,
                                                          selectedTextStyle:
                                                              subtitleText,
                                                          selectedColor:
                                                              PRIMARY_COLOR,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                        ),
                                                        buttons: const [
                                                          'Terverifikasi',
                                                          'Belum Terverifikasi',
                                                          "Dihapus"
                                                        ])),
                                                SizedBox(
                                                  height: height * 0.01,
                                                ),
                                                WidgetButtonCustom(
                                                  FullWidth: width * 0.92,
                                                  FullHeight: height * 0.05,
                                                  title: 'Terapkan Filter',
                                                  onpressed: () {},
                                                  color: Colors.transparent,
                                                  bgColor: PRIMARY_COLOR,
                                                )
                                              ],
                                            );
                                          },
                                        ),
                                        // Tambahkan spacer di bagian bawah
                                        const SliverToBoxAdapter(
                                          child: SizedBox(
                                              height:
                                                  50), // Sesuaikan height dengan kebutuhan
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                              child: SizedBox(
                                width: 25,
                                height: 25,
                                child: const Icon(Icons.filter_list),
                              ),
                            ),
                          ],
                        ),
                      ),
                      WidgetButtonCustom(
                        FullWidth: width,
                        FullHeight: 40.h,
                        title: 'Tabung Numpang Lewat',
                        onpressed: () {},
                        color: PRIMARY_COLOR,
                        bgColor: PRIMARY_COLOR,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      (providerS.isNew == true)
                          ? WidgetCardNewTube(height: height, width: width)
                          : const SizedBox.shrink(),
                      Expanded(
                        child: CardVerifikasi(
                          provider: provider,
                          height: height,
                          width: width,
                          produk: dataVer.customer!.name!,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

// widget verifikasi

class CardVerifikasi extends StatefulWidget {
  const CardVerifikasi({
    super.key,
    required this.provider,
    required this.height,
    required this.width,
    required this.produk,
  });

  final ProviderDistribusi provider;
  final double height;
  final double width;
  final String produk;

  @override
  State<CardVerifikasi> createState() => _CardVerifikasiState();
}

class _CardVerifikasiState extends State<CardVerifikasi> {
  List<Map<String, dynamic>> tubeDetails = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ProviderDistribusi>(context, listen: false);
      provider.getAllTube(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderDistribusi>(context);
    return ListView.builder(
      itemCount: widget.provider.verifikasiBptk?.data?.details?.length,
      itemBuilder: (context, index) {
        // title: Text(providerScan.scannedData[index]),
        final data = widget.provider.verifikasiBptk?.data?.details?[index];
        if (data == null) return const SizedBox.shrink();
        // Container hasil scan
        return Container(
          margin: EdgeInsets.symmetric(vertical: 5.h),
          width: double.maxFinite,
          height: 180.h,
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
                      width: widget.width * 0.3,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: (data.status == 0)
                            ? PRIMARY_COLOR
                            : (data.status == 1)
                                ? COMPLEMENTARY_COLOR2
                                : SECONDARY_COLOR,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '${data.tubeCode}',
                          style: titleText,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: WidgetButtonCustom(
                        FullWidth: widget.width * 0.25,
                        FullHeight: 30.h,
                        title: 'Riwayat',
                        onpressed: () {},
                        bgColor: (data.status == 0)
                            ? PRIMARY_COLOR
                            : (data.status == 1)
                                ? COMPLEMENTARY_COLOR2
                                : SECONDARY_COLOR,
                        color: (data.status == 0)
                            ? PRIMARY_COLOR
                            : (data.status == 1)
                                ? COMPLEMENTARY_COLOR2
                                : SECONDARY_COLOR,
                      ),
                    ),
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
                        child: Padding(
                          padding: EdgeInsets.all(10.w),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: PRIMARY_COLOR),
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
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
                                  flex: 2,
                                  child: Text(
                                      (widget.produk == "")
                                          ? "-"
                                          : widget.produk,
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
                                    'Kondisi',
                                    style: subtitleTextBlack,
                                  ),
                                ),
                                Text(
                                  " : ",
                                  style: subtitleTextBlack,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '-',
                                    style: subtitleTextBlack,
                                    overflow: TextOverflow.ellipsis,
                                  ),
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
                                  flex: 2,
                                  child: Text(
                                      (data.isHasGrade == false)
                                          ? "Non Single"
                                          : "Single",
                                      style: subtitleTextBlack),
                                )
                              ],
                            )),
                            Expanded(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Lokasi',
                                    style: subtitleTextBlack,
                                  ),
                                ),
                                Text(
                                  " : ",
                                  style: subtitleTextBlack,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                      '${(data.lastLocation == null) ? "-" : data.lastLocation}',
                                      style: subtitleTextBlack),
                                )
                              ],
                            )),
                            Expanded(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Milik',
                                    style: subtitleTextBlack,
                                  ),
                                ),
                                Text(
                                  " : ",
                                  style: subtitleTextBlack,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                      (data.isOwnership == 0)
                                          ? "-"
                                          : (data.isOwnership == 1)
                                              ? "Assets"
                                              : "Pelanggan",
                                      style: subtitleTextBlack),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Text(
                          '${(data.verifiedAt == null) ? "-" : provider.formatDate(data.verifiedAt)} | ${(data.verifiedAt == null) ? "-" : provider.formatTime(data.verifiedAt)}',
                          style: subtitleTextNormal),
                    ),
                  ),
                  // Expanded(
                  //   flex: 1,
                  //   child: Align(
                  //     alignment: Alignment.topRight,
                  //     child: IconButton(
                  //       onPressed: () {},
                  //       icon: Icon(
                  //         Icons.delete,
                  //         size: 20,
                  //         color: SECONDARY_COLOR,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              )),
            ],
          ),
        );
      },
    );
  }
}
