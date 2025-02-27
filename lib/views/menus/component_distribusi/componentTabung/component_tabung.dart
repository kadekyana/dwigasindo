import 'dart:async';

import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/providers/provider_scan.dart';
import 'package:dwigasindo/views/menus/component_distribusi/componentBPTK/component_tambah_cradle.dart';
import 'package:dwigasindo/views/menus/component_distribusi/componentTabung/component_tambah_tabung.dart';
import 'package:dwigasindo/views/menus/component_distribusi/componentTabung/component_update_tabung.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_grafik.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class ComponentTabung extends StatefulWidget {
  const ComponentTabung({super.key});

  @override
  State<ComponentTabung> createState() => _ComponentTabungState();
}

class _ComponentTabungState extends State<ComponentTabung> {
  Timer? _timer;
  GroupButtonController? cek = GroupButtonController(selectedIndex: 0);
  bool isTube = true;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderDistribusi>(context);
    final data = provider.tube?.data;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return PopScope(
      onPopInvoked: (didPop) {
        provider.countClear();
      },
      child: Scaffold(
        appBar: WidgetAppbar(
          title: 'Persentase',
          center: true,
          back: true,
          colorBG: Colors.grey.shade100,
          colorBack: Colors.black,
          colorTitle: Colors.black,
          route: () {
            Navigator.pop(context);
            provider.countClear();
          },
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Menampilkan grafik
              Container(
                width: width,
                height: height * 0.3,
                margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                padding: EdgeInsets.symmetric(vertical: height * 0.02),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: PRIMARY_COLOR,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text(
                          'Tabung Asset',
                          style: titleText,
                        ),
                        subtitle: WidgetGrafik(
                          percentage: 75,
                          text:
                              "${(provider.tabungA == 0) ? 0 : provider.tabungA}",
                          width: width * 0.8,
                          height: height * 0.025,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text(
                          'Tabung Pelanggan',
                          style: titleText,
                        ),
                        subtitle: WidgetGrafik(
                          percentage: 50,
                          text:
                              "${(provider.tabungP == 0) ? 0 : provider.tabungP}",
                          width: width * 0.8,
                          height: height * 0.025,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text(
                          'Total Tabung',
                          style: titleText,
                        ),
                        subtitle: WidgetGrafik(
                          percentage: 50,
                          text: "${data?.length}",
                          width: width * 0.8,
                          height: height * 0.025,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Button Simpan
              SizedBox(
                height: 10.h,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                width: double.maxFinite,
                height: height * 0.05,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: GroupButton(
                        controller: cek,
                        options: GroupButtonOptions(
                            borderRadius: BorderRadius.circular(50),
                            selectedColor: PRIMARY_COLOR,
                            mainGroupAlignment: MainGroupAlignment.start,
                            crossGroupAlignment: CrossGroupAlignment.start),
                        buttons: const ["Tabung", "Cradle"],
                        onSelected: (value, index, isSelected) {
                          if (index == 0) {
                            setState(() {
                              isTube = true;
                            });
                          } else {
                            setState(() {
                              isTube = false;
                            });
                          }
                        },
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
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Status',
                                              style: titleTextBlack,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            width: double.maxFinite,
                                            height: 80,
                                            child: GroupButton(
                                                isRadio: false,
                                                options: GroupButtonOptions(
                                                  textAlign: TextAlign.center,
                                                  buttonWidth: width * 0.3,
                                                  unselectedTextStyle:
                                                      subtitleTextBlack,
                                                  selectedTextStyle:
                                                      subtitleText,
                                                  selectedColor: PRIMARY_COLOR,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
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
              SizedBox(
                height: 10.h,
              ),
              if (isTube == true)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: WidgetButtonCustom(
                    FullWidth: width,
                    FullHeight: 40.h,
                    title: 'Tambah Tabung',
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
                      _timer?.cancel();
                      final provider = Provider.of<ProviderDistribusi>(context,
                          listen: false);

                      try {
                        await Future.wait([
                          provider.getAllTubeGrade(context),
                          provider.getAllTubeType(context),
                          provider.getAllTubeGas(context),
                          provider.getAllCostumer(context),
                          provider.getAllSupplier(context),
                        ]);

                        // Navigate sesuai kondisi
                        Navigator.of(context).pop(); // Tutup Dialog Loading
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ComponentTambahTabung(),
                          ),
                        );
                      } catch (e) {
                        Navigator.of(context).pop(); // Tutup Dialog Loading
                        print('Error: $e');
                        // Tambahkan pesan error jika perlu
                      }
                    },
                    color: PRIMARY_COLOR,
                    bgColor: PRIMARY_COLOR,
                  ),
                ),
              if (isTube == false)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: WidgetButtonCustom(
                    FullWidth: width,
                    FullHeight: 40.h,
                    title: 'Tambah Cradle',
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
                      _timer?.cancel();
                      final provider = Provider.of<ProviderDistribusi>(context,
                          listen: false);

                      try {
                        await Future.wait([
                          provider.createCradle(context),
                        ]);

                        // Navigate sesuai kondisi
                        Navigator.of(context).pop(); // Tutup Dialog Loading
                      } catch (e) {
                        Navigator.of(context).pop(); // Tutup Dialog Loading
                        print('Error: $e');
                        // Tambahkan pesan error jika perlu
                      }
                    },
                    color: PRIMARY_COLOR,
                    bgColor: PRIMARY_COLOR,
                  ),
                ),
              SizedBox(
                height: 10.h,
              ),
              if (cek?.selectedIndex == 0)
                Expanded(
                  flex: 3,
                  child: Consumer<ProviderDistribusi>(
                    builder: (context, provider, child) {
                      final data = provider.tube
                          ?.data; // Fetch the latest data inside the Consumer
                      if (data == null || data.isEmpty) {
                        return const Center(child: Text('No data available'));
                      } else {
                        print(data);
                      }

                      return ListView.builder(
                        itemCount: provider.tube?.data?.length,
                        itemBuilder: (context, index) {
                          final item = provider.tube?.data?[index];

                          print(item);

                          return Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: width * 0.05),
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
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            item?.code ?? "-",
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
                                          child: Container(
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
                                                            const EdgeInsets
                                                                .all(3),
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            'Milik',
                                                            style:
                                                                subtitleTextBoldBlack,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3),
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                              ': ${(item?.ownerShipType == 1) ? "Asset" : "Customer"}',
                                                              style:
                                                                  subtitleTextBoldBlack),
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
                                                            const EdgeInsets
                                                                .all(3),
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            'Sumber',
                                                            style:
                                                                subtitleTextBoldBlack,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3),
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                              ': ${item?.customerName ?? "-"}',
                                                              style:
                                                                  subtitleTextBoldBlack),
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
                                                            const EdgeInsets
                                                                .all(3),
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            'Serial Number',
                                                            style:
                                                                subtitleTextBoldBlack,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3),
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                              ': ${item?.serialNumber ?? "-"}',
                                                              style:
                                                                  subtitleTextBoldBlack),
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
                                                            const EdgeInsets
                                                                .all(3),
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            'Jenis Gas',
                                                            style:
                                                                subtitleTextBoldBlack,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3),
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                              ': ${item?.tubeGradeName}',
                                                              style:
                                                                  subtitleTextBoldBlack),
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
                                                            const EdgeInsets
                                                                .all(3),
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            'Grade',
                                                            style:
                                                                subtitleTextBoldBlack,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3),
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                              ': ${(item?.tubeGradeId == null) ? "-" : provider.getGrade(item!.tubeGradeId!)}',
                                                              style:
                                                                  subtitleTextBoldBlack),
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
                                                            const EdgeInsets
                                                                .all(3),
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            'Lokasi',
                                                            style:
                                                                subtitleTextBoldBlack,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3),
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                              ': ${item?.lastLocation ?? "-"}',
                                                              style:
                                                                  subtitleTextBoldBlack),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )),
                                              ],
                                            ),
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
                                      flex: 1,
                                      child: Container(
                                        padding: const EdgeInsets.all(13),
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.centerLeft,
                                          child: Text('12-08-2024 10:30:00',
                                              style: subtitleTextNormal),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            onPressed: () async {
                                              // Tampilkan Dialog Loading
                                              showDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                builder:
                                                    (BuildContext context) {
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                },
                                              );
                                              _timer?.cancel();
                                              final provider =
                                                  Provider.of<ProviderScan>(
                                                      context,
                                                      listen: false);

                                              try {
                                                await Future.wait([
                                                  provider.getDataCard(
                                                      context, item!.code!),
                                                ]);

                                                // Navigate sesuai kondisi
                                                Navigator.of(context)
                                                    .pop(); // Tutup Dialog Loading
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ComponentUpdateTabung(
                                                      code: item.idStr!,
                                                    ),
                                                  ),
                                                );
                                              } catch (e) {
                                                Navigator.of(context)
                                                    .pop(); // Tutup Dialog Loading
                                                print('Error: $e');
                                                // Tambahkan pesan error jika perlu
                                              }
                                            },
                                            icon: const Icon(
                                              Icons.edit,
                                              size: 20,
                                              color: PRIMARY_COLOR,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return SizedBox(
                                                    width: width * 0.8,
                                                    height: height * 0.1,
                                                    child: AlertDialog(
                                                      title: const Text(
                                                          'Yakin ingin menghapus?'),
                                                      actions: <Widget>[
                                                        // Tombol Batal
                                                        WidgetButtonCustom(
                                                            FullWidth:
                                                                width * 0.2,
                                                            FullHeight:
                                                                height * 0.05,
                                                            title: "Kembali",
                                                            bgColor:
                                                                PRIMARY_COLOR,
                                                            onpressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            color:
                                                                PRIMARY_COLOR),
                                                        // Tombol Hapus
                                                        WidgetButtonCustom(
                                                            FullWidth:
                                                                width * 0.2,
                                                            FullHeight:
                                                                height * 0.05,
                                                            bgColor:
                                                                SECONDARY_COLOR,
                                                            title: "Hapus",
                                                            onpressed:
                                                                () async {
                                                              Navigator.pop(
                                                                  context);
                                                              print(
                                                                  item?.idStr);
                                                              // print(
                                                              //     "No BPTK : ${item!.noBptk}\nId : ${details!.id}\nReason : ${reason.text}");
                                                              await provider
                                                                  .deleteTube(
                                                                context,
                                                                item!.idStr!,
                                                              );
                                                            },
                                                            color:
                                                                SECONDARY_COLOR),
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
                                        ],
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
              if (cek?.selectedIndex == 1)
                Expanded(
                  flex: 3,
                  child: Consumer<ProviderDistribusi>(
                    builder: (context, provider, child) {
                      final data = provider.cradle
                          ?.data; // Fetch the latest data inside the Consumer
                      if (data == null || data.isEmpty) {
                        return const Center(child: Text('No data available'));
                      }

                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final item = data[index];
                          return Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: width * 0.05),
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
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            item.no ?? "-",
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
                                          child: Container(
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
                                                            const EdgeInsets
                                                                .all(3),
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            'Milik',
                                                            style:
                                                                subtitleTextBoldBlack,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3),
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                              ': ${(item.ownerShipType == 1) ? "Asset" : "Customer"}',
                                                              style:
                                                                  subtitleTextBoldBlack),
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
                                                            const EdgeInsets
                                                                .all(3),
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            'Sumber',
                                                            style:
                                                                subtitleTextBoldBlack,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3),
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                              ': ${item.name ?? "-"}',
                                                              style:
                                                                  subtitleTextBoldBlack),
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
                                                            const EdgeInsets
                                                                .all(3),
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            'Jenis Gas',
                                                            style:
                                                                subtitleTextBoldBlack,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3),
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                              ': ${item.tubeGasName ?? "-"}',
                                                              style:
                                                                  subtitleTextBoldBlack),
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
                                                            const EdgeInsets
                                                                .all(3),
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            'Grade',
                                                            style:
                                                                subtitleTextBoldBlack,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3),
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                              ': ${item.tubeGradeName}',
                                                              style:
                                                                  subtitleTextBoldBlack),
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
                                                            const EdgeInsets
                                                                .all(3),
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            'Type Gas',
                                                            style:
                                                                subtitleTextBoldBlack,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3),
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                              ': ${item.tubeTypeName ?? "-"}',
                                                              style:
                                                                  subtitleTextBoldBlack),
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
                                                            const EdgeInsets
                                                                .all(3),
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            'Lokasi',
                                                            style:
                                                                subtitleTextBoldBlack,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3),
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                              ': ${item.location ?? "-"}',
                                                              style:
                                                                  subtitleTextBoldBlack),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )),
                                              ],
                                            ),
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
                                      flex: 1,
                                      child: Container(
                                        padding: const EdgeInsets.all(13),
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.centerLeft,
                                          child: Text('12-08-2024 10:30:00',
                                              style: subtitleTextNormal),
                                        ),
                                      ),
                                    ),
                                    // Expanded(
                                    //   flex: 1,
                                    //   child: Row(
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.end,
                                    //     children: [
                                    //       IconButton(
                                    //         onPressed: () async {
                                    //           // Tampilkan Dialog Loading
                                    //           showDialog(
                                    //             context: context,
                                    //             barrierDismissible: false,
                                    //             builder:
                                    //                 (BuildContext context) {
                                    //               return const Center(
                                    //                 child:
                                    //                     CircularProgressIndicator(),
                                    //               );
                                    //             },
                                    //           );
                                    //           _timer?.cancel();
                                    //           final provider =
                                    //               Provider.of<ProviderScan>(
                                    //                   context,
                                    //                   listen: false);

                                    //           try {
                                    //             await Future.wait([
                                    //               provider.getDataCard(
                                    //                   context, item.code!),
                                    //             ]);

                                    //             // Navigate sesuai kondisi
                                    //             Navigator.of(context)
                                    //                 .pop(); // Tutup Dialog Loading
                                    //             Navigator.push(
                                    //               context,
                                    //               MaterialPageRoute(
                                    //                 builder: (context) =>
                                    //                     ComponentUpdateTabung(
                                    //                   code: item.idStr!,
                                    //                 ),
                                    //               ),
                                    //             );
                                    //           } catch (e) {
                                    //             Navigator.of(context)
                                    //                 .pop(); // Tutup Dialog Loading
                                    //             print('Error: $e');
                                    //             // Tambahkan pesan error jika perlu
                                    //           }
                                    //         },
                                    //         icon: const Icon(
                                    //           Icons.edit,
                                    //           size: 20,
                                    //           color: PRIMARY_COLOR,
                                    //         ),
                                    //       ),
                                    //       IconButton(
                                    //         onPressed: () {
                                    //           showDialog(
                                    //             context: context,
                                    //             builder:
                                    //                 (BuildContext context) {
                                    //               return SizedBox(
                                    //                 width: width * 0.8,
                                    //                 height: height * 0.1,
                                    //                 child: AlertDialog(
                                    //                   title: const Text(
                                    //                       'Yakin ingin menghapus?'),
                                    //                   actions: <Widget>[
                                    //                     // Tombol Batal
                                    //                     WidgetButtonCustom(
                                    //                         FullWidth:
                                    //                             width * 0.2,
                                    //                         FullHeight:
                                    //                             height * 0.05,
                                    //                         title: "Kembali",
                                    //                         bgColor:
                                    //                             PRIMARY_COLOR,
                                    //                         onpressed: () {
                                    //                           Navigator.pop(
                                    //                               context);
                                    //                         },
                                    //                         color:
                                    //                             PRIMARY_COLOR),
                                    //                     // Tombol Hapus
                                    //                     WidgetButtonCustom(
                                    //                         FullWidth:
                                    //                             width * 0.2,
                                    //                         FullHeight:
                                    //                             height * 0.05,
                                    //                         bgColor:
                                    //                             SECONDARY_COLOR,
                                    //                         title: "Hapus",
                                    //                         onpressed:
                                    //                             () async {
                                    //                           Navigator.pop(
                                    //                               context);
                                    //                           print(
                                    //                               item?.idStr);
                                    //                           // print(
                                    //                           //     "No BPTK : ${item!.noBptk}\nId : ${details!.id}\nReason : ${reason.text}");
                                    //                           await provider
                                    //                               .deleteTube(
                                    //                             context,
                                    //                             item!.idStr!,
                                    //                           );
                                    //                         },
                                    //                         color:
                                    //                             SECONDARY_COLOR),
                                    //                   ],
                                    //                 ),
                                    //               );
                                    //             },
                                    //           );
                                    //         },
                                    //         icon: const Icon(
                                    //           Icons.delete,
                                    //           size: 20,
                                    //           color: SECONDARY_COLOR,
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
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
    );
  }
}

class WidgetCardCradle extends StatelessWidget {
  const WidgetCardCradle({
    super.key,
    required this.width,
    required this.height,
    required this.item,
  });

  final double width;
  final double height;
  final dynamic item;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderDistribusi>(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: width * 0.05),
      width: double.maxFinite,
      height: 150.h,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${(item.no != null) ? item.no : "-"}",
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
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: PRIMARY_COLOR),
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: const EdgeInsets.all(3),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Jumlah Tabung',
                                        style: subtitleTextBoldBlack,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: const EdgeInsets.all(3),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment.centerLeft,
                                      child: Text(': -',
                                          style: subtitleTextBoldBlack),
                                    ),
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
                                  flex: 2,
                                  child: Container(
                                    padding: const EdgeInsets.all(3),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Dibuat Oleh',
                                        style: subtitleTextNormal,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: const EdgeInsets.all(3),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment.centerLeft,
                                      child: Text(': User 1',
                                          style: subtitleTextNormal),
                                    ),
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
                                  flex: 2,
                                  child: Container(
                                    padding: const EdgeInsets.all(3),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Dibuat Pada',
                                        style: subtitleTextNormal,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: const EdgeInsets.all(3),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment.centerLeft,
                                      child: Text(': 24 - 11 -2025',
                                          style: subtitleTextNormal),
                                    ),
                                  ),
                                ),
                              ],
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
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () async {
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
                        provider.getAllTube(context),
                      ]);

                      // Navigate sesuai kondisi
                      Navigator.of(context).pop(); // Tutup Dialog Loading
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ComponentTambahCradle(
                            id: item.id,
                          ),
                        ),
                      );
                    } catch (e) {
                      Navigator.of(context).pop(); // Tutup Dialog Loading
                      print('Error: $e');
                      // Tambahkan pesan error jika perlu
                    }
                  },
                  icon: const Icon(
                    Icons.edit,
                    size: 20,
                    color: PRIMARY_COLOR,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          width: width * 0.8,
                          height: height * 0.1,
                          child: AlertDialog(
                            title: const Text('Yakin ingin menghapus?'),
                            actions: <Widget>[
                              // Tombol Batal
                              WidgetButtonCustom(
                                  FullWidth: width * 0.2,
                                  FullHeight: height * 0.05,
                                  title: "Kembali",
                                  bgColor: PRIMARY_COLOR,
                                  onpressed: () {
                                    Navigator.pop(context);
                                  },
                                  color: PRIMARY_COLOR),
                              // Tombol Hapus
                              WidgetButtonCustom(
                                  FullWidth: width * 0.2,
                                  FullHeight: height * 0.05,
                                  bgColor: SECONDARY_COLOR,
                                  title: "Hapus",
                                  onpressed: () async {
                                    Navigator.pop(context);
                                    await provider.deleteCradle(
                                        context, item.idStr);
                                  },
                                  color: SECONDARY_COLOR),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
