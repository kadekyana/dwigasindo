import 'dart:async';

import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/providers/provider_scan.dart';
import 'package:dwigasindo/views/menus/component_distribusi/componentTabung/component_tambah_tabung.dart';
import 'package:dwigasindo/views/menus/component_distribusi/componentTabung/component_update_tabung.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_grafik.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../../../model/modelTube.dart';

class ComponentTabung extends StatefulWidget {
  const ComponentTabung({super.key});

  @override
  State<ComponentTabung> createState() => _ComponentTabungState();
}

class _ComponentTabungState extends State<ComponentTabung> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 500), (Timer timer) {
      final provider = Provider.of<ProviderDistribusi>(context, listen: false);
      provider.getAllTube(context);
      provider.getAllTubeGrade(context);
      provider.getAllTubeType(context);
      provider.getAllTubeGas(context);
      provider.getAllCostumer(context);
      provider.getAllSupplier(context);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderDistribusi>(context);
    final data = provider.tube?.data;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    print(
        "DATA ${provider.tubeGrades?.data}\n${provider.tubeTypes?.data}\n${provider.tubeGas?.data}\n${provider.customer?.data}");

    return PopScope(
      onPopInvoked: (didPop) {
        provider.countClear();
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
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
        body: (provider.isLoadingTube == true)
            ? const Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(),
                ),
              )
            : SafeArea(
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
                              title: const Text(
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
                              title: const Text(
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
                              title: const Text(
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
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                      width: double.maxFinite,
                      height: height * 0.05,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              _timer?.cancel();
                              final provider = Provider.of<ProviderDistribusi>(
                                  context,
                                  listen: false);
                              await provider.getAllTubeGrade(context);
                              await provider.getAllTubeType(context);
                              await provider.getAllTubeGas(context);
                              await provider.getAllCostumer(context);
                              await provider.getAllSupplier(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ComponentTambahTabung(),
                                ),
                              );
                            },
                            child: const SizedBox(
                              width: 25,
                              height: 25,
                              child: Icon(Icons.add_circle_outline_rounded),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          const Expanded(
                            child: Text(
                              'Tambah Tabung',
                              style: subtitleTextBlack,
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
                                        const Text(
                                          'Filter',
                                          style: TextStyle(
                                              fontFamily: 'Manrope',
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700),
                                        ),
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
                                                child: const FittedBox(
                                                  alignment:
                                                      Alignment.centerLeft,
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
                                                      options:
                                                          GroupButtonOptions(
                                                        buttonWidth:
                                                            width * 0.3,
                                                        unselectedTextStyle:
                                                            TextStyle(
                                                                fontFamily:
                                                                    'Manrope',
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    width *
                                                                        0.03),
                                                        selectedTextStyle:
                                                            TextStyle(
                                                                fontFamily:
                                                                    'Manrope',
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    width *
                                                                        0.03),
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
                            child: const SizedBox(
                              width: 25,
                              height: 25,
                              child: Icon(Icons.filter_list),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: width,
                      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                      height: 20,
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        child: GroupButton(
                            options: GroupButtonOptions(
                              borderRadius: BorderRadius.circular(50),
                              buttonHeight: 10,
                              buttonWidth: width * 0.15,
                              selectedColor: PRIMARY_COLOR,
                              selectedTextStyle: const TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 6,
                                  color: Colors.white),
                              unselectedTextStyle: const TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 6,
                                  color: Colors.black),
                            ),
                            buttons: const [
                              'All',
                              'Tabung Kosong',
                              'Tabung Terisi'
                            ]),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Expanded(
                      flex: 3,
                      child: Consumer<ProviderDistribusi>(
                        builder: (context, provider, child) {
                          final data = provider.tube
                              ?.data; // Fetch the latest data inside the Consumer
                          if (data == null || data.isEmpty) {
                            return const Center(
                                child: Text('No data available'));
                          }

                          return ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final item =
                                  data[index]; // Fetch the item based on index

                              return WidgetCard(
                                  width: width,
                                  height: height,
                                  item: item,
                                  timer: _timer);
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

class WidgetCard extends StatelessWidget {
  const WidgetCard({
    super.key,
    required this.width,
    required this.height,
    required this.item,
    required Timer? timer,
  }) : _timer = timer;

  final double width;
  final double height;
  final Datum item;
  final Timer? _timer;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderDistribusi>(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: width * 0.05),
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
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${(item.code != null) ? item.code : "-"}",
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
                                flex: 1,
                                child: Container(
                                  padding: const EdgeInsets.all(3),
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
                                  padding: const EdgeInsets.all(3),
                                  child: FittedBox(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        ': ${(item.ownerShipType != null) ? provider.getOwner(item.ownerShipType!) : "-"}',
                                        style: titleTextBlack),
                                  ),
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
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  child: const FittedBox(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Sumber',
                                      style: titleTextBlack,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  child: FittedBox(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        ': ${(item.customerId != null) ? item.customerName : item.vendorId != null ? item.vendorName : "-"}',
                                        style: titleTextBlack),
                                  ),
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
                                child: Container(
                                  padding: const EdgeInsets.all(3),
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
                                  padding: const EdgeInsets.all(3),
                                  child: const FittedBox(
                                    alignment: Alignment.centerLeft,
                                    child: Text(': -', style: titleTextBlack),
                                  ),
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
                                child: Container(
                                  padding: const EdgeInsets.all(3),
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
                                  padding: const EdgeInsets.all(3),
                                  child: FittedBox(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        ': ${(item.tubeGradeId == null) ? "-" : provider.getGrade(item.tubeGradeId!)}',
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
                                  padding: const EdgeInsets.all(3),
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
                                  padding: const EdgeInsets.all(3),
                                  child: FittedBox(
                                    alignment: Alignment.centerLeft,
                                    child: Text(': ${item.lastLocation}',
                                        style: titleTextBlack),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
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
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () async {
                        _timer?.cancel();
                        provider.isLoadingT = true;
                        Provider.of<ProviderScan>(context, listen: false)
                            .getDataCard(context, item.code!);
                        Future.delayed(const Duration(seconds: 1), () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ComponentUpdateTabung(
                                code: item.idStr!,
                              ),
                            ),
                          );
                        });
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
                                        // print(
                                        //     "No BPTK : ${item!.noBptk}\nId : ${details!.id}\nReason : ${reason.text}");
                                        // await provider.deleteDetail(context,
                                        //     item.noBptk!, details.id!, reason.text);
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
          )),
        ],
      ),
    );
  }
}
