import 'package:dwigasindo/model/modelLoadingTubeMixGas.dart';
import 'package:dwigasindo/views/menus/component_produksi/produksi_c2h2/LT/component_loading_tabung.dart';
import 'package:dwigasindo/views/menus/component_produksi/produksi_c2h2/LT/isi_data_loading_tube.dart';
import 'package:dwigasindo/views/menus/component_produksi/produksi_c2h2/LT/isi_data_loading_tube_mix.dart';
import 'package:dwigasindo/views/menus/menu_scan_tube_mix.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/model/modelLoadingTube.dart';
import 'package:dwigasindo/providers/provider_produksi.dart';
import 'package:dwigasindo/views/menus/menu_scan.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';

class ComponentLoadingTabungMixGas extends StatelessWidget {
  const ComponentLoadingTabungMixGas({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    // List map untuk data
    final List<Map<String, dynamic>> items = [
      {'title': 'CO2', 'subtitle': ''},
      {'title': 'Gas', 'subtitle': '(Ar/O2/N2/CO2)'},
      {'title': 'VGL/DEWAR', 'subtitle': '(Ar/O2/N2/CO2)'},
      {'title': 'Mix Gas', 'subtitle': ''},
    ];

    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Item Produksi',
        colorBack: Colors.black,
        center: true,
        back: true,
        route: () {
          Navigator.pop(context);
        },
        colorTitle: Colors.black,
        colorBG: Colors.grey.shade100,
      ),
      body: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: items.isNotEmpty
            ? ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  final title = item['title'] ?? 'No Title';
                  final subtitle = item['subtitle'] ?? 'No Subtitle';

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ComponentLoadingTabungMixGasDetail(
                            title: item['title'],
                            fill: index,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.symmetric(
                        vertical: height * 0.01,
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.05, vertical: height * 0.02),
                      height: 100.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 2,
                              offset: const Offset(0, 3),
                              color: Colors.grey.shade300),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: width * 0.1,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/images/distribusi.png'),
                              ),
                            ),
                          ),
                          SizedBox(width: width * 0.03),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(title, style: titleTextBlack),
                                const SizedBox(height: 5),
                                Text(subtitle, style: subtitleTextBlack),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: Text(
                  'No Data Available',
                  style: subtitleTextNormal,
                ),
              ),
      ),
    );
  }
}

class ComponentLoadingTabungMixGasDetail extends StatefulWidget {
  ComponentLoadingTabungMixGasDetail(
      {super.key, required this.title, required this.fill});
  String title;
  int fill;

  @override
  _ComponentLoadingTabungMixGasDetailState createState() =>
      _ComponentLoadingTabungMixGasDetailState();
}

class _ComponentLoadingTabungMixGasDetailState
    extends State<ComponentLoadingTabungMixGasDetail>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int? _selectedCardIndex;
  bool _showForm = false;
  Set<int> expandedCards = {};

  GroupButtonController? menu = GroupButtonController(selectedIndex: 0);
  bool selectMenu = true;
  final TextEditingController tare = TextEditingController();
  final TextEditingController empty = TextEditingController();

  late Map<int, StreamController<ModelLoadingTubeMixGas>> _streamControllers;

  @override
  void initState() {
    super.initState();

    // Inisialisasi StreamController untuk setiap status (tab)
    _streamControllers = {
      0: StreamController<ModelLoadingTubeMixGas>.broadcast(),
      1: StreamController<ModelLoadingTubeMixGas>.broadcast(),
      2: StreamController<ModelLoadingTubeMixGas>.broadcast(),
      3: StreamController<ModelLoadingTubeMixGas>.broadcast(),
    };

    // Mulai stream untuk setiap tab
    _startStream(0);
    _startStream(1);
    _startStream(2);
    _startStream(3);

    _tabController = TabController(length: 4, vsync: this);

    _tabController.addListener(() {
      final currentIndex = _tabController.index;

      // Mulai stream untuk tab yang aktif
      _startStream(currentIndex);
    });
  }

  void _startStream(int status) {
    Timer.periodic(const Duration(seconds: 5), (timer) async {
      if (!_streamControllers[status]!.isClosed) {
        final data = await Provider.of<ProviderProduksi>(context, listen: false)
            .getLoadingTubeMixGas(context, status, widget.fill);
        _streamControllers[status]!.add(data);
      }
    });
  }

  void _stopStream(int status) {
    _streamControllers[status]?.close();
  }

  @override
  void dispose() {
    // Tutup semua StreamController
    _tabController.dispose();
    for (var controller in _streamControllers.values) {
      controller.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: WidgetAppbar(
        title: "Loading Tabung ${widget.title}",
        colorBG: Colors.grey.shade100,
        colorTitle: Colors.black,
        colorBack: Colors.black,
        back: true,
        center: true,
        route: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Search bar
                Container(
                  width: width * 0.9,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade400,
                      ),
                      borderRadius: BorderRadius.circular(16)),
                  child: WidgetForm(
                    alert: 'Search',
                    hint: 'Search',
                    border: InputBorder.none,
                    preicon: const Icon(
                      Icons.search_rounded,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Align(
            alignment: Alignment.center,
            child: GroupButton(
                isRadio: true,
                controller: menu,
                options: GroupButtonOptions(
                  selectedColor: PRIMARY_COLOR,
                  borderRadius: BorderRadius.circular(8),
                ),
                onSelected: (value, index, isSelected) {
                  print('DATA KLIK : $value - $index - $isSelected');
                  setState(() {
                    selectMenu = index == 0;

                    // Reset TabBar setiap kali menu berubah
                    _tabController.index = 0;
                  });
                  print(selectMenu);
                },
                buttons: const ['Produksi', "QC"]),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          // TabBar untuk navigasi
          (selectMenu == true)
              ? TabBar(
                  controller: _tabController,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: const [
                    Tab(text: "Prefill"),
                    Tab(text: "Production"),
                    Tab(text: "Postfill"),
                    Tab(text: "Finish"),
                  ],
                )
              : TabBar(
                  controller: _tabController,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: const [
                    Tab(text: "Finish"),
                    Tab(text: "Status Inspeksi"),
                  ],
                ),
          (selectMenu == true)
              ? Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // Konten untuk setiap tab
                      _buildPrefillTab(width, height),
                      _buildProductionTab(width, height),
                      _buildPostfillTab(width, height),
                      _buildFinishTab(width, height),
                    ],
                  ),
                )
              : Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildSelesaiProduksiQCTab(width, height),
                      _buildKondisiTab(width, height),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildSelesaiProduksiQCTab(double width, double height) {
    return StreamBuilder<ModelLoadingTubeMixGas>(
      stream: _streamControllers[3]!.stream, // Status untuk Empty Weight
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final data = snapshot.data!.data;
          return SizedBox(
            width: width,
            height: height,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.01,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MenuScan(
                            title: 'QC',
                          ),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/scan.svg',
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(width: 5),
                        const Text('Scan Isi')
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  (data?.tubeLoadingDetail?.length != 0)
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: data?.tubeLoadingDetail!.length,
                            itemBuilder: (context, index) {
                              final dataTube = data?.tubeLoadingDetail![index];
                              return Column(
                                children: [
                                  _buildInfoCard(
                                    isOkay: true,
                                    prefill: false,
                                    production: false,
                                    postfill: false,
                                    finish: true,
                                    width: width,
                                    height: height,
                                    data: {
                                      "id": dataTube?.idStr ?? "-",
                                      "tube": dataTube?.tubeId ?? "-",
                                      "no": dataTube?.tubeNo ?? "-",
                                      'CB': dataTube?.prefillCheckBody ?? "-",
                                      'CV': dataTube?.prefillCheckValve ?? "-",
                                      'VENT': dataTube?.prefillVent ?? "-",
                                      'HT': dataTube?.prefillHammerTest ?? "-",
                                      'CT': dataTube?.postfillColdTest ?? "-",
                                      'TBI':
                                          dataTube?.productionT0Weight ?? "-",
                                      'TBII': dataTube?.postfillT2Weight ?? "-",
                                      'Rak': dataTube?.tubeShelfName ?? "-",
                                      'status': "OK",
                                      'date': "-",
                                      'time': "-",
                                      'creator': "-",
                                    },
                                    onIsiDataPressed: () {
                                      // if (_selectedCardIndex != index ||
                                      // !_showForm) {
                                      //   setState(() {
                                      //     _selectedCardIndex = index;
                                      //     _showForm = true;
                                      //   });
                                      //   _stopStream(
                                      //       0); // Hentikan stream untuk tab Empty Weight (status = 0)
                                      // } else {
                                      //   setState(() {
                                      //     _showForm = false;
                                      //   });
                                      //   _startStream(
                                      //       0); // Lanjutkan stream setelah selesai
                                      // }
                                    },
                                    // ),
                                    // if (_showForm) // Menampilkan form hanya jika _showForm bernilai true
                                    //   const SizedBox(height: 16),
                                    // if (_showForm)
                                    //   _buildWeightForm(dataTube.idStr!
                                  ),
                                ],
                              );
                            },
                          ),
                        )
                      : Expanded(
                          child: Center(
                              child: Text(
                            'Belum Terdapat Data',
                            style: titleTextBlack,
                          )),
                        ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: Text('No data found'));
        }
      },
    );
  }

  Widget _buildKondisiTab(double width, double height) {
    return StreamBuilder<ModelLoadingTubeMixGas>(
      stream: _streamControllers[3]!.stream, // Status untuk Empty Weight
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final data = snapshot.data!.data;
          return SizedBox(
            width: width,
            height: height,
            child: (data?.tubeLoadingDetail?.length != 0)
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: WidgetButtonCustom(
                              FullWidth: 150.w,
                              FullHeight: 35.h,
                              title: "Publish Produksi",
                              onpressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => IsiDataLoadingTubeQC(
                                        title: (widget.title == "CO2")
                                            ? "CO2 Inspeksi"
                                            : "Inspeksi"),
                                  ),
                                );
                              },
                              bgColor: PRIMARY_COLOR,
                              color: PRIMARY_COLOR),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Expanded(
                                flex: 1, child: Center(child: Text('Status'))),
                            const Expanded(child: Center(child: Text('OK'))),
                            Expanded(
                                child: Center(
                                    child: Text("${data?.tubeOkCount}"))),
                            Expanded(
                                child: Center(
                                    child: Text("${data?.tubeNoCount}"))),
                            const Expanded(
                              child: Center(child: Text('NO')),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Expanded(flex: 1, child: SizedBox.shrink()),
                            Expanded(
                              flex: 4,
                              child: LinearProgressIndicator(
                                value: data!.tubeOkCount! / data.tubeNoCount!,
                                color: PRIMARY_COLOR,
                                minHeight: height * 0.01,
                                backgroundColor: SECONDARY_COLOR,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: data.tubeLoadingDetail!.length,
                            itemBuilder: (context, index) {
                              final dataTube = data.tubeLoadingDetail![index];

                              return Column(
                                children: [
                                  _buildInfoCardInspeksi(
                                    isOkay: true,
                                    prefill: false,
                                    production: false,
                                    postfill: false,
                                    finish: true,
                                    width: width,
                                    height: height,
                                    data: {
                                      "id": dataTube.idStr ?? "-",
                                      "tube": dataTube.tubeId ?? "-",
                                      "no": dataTube.tubeNo ?? "-",
                                      'CB': dataTube.prefillCheckBody ?? "-",
                                      'CV': dataTube.prefillCheckValve ?? "-",
                                      'VENT': dataTube.prefillVent ?? "-",
                                      'HT': dataTube.prefillHammerTest ?? "-",
                                      'CT': dataTube.postfillColdTest ?? "-",
                                      'TBI': dataTube.productionT0Weight ?? "-",
                                      'TBII': dataTube.postfillT2Weight ?? "-",
                                      'Rak': dataTube.tubeShelfName ?? "-",
                                      'status': "OK",
                                      'date': "-",
                                      'time': "-",
                                      'creator': "-",
                                    },
                                    isExpanded: expandedCards.contains(index),
                                    onToggleExpand: () {
                                      setState(() {
                                        if (expandedCards.contains(index)) {
                                          expandedCards.remove(index);
                                        } else {
                                          expandedCards.add(index);
                                        }
                                      });
                                    },
                                    onIsiDataPressed: () {
                                      if (_selectedCardIndex != index ||
                                          !_showForm) {
                                        setState(() {
                                          _selectedCardIndex = index;
                                          _showForm = true;
                                        });
                                        _stopStream(3);
                                      } else {
                                        setState(() {
                                          _showForm = false;
                                        });
                                        _startStream(3);
                                      }
                                    },
                                  ),
                                  // if (_showForm && _selectedCardIndex == index)
                                  //   const SizedBox(height: 16),
                                  // if (_showForm && _selectedCardIndex == index)
                                  //   _buildWeightFormFilled(dataTube.tareWeight!,
                                  //       dataTube.emptyWeight!, dataTube.idStr!),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : Expanded(
                    child: Center(
                        child: Text(
                      'Belum Terdapat Data',
                      style: titleTextBlack,
                    )),
                  ),
          );
        } else {
          return const Center(child: Text('No data found'));
        }
      },
    );
  }

  Widget _buildInfoCardInspeksi({
    required double width,
    required double height,
    required Map<String, dynamic> data,
    bool showMaintenanceButton =
        true, // Default untuk menampilkan tombol Maintenance
    bool showIsiDataButton =
        true, // Default untuk menampilkan tombol Maintenance
    bool isOkay = false,
    required VoidCallback onIsiDataPressed,
    required bool isExpanded,
    required VoidCallback onToggleExpand,
    required bool prefill,
    required bool production,
    required bool postfill,
    required bool finish,
  }) {
    return Container(
      width: width,
      height: isExpanded ? 400.h : 230.h,
      margin: EdgeInsets.only(
        top: height * 0.01,
        bottom: height * 0.01,
      ),
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
          (postfill == true)
              ? _buildListItemHeaderS(width, data)
              : (isOkay == true)
                  ? _buildListItemHeaderSelesai(width, data)
                  : _buildListItemHeader(width, data, prefill),
          (prefill == true)
              ? _buildListItemBody(width, height, data, showMaintenanceButton,
                  (isOkay) == true ? true : false)
              : (production == true)
                  ? _buildListItemBodyProduction(width, height, data,
                      showMaintenanceButton, (isOkay) == true ? true : false)
                  : (postfill == true)
                      ? _buildListItemBodyPostfill(
                          width,
                          height,
                          data,
                          showMaintenanceButton,
                          (isOkay) == true ? true : false)
                      : _buildListItemBodySelesai(
                          width,
                          height,
                          data,
                          showMaintenanceButton,
                          (isOkay) == true ? true : false),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: WidgetButtonCustom(
                      FullWidth:
                          (showIsiDataButton) ? width * 0.25 : width * 0.35,
                      FullHeight: 30.h,
                      title: 'Riwayat',
                      onpressed: () async {},
                      bgColor: PRIMARY_COLOR,
                      color: Colors.transparent),
                ),
                SizedBox(
                  width: width * 0.01,
                ),
                Expanded(
                  child: WidgetButtonCustom(
                    FullWidth:
                        (showIsiDataButton) ? width * 0.25 : width * 0.35,
                    FullHeight: 30.h,
                    title: 'Maintenance',
                    onpressed: () {},
                    bgColor: PRIMARY_COLOR,
                    color: Colors.transparent,
                  ),
                ),
                SizedBox(
                  width: width * 0.01,
                ),
                Expanded(
                  child: WidgetButtonCustom(
                    FullWidth: width * 0.25,
                    FullHeight: 30.h,
                    title: 'Isi Data',
                    onpressed: onIsiDataPressed,
                    bgColor: PRIMARY_COLOR,
                    color: Colors.transparent,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          if (isExpanded)
            Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    children: [
                      const Divider(),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Item Pengecekan",
                              style: titleTextBlack,
                            ),
                            // Container(
                            //   width: 35.w,
                            //   height: 40.h,
                            //   decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(100.w),
                            //       color: SECONDARY_COLOR),
                            //   child: FittedBox(
                            //     fit: BoxFit.scaleDown,
                            //     child: Text(
                            //       "FAIL",
                            //       style: subtitleText,
                            //     ),
                            //   ),
                            // ),
                            Container(
                              width: 35.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.w),
                                  color: Colors.green),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "PASS",
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
                            Expanded(
                                flex: 2,
                                child: Text('Berat Isi TWI',
                                    style: minisubtitleTextBlack)),
                            const Text(':\t'),
                            Expanded(
                              child:
                                  Text('10000', style: minisubtitleTextBlack),
                            ),
                            Expanded(
                                flex: 2,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Badan Tabung',
                                        style: minisubtitleTextBlack))),
                            const Text(':\t'),
                            Expanded(
                              child:
                                  SvgPicture.asset('assets/images/ceklist.svg'),
                            ),
                            Expanded(
                                flex: 2,
                                child:
                                    Text('Pen', style: minisubtitleTextBlack)),
                            const Text(':'),
                            Expanded(
                              child:
                                  SvgPicture.asset('assets/images/ceklist.svg'),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text('Safety Valve',
                                    style: minisubtitleTextBlack)),
                            const Text(':\t'),
                            Expanded(
                              child:
                                  SvgPicture.asset('assets/images/ceklist.svg'),
                            ),
                            Expanded(
                                flex: 2,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Mulut Valve',
                                        style: minisubtitleTextBlack))),
                            const Text(':\t'),
                            Expanded(
                              child:
                                  SvgPicture.asset('assets/images/ceklist.svg'),
                            ),
                            Expanded(
                                flex: 2,
                                child: Text('Leher Tabung',
                                    style: minisubtitleTextBlack)),
                            const Text(':'),
                            Expanded(
                              child:
                                  SvgPicture.asset('assets/images/ceklist.svg'),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Align(
                                child: Text('Dibuat oleh',
                                    style: minisubtitleTextGrey),
                              ),
                            ),
                            Text(
                              ':\t',
                              style: minisubtitleTextGrey,
                            ),
                            Expanded(
                              flex: 2,
                              child: Align(
                                child: Text(
                                  "Dwi Gitayana Putra",
                                  style: minisubtitleTextGrey,
                                ),
                              ),
                            ),
                            Expanded(
                                child: Align(
                              child: Text('Dibuat pada',
                                  style: minisubtitleTextGrey),
                            )),
                            Text(
                              ':\t',
                              style: minisubtitleTextGrey,
                            ),
                            Expanded(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "11 - 8 - 2024 | 10 : 30",
                                  style: minisubtitleTextGrey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25.h,
                        child: Row(
                          children: [
                            Expanded(
                              child: WidgetButtonCustom(
                                FullWidth: (showIsiDataButton)
                                    ? width * 0.25
                                    : width * 0.35,
                                FullHeight: 40.h,
                                title: 'COA',
                                onpressed: () async {},
                                bgColor: PRIMARY_COLOR,
                                color: Colors.transparent,
                              ),
                            ),
                            SizedBox(width: width * 0.01),
                            if (showMaintenanceButton)
                              Expanded(
                                child: WidgetButtonCustom(
                                  FullWidth: (showIsiDataButton)
                                      ? width * 0.25
                                      : width * 0.35,
                                  FullHeight: 40.h,
                                  title: 'Edit Data',
                                  onpressed: () {},
                                  bgColor: PRIMARY_COLOR,
                                  color: Colors.transparent,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          IconButton(
            icon: Icon(isExpanded
                ? Icons.keyboard_arrow_up
                : Icons.keyboard_arrow_down),
            onPressed: onToggleExpand,
          ),
        ],
      ),
    );
  }

  Widget _buildPrefillTab(double width, double height) {
    return StreamBuilder<ModelLoadingTubeMixGas>(
      stream: _streamControllers[0]!.stream, // Status untuk Empty Weight
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final data = snapshot.data!.data;
          return SizedBox(
            width: width,
            height: height,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.01,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IsiDataLoadingTube(
                            title: 'Prefill',
                          ),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/scan.svg',
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(width: 5),
                        const Text('Scan Isi'),
                        const Expanded(child: SizedBox.shrink()),
                        WidgetButtonCustom(
                            FullWidth: width * 0.35,
                            FullHeight: height * 0.05,
                            title: "Tambah Tabung",
                            onpressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MenuScanTubeMix(
                                    title: widget.title,
                                    fill: (widget.title == "CO2")
                                        ? 1
                                        : (widget.title == "Gas")
                                            ? 2
                                            : (widget.title == "VGL/DEWAR")
                                                ? 3
                                                : (widget.title == "Mix Gas")
                                                    ? 4
                                                    : 5,
                                  ),
                                ),
                              );
                            },
                            bgColor: PRIMARY_COLOR,
                            color: PRIMARY_COLOR),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  (data!.tubeLoadingDetail?.length != 0)
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: data.tubeLoadingDetail!.length,
                            itemBuilder: (context, index) {
                              final dataTube = data.tubeLoadingDetail![index];
                              print(dataTube.tubeNo);
                              return Column(
                                children: [
                                  _buildInfoCard(
                                    prefill: true,
                                    production: false,
                                    postfill: false,
                                    finish: false,
                                    width: width,
                                    height: height,
                                    data: {
                                      "id": dataTube.idStr ?? "-",
                                      "tube": dataTube.tubeId ?? "-",
                                      "no": dataTube.tubeNo ?? "-",
                                      'CB': dataTube.prefillCheckBody ?? "-",
                                      'CV': dataTube.prefillCheckValve ?? "-",
                                      'VENT': dataTube.prefillVent ?? "-",
                                      'HT': dataTube.prefillHammerTest ?? "-",
                                      'CT': dataTube.postfillColdTest ?? "-",
                                      'TBI': dataTube.productionT0Weight ?? "-",
                                      'TBII': dataTube.postfillT2Weight ?? "-",
                                      'Rak': dataTube.tubeShelfName ?? "-",
                                      'status': "OK",
                                      'date': "-",
                                      'time': "-",
                                      'creator': "-",
                                    },
                                    onIsiDataPressed: () {
                                      // if (_selectedCardIndex != index ||
                                      //     !_showForm) {
                                      //   setState(() {
                                      //     _selectedCardIndex = index;
                                      //     _showForm = true;
                                      //   });
                                      //   _stopStream(
                                      //       0); // Hentikan stream untuk tab Empty Weight (status = 0)
                                      // } else {
                                      //   setState(() {
                                      //     _showForm = false;
                                      //   });
                                      //   _startStream(
                                      //       0); // Lanjutkan stream setelah selesai
                                      // }
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              IsiDataLoadingTubeMix(
                                            title: 'Prefill',
                                            uuid: dataTube.idStr!,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  // if (_showForm) // Menampilkan form hanya jika _showForm bernilai true
                                  //   const SizedBox(height: 16),
                                  // if (_showForm)
                                  //   _buildWeightForm(dataTube.idStr!),
                                ],
                              );
                            },
                          ),
                        )
                      : Expanded(
                          child: Center(
                              child: Text(
                            'Belum Terdapat Data',
                            style: titleTextBlack,
                          )),
                        ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: Text('No data found'));
        }
      },
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
  }) {
    return Row(
      children: [
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              style: subtitleTextBlack,
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.1,
          child: const Center(child: Text(":")),
        ),
        Expanded(
          flex: 4,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Masukkan $label',
                contentPadding: const EdgeInsets.all(8.0),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductionTab(double width, double height) {
    return StreamBuilder<ModelLoadingTubeMixGas>(
      stream: _streamControllers[1]!.stream, // Status untuk Empty Weight
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final data = snapshot.data!.data;
          print(data!.tubeLoadingDetail?.length);
          return SizedBox(
            width: width,
            height: height,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.01,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => IsiDataLoadingTube(
                                    title: 'Production',
                                  )));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/scan.svg',
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(width: 5),
                        const Text('Scan Isi'),
                        const Expanded(child: SizedBox.shrink()),
                        SvgPicture.asset(
                          'assets/images/scan.svg',
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(width: 5),
                        const Text('Scan Isi BPTK'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  (data.tubeLoadingDetail?.length != 0)
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: data.tubeLoadingDetail!.length,
                            itemBuilder: (context, index) {
                              final dataTube = data.tubeLoadingDetail![index];
                              print(dataTube.tubeNo);
                              return _buildInfoCard(
                                prefill: false,
                                production: true,
                                postfill: false,
                                finish: false,
                                width: width,
                                height: height,
                                data: {
                                  "id": dataTube.idStr ?? "-",
                                  "tube": dataTube.tubeId ?? "-",
                                  "no": dataTube.tubeNo ?? "-",
                                  'CB': dataTube.prefillCheckBody ?? "-",
                                  'CV': dataTube.prefillCheckValve ?? "-",
                                  'VENT': dataTube.prefillVent ?? "-",
                                  'HT': dataTube.prefillHammerTest ?? "-",
                                  'CT': dataTube.postfillColdTest ?? "-",
                                  'TBI': dataTube.productionT0Weight ?? "-",
                                  'TBII': dataTube.postfillT2Weight ?? "-",
                                  'Rak': dataTube.tubeShelfName ?? "-",
                                  'status': "OK",
                                  'date': "-",
                                  'time': "-",
                                  'creator': "-",
                                },
                                onIsiDataPressed: () {
                                  // if (_selectedCardIndex != index ||
                                  //     !_showForm) {
                                  //   setState(() {
                                  //     _selectedCardIndex = index;
                                  //     _showForm = true;
                                  //   });
                                  //   _stopStream(
                                  //       1); // Hentikan stream untuk tab Empty Weight (status = 0)
                                  // } else {
                                  //   setState(() {
                                  //     _showForm = false;
                                  //   });
                                  //   _startStream(
                                  //       1); // Lanjutkan stream setelah selesai
                                  // }
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => IsiDataLoadingTube(
                                        title: 'Production',
                                      ),
                                    ),
                                  );
                                },
                                showIsiDataButton: false,
                              );
                            },
                          ),
                        )
                      : Center(
                          child: Text(
                          'Belum Terdapat Data',
                          style: titleTextBlack,
                        )),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: Text('No data found'));
        }
      },
    );
  }

  Widget _buildPostfillTab(double width, double height) {
    return StreamBuilder<ModelLoadingTubeMixGas>(
      stream: _streamControllers[2]!.stream, // Status untuk Empty Weight
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final data = snapshot.data!.data;
          return SizedBox(
            width: width,
            height: height,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.01,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IsiDataLoadingTube(
                            title: 'Postfill',
                          ),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/scan.svg',
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(width: 5),
                        const Text('Scan Isi')
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  (data!.tubeLoadingDetail?.length != 0)
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: data.tubeLoadingDetail!.length,
                            itemBuilder: (context, index) {
                              final dataTube = data.tubeLoadingDetail![index];
                              print(dataTube.tubeNo);
                              return Column(
                                children: [
                                  _buildInfoCard(
                                    prefill: false,
                                    production: false,
                                    postfill: true,
                                    finish: false,
                                    width: width,
                                    height: height,
                                    data: {
                                      "id": dataTube.idStr ?? "-",
                                      "tube": dataTube.tubeId ?? "-",
                                      "no": dataTube.tubeNo ?? "-",
                                      'CB': dataTube.prefillCheckBody ?? "-",
                                      'CV': dataTube.prefillCheckValve ?? "-",
                                      'VENT': dataTube.prefillVent ?? "-",
                                      'HT': dataTube.prefillHammerTest ?? "-",
                                      'CT': dataTube.postfillColdTest ?? "-",
                                      'TBI': dataTube.productionT0Weight ?? "-",
                                      'TBII': dataTube.postfillT2Weight ?? "-",
                                      'Rak': dataTube.tubeShelfName ?? "-",
                                      'status': "OK",
                                      'date': "-",
                                      'time': "-",
                                      'creator': "-",
                                    },
                                    onIsiDataPressed: () {
                                      // if (_selectedCardIndex != index ||
                                      //     !_showForm) {
                                      //   setState(() {
                                      //     _selectedCardIndex = index;
                                      //     _showForm = true;
                                      //   });
                                      //   _stopStream(
                                      //       2); // Hentikan stream untuk tab Empty Weight (status = 0)
                                      // } else {
                                      //   setState(() {
                                      //     _showForm = false;
                                      //   });
                                      //   _startStream(
                                      //       2); // Lanjutkan stream setelah selesai
                                      // }
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              IsiDataLoadingTube(
                                            title: 'Postfill',
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  // if (_showForm) // Menampilkan form hanya jika _showForm bernilai true
                                  //   SizedBox(height: 16),
                                  // if (_showForm)
                                  //   _buildWeightFormFilled(dataTube.tareWeight!,
                                  //       dataTube.emptyWeight!, dataTube.idStr!),
                                ],
                              );
                            },
                          ),
                        )
                      : Expanded(
                          child: Center(
                              child: Text(
                            'Belum Terdapat Data',
                            style: titleTextBlack,
                          )),
                        ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: Text('No data found'));
        }
      },
    );
  }

  Widget _buildFinishTab(double width, double height) {
    return StreamBuilder<ModelLoadingTubeMixGas>(
      stream: _streamControllers[3]!.stream, // Status untuk Empty Weight
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final data = snapshot.data!.data;
          return SizedBox(
            width: width,
            height: height,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.01,
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => IsiDataLoadingTube(
                  //           title: 'Postfill',
                  //         ),
                  //       ),
                  //     );
                  //   },
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       SvgPicture.asset(
                  //         'assets/images/scan.svg',
                  //         width: 30,
                  //         height: 30,
                  //       ),
                  //       const SizedBox(width: 5),
                  //       const Text('Scan Isi')
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(height: 10),
                  (data!.tubeLoadingDetail?.length != 0)
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: data.tubeLoadingDetail!.length,
                            itemBuilder: (context, index) {
                              final dataTube = data.tubeLoadingDetail![index];
                              print(dataTube.tubeNo);
                              return Column(
                                children: [
                                  _buildInfoCard(
                                    prefill: false,
                                    production: false,
                                    postfill: false,
                                    finish: true,
                                    width: width,
                                    height: height,
                                    data: {
                                      "id": dataTube.idStr ?? "-",
                                      "tube": dataTube.tubeId ?? "-",
                                      "no": dataTube.tubeNo ?? "-",
                                      'CB': dataTube.prefillCheckBody ?? "-",
                                      'CV': dataTube.prefillCheckValve ?? "-",
                                      'VENT': dataTube.prefillVent ?? "-",
                                      'HT': dataTube.prefillHammerTest ?? "-",
                                      'CT': dataTube.postfillColdTest ?? "-",
                                      'TBI': dataTube.productionT0Weight ?? "-",
                                      'TBII': dataTube.postfillT2Weight ?? "-",
                                      'Rak': dataTube.tubeShelfName ?? "-",
                                      'status': "OK",
                                      'date': "-",
                                      'time': "-",
                                      'creator': "-",
                                    },
                                    onIsiDataPressed: () {
                                      // if (_selectedCardIndex != index ||
                                      //     !_showForm) {
                                      //   setState(() {
                                      //     _selectedCardIndex = index;
                                      //     _showForm = true;
                                      //   });
                                      //   _stopStream(
                                      //       2); // Hentikan stream untuk tab Empty Weight (status = 0)
                                      // } else {
                                      //   setState(() {
                                      //     _showForm = false;
                                      //   });
                                      //   _startStream(
                                      //       2); // Lanjutkan stream setelah selesai
                                      // }
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              IsiDataLoadingTube(
                                            title: 'Postfill',
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  // if (_showForm) // Menampilkan form hanya jika _showForm bernilai true
                                  //   SizedBox(height: 16),
                                  // if (_showForm)
                                  //   _buildWeightFormFilled(dataTube.tareWeight!,
                                  //       dataTube.emptyWeight!, dataTube.idStr!),
                                ],
                              );
                            },
                          ),
                        )
                      : Expanded(
                          child: Center(
                              child: Text(
                            'Belum Terdapat Data',
                            style: titleTextBlack,
                          )),
                        ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: Text('No data found'));
        }
      },
    );
  }

  // Widget _buildFinishTab(double width, double height) {
  //   return StreamBuilder<ModelLoadingTubeMixGas>(
  //     stream: _streamControllers[3]!.stream, // Status untuk Empty Weight
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return const Center(child: CircularProgressIndicator());
  //       } else if (snapshot.hasError) {
  //         return Center(child: Text('Error: ${snapshot.error}'));
  //       } else if (snapshot.hasData) {
  //         final data = snapshot.data!.data;
  //         return SizedBox(
  //           width: width,
  //           height: height,
  //           child: (data!.tubeLoadingDetail!.isNotEmpty)
  //               ? Padding(
  //                   padding: EdgeInsets.symmetric(horizontal: width * 0.05),
  //                   child: Column(
  //                     children: [
  //                       SizedBox(
  //                         height: height * 0.01,
  //                       ),
  //                       // const Row(
  //                       //   mainAxisAlignment: MainAxisAlignment.center,
  //                       //   children: [
  //                       //     Expanded(
  //                       //         flex: 1, child: Center(child: Text('Status'))),
  //                       //     Expanded(child: Center(child: Text('OK'))),
  //                       //     Expanded(child: Center(child: Text('99'))),
  //                       //     Expanded(child: Center(child: Text('1'))),
  //                       //     Expanded(
  //                       //       child: Center(child: Text('NO')),
  //                       //     ),
  //                       //   ],
  //                       // ),
  //                       // Row(
  //                       //   mainAxisAlignment: MainAxisAlignment.center,
  //                       //   children: [
  //                       //     const Expanded(flex: 1, child: SizedBox.shrink()),
  //                       //     Expanded(
  //                       //       flex: 4,
  //                       //       child: LinearProgressIndicator(
  //                       //         value: 9 / 10,
  //                       //         color: PRIMARY_COLOR,
  //                       //         minHeight: height * 0.01,
  //                       //         backgroundColor: SECONDARY_COLOR,
  //                       //         borderRadius: BorderRadius.circular(12),
  //                       //       ),
  //                       //     ),
  //                       //   ],
  //                       // ),
  //                       const SizedBox(
  //                         height: 10,
  //                       ),
  //                       Expanded(
  //                         child: ListView.builder(
  //                           itemCount: data.tubeLoadingDetail!.length,
  //                           itemBuilder: (context, index) {
  //                             final dataTube = data.tubeLoadingDetail![index];
  //                             print(dataTube.tubeNo);
  //                             return Column(
  //                               children: [
  //                                 _buildInfoCard(
  //                                   isOkay: true,
  //                                   prefill: false,
  //                                   production: false,
  //                                   postfill: false,
  //                                   finish: true,
  //                                   width: width,
  //                                   height: height,
  //                                   data: {
  //                                     "id": dataTube.idStr ?? "-",
  //                                     "tube": dataTube.tubeId ?? "-",
  //                                     "no": dataTube.tubeNo ?? "-",
  //                                     'CB': dataTube.prefillCheckBody ?? "-",
  //                                     'CV': dataTube.prefillCheckValve ?? "-",
  //                                     'VENT': dataTube.prefillVent ?? "-",
  //                                     'HT': dataTube.prefillHammerTest ?? "-",
  //                                     'CT': dataTube.postfillColdTest ?? "-",
  //                                     'TBI': dataTube.productionT0Weight ?? "-",
  //                                     'TBII': dataTube.postfillT2Weight ?? "-",
  //                                     'Rak': dataTube.tubeShelfName ?? "-",
  //                                     'status': "OK",
  //                                     'date': "-",
  //                                     'time': "-",
  //                                     'creator': "-",
  //                                   },
  //                                   onIsiDataPressed: () {},
  //                                 ),
  //                                 if (_showForm) // Menampilkan form hanya jika _showForm bernilai true
  //                                   const SizedBox(height: 16),
  //                               ],
  //                             );
  //                           },
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 )
  //               : Expanded(
  //                   child: Center(
  //                       child: Text(
  //                     'Belum Terdapat Data',
  //                     style: titleTextBlack,
  //                   )),
  //                 ),
  //         );
  //       } else {
  //         return const Center(child: Text('No data found'));
  //       }
  //     },
  //   );
  // }

  Widget _buildInfoCard({
    required double width,
    required double height,
    required Map<String, dynamic> data,
    bool showMaintenanceButton =
        true, // Default untuk menampilkan tombol Maintenance
    bool showIsiDataButton =
        true, // Default untuk menampilkan tombol Maintenance
    bool isOkay = false,
    required VoidCallback onIsiDataPressed,
    required bool prefill,
    required bool production,
    required bool postfill,
    required bool finish,
  }) {
    final provider = Provider.of<ProviderProduksi>(context);
    return Container(
      width: width,
      height: (finish == true) ? 200.h : 180.h,
      margin: EdgeInsets.only(
        top: height * 0.01,
        bottom: height * 0.01,
      ),
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
          (postfill == true)
              ? _buildListItemHeaderS(width, data)
              : (isOkay == true)
                  ? _buildListItemHeaderSelesai(width, data)
                  : _buildListItemHeader(width, data, prefill),
          (prefill == true)
              ? _buildListItemBody(width, height, data, showMaintenanceButton,
                  (isOkay) == true ? true : false)
              : (production == true)
                  ? _buildListItemBodyProduction(width, height, data,
                      showMaintenanceButton, (isOkay) == true ? true : false)
                  : (postfill == true)
                      ? _buildListItemBodyPostfill(
                          width,
                          height,
                          data,
                          showMaintenanceButton,
                          (isOkay) == true ? true : false)
                      : _buildListItemBodySelesai(
                          width,
                          height,
                          data,
                          showMaintenanceButton,
                          (isOkay) == true ? true : false),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: WidgetButtonCustom(
                      FullWidth:
                          (showIsiDataButton) ? width * 0.25 : width * 0.35,
                      FullHeight: 30.h,
                      title: 'Riwayat',
                      onpressed: () async {},
                      bgColor: PRIMARY_COLOR,
                      color: Colors.transparent),
                ),
                SizedBox(
                  width: width * 0.01,
                ),
                Expanded(
                  child: WidgetButtonCustom(
                    FullWidth:
                        (showIsiDataButton) ? width * 0.25 : width * 0.35,
                    FullHeight: 30.h,
                    title: 'Maintenance',
                    onpressed: () async {
                      await provider.createMaintenance(
                          context, 1, data['no'].toString());
                    },
                    bgColor: PRIMARY_COLOR,
                    color: Colors.transparent,
                  ),
                ),
                SizedBox(
                  width: width * 0.01,
                ),
                Expanded(
                  child: WidgetButtonCustom(
                    FullWidth: width * 0.25,
                    FullHeight: 30.h,
                    title: 'Isi Data',
                    onpressed: onIsiDataPressed,
                    bgColor: PRIMARY_COLOR,
                    color: Colors.transparent,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
        ],
      ),
    );
  }

  Widget _buildListItemHeaderSelesai(
    double width,
    Map<String, dynamic> data,
  ) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Stack(
        children: [
          // Bagian hijau (OK)
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 200.w, // Lebar hingga setengah layar
              height: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: width * 0.06),
              decoration: const BoxDecoration(
                color: Color(0xFF4CAF50), // Warna hijau
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    topLeft: Radius.circular(15)),
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text("PASS", style: titleText),
              ),
            ),
          ),

          // Bagian biru (No. 12345)
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: width * 0.3, // 30% dari lebar layar
              height: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF12163A), // Warna biru tua
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomRight: Radius.circular(30),
                ),
              ),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(data['no'].toString(), style: titleText),
            ),
          ),

          // Bagian kanan (TW: 36.8)
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text('Berat : 20Kg', style: subtitleTextNormal),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItemHeader(
      double width, Map<String, dynamic> data, bool prefill) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
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
                bottomRight: Radius.circular(30),
              ),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                data['no'].toString(),
                style: titleText,
              ),
            ),
          ),
          Container(
            width: 150.w,
            height: 100.h,
            padding: EdgeInsets.only(right: 10.w),
            child: Align(
                alignment: Alignment.centerRight,
                child: (prefill == true)
                    ? Text(
                        "Dibuat Oleh : ${data['creator'] ?? "unknown"}",
                        style: minisubtitleTextNormal,
                        overflow: TextOverflow.ellipsis,
                      )
                    : Text(
                        "Berat : 20Kg",
                        style: minisubtitleTextNormal,
                        overflow: TextOverflow.ellipsis,
                      )),
          ),
        ],
      ),
    );
  }

  Widget _buildListItemHeaderS(
    double width,
    Map<String, dynamic> data,
  ) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Row(
        children: [
          // Bagian biru (No. 12345)
          Container(
            width: width * 0.3, // 30% dari lebar layar
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF12163A), // Warna biru tua
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomRight: Radius.circular(30),
              ),
            ),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(data['no'].toString(), style: titleText),
          ),

          // Bagian kanan (TW: 36.8)
          Expanded(
            child: Container(
              height: double.maxFinite,
              padding: EdgeInsets.only(left: 60.w, right: 10.w),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Berat : 20Kg",
                                style: minisubtitleTextNormal,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.center,
                              child: Text(
                                "KP: HP2410003",
                                style: minisubtitleTextNormal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.center,
                              child: Text(
                                "GR : CO2",
                                style: minisubtitleTextNormal,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Rak : 1 \t Tubbing : 2",
                                style: minisubtitleTextNormal,
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
        ],
      ),
    );
  }

  Widget _buildListItemBodyPostfill(double width, double height,
      Map<String, dynamic> data, bool showMaintenanceButton, bool fm) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
        child: Row(
          children: [
            // Container kiri
            Container(
              width: 80.w,
              height: 90.h,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            // Konten kanan
            SizedBox(
              width: 8.w,
            ),
            Expanded(
              child: Column(
                children: [
                  // Baris atas
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Text('Prefill',
                                    style: minisubtitleTextBoldBlack))),
                        Expanded(
                            child: FittedBox(
                                alignment: Alignment.center,
                                fit: BoxFit.scaleDown,
                                child: Text('CB : ',
                                    style: minisubtitleTextBlack))),
                        Expanded(
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child:
                                SvgPicture.asset('assets/images/ceklist.svg'),
                          ),
                        ),
                        Expanded(
                            child: FittedBox(
                                alignment: Alignment.center,
                                fit: BoxFit.scaleDown,
                                child: Text('CV : ',
                                    style: minisubtitleTextBlack))),
                        Expanded(
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child:
                                SvgPicture.asset('assets/images/ceklist.svg'),
                          ),
                        ),
                        Expanded(
                            child: FittedBox(
                                alignment: Alignment.center,
                                fit: BoxFit.scaleDown,
                                child: Text(' Vent : ',
                                    style: minisubtitleTextBlack))),
                        Expanded(
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child:
                                SvgPicture.asset('assets/images/ceklist.svg'),
                          ),
                        ),
                        Expanded(
                            child: FittedBox(
                                alignment: Alignment.center,
                                fit: BoxFit.scaleDown,
                                child: Text('HT : ',
                                    style: minisubtitleTextBlack))),
                        Expanded(
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child:
                                SvgPicture.asset('assets/images/ceklist.svg'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Baris tengah
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: Text('Production',
                                style: minisubtitleTextBoldBlack)),
                        Expanded(
                            child: FittedBox(
                                alignment: Alignment.center,
                                fit: BoxFit.scaleDown,
                                child: Text(' BTK : ',
                                    style: minisubtitleTextBlack))),
                        Expanded(
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: Text('20kg', style: minisubtitleTextBlack),
                          ),
                        ),
                        Expanded(
                            child: FittedBox(
                                alignment: Alignment.center,
                                fit: BoxFit.scaleDown,
                                child: Text(' Berat : ',
                                    style: minisubtitleTextBlack))),
                        Expanded(
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: Text('20kg', style: minisubtitleTextBlack),
                          ),
                        ),
                        Expanded(
                            child: FittedBox(
                                alignment: Alignment.center,
                                fit: BoxFit.scaleDown,
                                child: Text('CT : ',
                                    style: minisubtitleTextBlack))),
                        Expanded(
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child:
                                SvgPicture.asset('assets/images/ceklist.svg'),
                          ),
                        ),
                        Expanded(
                            child: FittedBox(
                                alignment: Alignment.center,
                                fit: BoxFit.scaleDown,
                                child: Text('BTI : ',
                                    style: minisubtitleTextBlack))),
                        Expanded(
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child:
                                SvgPicture.asset('assets/images/ceklist.svg'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Baris bawah
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: Text('Postfill',
                                style: minisubtitleTextBoldBlack)),
                        Expanded(
                            child: FittedBox(
                                alignment: Alignment.center,
                                fit: BoxFit.scaleDown,
                                child: Text('TBII : ',
                                    style: minisubtitleTextBlack))),
                        Expanded(
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: Text('10000', style: minisubtitleTextBlack),
                          ),
                        ),
                        Expanded(child: SizedBox.fromSize()),
                        Expanded(child: SizedBox.fromSize()),
                        Expanded(child: SizedBox.fromSize()),
                        Expanded(child: SizedBox.fromSize()),
                        Expanded(child: SizedBox.fromSize()),
                        Expanded(child: SizedBox.fromSize()),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: FittedBox(
                              alignment: Alignment.centerLeft,
                              fit: BoxFit.scaleDown,
                              child:
                                  Text('Dibuat', style: subtitleTextNormalGrey),
                            )),
                        Expanded(
                            child: FittedBox(
                                alignment: Alignment.center,
                                fit: BoxFit.scaleDown,
                                child: Text(
                                    '${data['date'] ?? "-"}  ${data['time'] ?? "-"}',
                                    style: subtitleTextNormalGrey))),
                        Expanded(child: SizedBox.fromSize()),
                        Expanded(child: SizedBox.fromSize()),
                        Expanded(child: SizedBox.fromSize()),
                        Expanded(child: SizedBox.fromSize()),
                        Expanded(child: SizedBox.fromSize()),
                        Expanded(child: SizedBox.fromSize()),
                        Expanded(child: SizedBox.fromSize()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItemBodySelesai(double width, double height,
      Map<String, dynamic> data, bool showMaintenanceButton, bool fm) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
        child: Row(
          children: [
            // Container kiri
            Container(
              width: 80.w,
              height: 90.h,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            // Konten kanan
            SizedBox(
              width: 8.w,
            ),
            Expanded(
              child: Column(
                children: [
                  // Baris atas
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Text('Prefill',
                                    style: minisubtitleTextBoldBlack))),
                        Expanded(
                            child: FittedBox(
                                alignment: Alignment.center,
                                fit: BoxFit.scaleDown,
                                child: Text('CB : ',
                                    style: minisubtitleTextBlack))),
                        Expanded(
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: Text('10000', style: minisubtitleTextBlack),
                          ),
                        ),
                        Expanded(
                            child: FittedBox(
                                alignment: Alignment.center,
                                fit: BoxFit.scaleDown,
                                child: Text('CV : ',
                                    style: minisubtitleTextBlack))),
                        Expanded(
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: Text('10000', style: minisubtitleTextBlack),
                          ),
                        ),
                        Expanded(
                            child: FittedBox(
                                alignment: Alignment.center,
                                fit: BoxFit.scaleDown,
                                child: Text(' Vent : ',
                                    style: minisubtitleTextBlack))),
                        Expanded(
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: Text('10000', style: minisubtitleTextBlack),
                          ),
                        ),
                        Expanded(
                            child: FittedBox(
                                alignment: Alignment.center,
                                fit: BoxFit.scaleDown,
                                child: Text('HT : ',
                                    style: minisubtitleTextBlack))),
                        Expanded(
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: Text('10000', style: minisubtitleTextBlack),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Baris tengah
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: Text('Production',
                                style: minisubtitleTextBoldBlack)),
                        Expanded(
                            child: FittedBox(
                                alignment: Alignment.center,
                                fit: BoxFit.scaleDown,
                                child: Text('KP : ',
                                    style: minisubtitleTextBlack))),
                        Expanded(
                          flex: 3,
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child:
                                Text('HP2410003', style: minisubtitleTextBlack),
                          ),
                        ),
                        Expanded(
                            child: FittedBox(
                                alignment: Alignment.center,
                                fit: BoxFit.scaleDown,
                                child: Text('GR : ',
                                    style: minisubtitleTextBlack))),
                        Expanded(
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: Text('CO2', style: minisubtitleTextBlack),
                          ),
                        ),
                        Expanded(
                            child: FittedBox(
                                alignment: Alignment.center,
                                fit: BoxFit.scaleDown,
                                child: Text(' Rak : ',
                                    style: minisubtitleTextBlack))),
                        Expanded(
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: Text('1', style: minisubtitleTextBlack),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: Text('', style: minisubtitleTextBoldBlack)),
                        Expanded(
                            flex: 2,
                            child: FittedBox(
                                alignment: Alignment.center,
                                fit: BoxFit.scaleDown,
                                child: Text('Tubbing : ',
                                    style: minisubtitleTextBlack))),
                        Expanded(
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: Text('2', style: minisubtitleTextBlack),
                          ),
                        ),
                        Expanded(child: SizedBox.fromSize()),
                        Expanded(
                            child: FittedBox(
                                alignment: Alignment.center,
                                fit: BoxFit.scaleDown,
                                child: Text('CT : ',
                                    style: minisubtitleTextBlack))),
                        Expanded(
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child:
                                SvgPicture.asset('assets/images/ceklist.svg'),
                          ),
                        ),
                        Expanded(
                            child: FittedBox(
                                alignment: Alignment.center,
                                fit: BoxFit.scaleDown,
                                child: Text(' BTI: ',
                                    style: minisubtitleTextBlack))),
                        Expanded(
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child:
                                SvgPicture.asset('assets/images/ceklist.svg'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Baris bawah
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: Text('Postfill',
                                style: minisubtitleTextBoldBlack)),
                        Expanded(
                            child: FittedBox(
                                alignment: Alignment.center,
                                fit: BoxFit.scaleDown,
                                child: Text('TBI : ',
                                    style: minisubtitleTextBlack))),
                        Expanded(
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: Text('10000', style: minisubtitleTextBlack),
                          ),
                        ),
                        Expanded(child: SizedBox.fromSize()),
                        Expanded(child: SizedBox.fromSize()),
                        Expanded(child: SizedBox.fromSize()),
                        Expanded(child: SizedBox.fromSize()),
                        Expanded(child: SizedBox.fromSize()),
                        Expanded(child: SizedBox.fromSize()),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: FittedBox(
                              alignment: Alignment.centerLeft,
                              fit: BoxFit.scaleDown,
                              child:
                                  Text('Dibuat', style: subtitleTextNormalGrey),
                            )),
                        Expanded(
                            child: FittedBox(
                                alignment: Alignment.center,
                                fit: BoxFit.scaleDown,
                                child: Text(
                                    '${data['date'] ?? "-"}  ${data['time'] ?? "-"}',
                                    style: subtitleTextNormalGrey))),
                        Expanded(child: SizedBox.fromSize()),
                        Expanded(child: SizedBox.fromSize()),
                        Expanded(child: SizedBox.fromSize()),
                        Expanded(child: SizedBox.fromSize()),
                        Expanded(child: SizedBox.fromSize()),
                        Expanded(child: SizedBox.fromSize()),
                        Expanded(child: SizedBox.fromSize()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItemBody(double width, double height,
      Map<String, dynamic> data, bool showMaintenanceButton, bool fm) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
        child: Row(
          children: [
            // Container kiri
            Container(
              width: 80.w,
              height: 90.h,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            // Konten kanan
            SizedBox(
              width: 8.w,
            ),
            Expanded(
              child: Column(
                children: [
                  // Baris atas
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Text('Prefill',
                                    style: minisubtitleTextBoldBlack))),
                        Expanded(
                            child: FittedBox(
                                alignment: Alignment.center,
                                fit: BoxFit.scaleDown,
                                child: Text('CB : ',
                                    style: minisubtitleTextBlack))),
                        Expanded(
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: Text('${data['CB']}',
                                style: minisubtitleTextBlack),
                          ),
                        ),
                        Expanded(
                            child: FittedBox(
                                alignment: Alignment.center,
                                fit: BoxFit.scaleDown,
                                child: Text('CV : ',
                                    style: minisubtitleTextBlack))),
                        Expanded(
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: Text('${data['CV']}',
                                style: minisubtitleTextBlack),
                          ),
                        ),
                        Expanded(
                            child: FittedBox(
                                alignment: Alignment.center,
                                fit: BoxFit.scaleDown,
                                child: Text(' Vent : ',
                                    style: minisubtitleTextBlack))),
                        Expanded(
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: Text('${data['VENT']}',
                                style: minisubtitleTextBlack),
                          ),
                        ),
                        Expanded(
                            child: FittedBox(
                                alignment: Alignment.center,
                                fit: BoxFit.scaleDown,
                                child: Text('HT : ',
                                    style: minisubtitleTextBlack))),
                        Expanded(
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: Text('${data['HT']}',
                                style: minisubtitleTextBlack),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Baris tengah
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: Text('Production',
                                style: minisubtitleTextBoldBlack)),
                        Expanded(
                            child: FittedBox(
                                alignment: Alignment.center,
                                fit: BoxFit.scaleDown,
                                child: Text('CT : ',
                                    style: minisubtitleTextBlack))),
                        Expanded(
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: Text('${data['CT']}',
                                style: minisubtitleTextBlack),
                          ),
                        ),
                        Expanded(
                            child: FittedBox(
                                alignment: Alignment.center,
                                fit: BoxFit.scaleDown,
                                child: Text('TBI : ',
                                    style: minisubtitleTextBlack))),
                        Expanded(
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: Text('${data['TBI']}',
                                style: minisubtitleTextBlack),
                          ),
                        ),
                        Expanded(
                            child: FittedBox(
                                alignment: Alignment.center,
                                fit: BoxFit.scaleDown,
                                child: Text(' Rak : ',
                                    style: minisubtitleTextBlack))),
                        Expanded(
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: Text('${data['Rak']}',
                                style: minisubtitleTextBlack),
                          ),
                        ),
                        Expanded(child: SizedBox.fromSize()),
                        Expanded(child: SizedBox.fromSize()),
                      ],
                    ),
                  ),
                  // Baris bawah
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: Text('Postfill',
                                style: minisubtitleTextBoldBlack)),
                        Expanded(
                            child: FittedBox(
                                alignment: Alignment.center,
                                fit: BoxFit.scaleDown,
                                child: Text('TBII : ',
                                    style: minisubtitleTextBlack))),
                        Expanded(
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: Text('${data["TBII"]}',
                                style: minisubtitleTextBlack),
                          ),
                        ),
                        Expanded(child: SizedBox.fromSize()),
                        Expanded(child: SizedBox.fromSize()),
                        Expanded(child: SizedBox.fromSize()),
                        Expanded(child: SizedBox.fromSize()),
                        Expanded(child: SizedBox.fromSize()),
                        Expanded(child: SizedBox.fromSize()),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: FittedBox(
                              alignment: Alignment.centerLeft,
                              fit: BoxFit.scaleDown,
                              child:
                                  Text('Dibuat', style: subtitleTextNormalGrey),
                            )),
                        Expanded(
                            child: FittedBox(
                                alignment: Alignment.center,
                                fit: BoxFit.scaleDown,
                                child: Text(
                                    '${data['date'] ?? "-"}  ${data['time'] ?? "-"}',
                                    style: subtitleTextNormalGrey))),
                        Expanded(child: SizedBox.fromSize()),
                        Expanded(child: SizedBox.fromSize()),
                        Expanded(child: SizedBox.fromSize()),
                        Expanded(child: SizedBox.fromSize()),
                        Expanded(child: SizedBox.fromSize()),
                        Expanded(child: SizedBox.fromSize()),
                        Expanded(child: SizedBox.fromSize()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItemBodyProduction(double width, double height,
      Map<String, dynamic> data, bool showMaintenanceButton, bool fm) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: height * 0.01, horizontal: width * 0.02),
        child: Row(
          children: [
            // Container kiri
            Container(
              width: width * 0.2,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            // Konten kanan
            SizedBox(
              width: width * 0.01,
            ),
            Expanded(
              child: Column(
                children: [
                  // Baris atas
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: Text('Prefill',
                                style: minisubtitleTextBoldBlack)),
                        Expanded(
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: FittedBox(
                                    child: Text('CB',
                                        style: minisubtitleTextBlack)))),
                        const Text(':\t'),
                        Expanded(
                          child: SvgPicture.asset('assets/images/ceklist.svg'),
                        ),
                        Expanded(
                            child: Text('CV', style: minisubtitleTextBlack)),
                        const Text(':'),
                        Expanded(
                          child: SvgPicture.asset('assets/images/ceklist.svg'),
                        ),
                        Expanded(
                            child: FittedBox(
                                child: Text('Vent',
                                    style: minisubtitleTextBlack))),
                        const Text(':'),
                        Expanded(
                          child: SvgPicture.asset('assets/images/ceklist.svg'),
                        ),
                        Expanded(
                            child: Text('HT', style: minisubtitleTextBlack)),
                        const Text(':'),
                        Expanded(
                          child: SvgPicture.asset('assets/images/ceklist.svg'),
                        ),
                      ],
                    ),
                  ),
                  // Baris tengah
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: Text('Production',
                                style: minisubtitleTextBoldBlack)),
                        Expanded(
                            child: Text('RAK', style: minisubtitleTextBlack)),
                        const Text(':\t'),
                        Expanded(
                          child: Text("-", style: minisubtitleTextBlack),
                        ),
                        Expanded(
                            child: Text(' ', style: minisubtitleTextBlack)),
                        const Text(' '),
                        Expanded(
                          child: Text(" ", style: minisubtitleTextBlack),
                        ),
                        Expanded(
                            child: Text(' ', style: minisubtitleTextBlack)),
                        const Text(' '),
                        Expanded(
                          child: Text(" ", style: minisubtitleTextBlack),
                        ),
                        Expanded(
                            child: Text(' ', style: minisubtitleTextBlack)),
                        const Text(' '),
                        Expanded(
                          child: Text(' ', style: minisubtitleTextBlack),
                        ),
                      ],
                    ),
                  ),
                  // Baris bawah
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: Text('Postfill',
                                style: minisubtitleTextBoldBlack)),
                        Expanded(
                            child: Text('TBll', style: minisubtitleTextBlack)),
                        const Text(':\t'),
                        Expanded(
                          child: Text("-", style: minisubtitleTextBlack),
                        ),
                        Expanded(
                            child: Text(' ', style: minisubtitleTextBlack)),
                        const Text(' '),
                        Expanded(
                          child: Text(" ", style: minisubtitleTextBlack),
                        ),
                        Expanded(
                            child: Text(' ', style: minisubtitleTextBlack)),
                        const Text(' '),
                        Expanded(
                          child: Text(" ", style: minisubtitleTextBlack),
                        ),
                        Expanded(
                            child: Text(' ', style: minisubtitleTextBlack)),
                        const Text(' '),
                        Expanded(
                          child: Text(' ', style: minisubtitleTextBlack),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeightForm(String idStr) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "Tare Weight\n(Kg)",
                  style: subtitleTextBlack,
                ),
              ),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
                child: const Center(child: Text(":"))),
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: WidgetForm(
                  controller: tare,
                  alert: 'harus Diisi',
                  hint: "",
                  border: InputBorder.none,
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "Empty Weight\n(Kg)",
                  style: subtitleTextBlack,
                ),
              ),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
                child: const Center(child: Text(":"))),
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: WidgetForm(
                  controller: empty,
                  alert: 'harus Diisi',
                  hint: "",
                  border: InputBorder.none,
                  onSubmit: () {
                    Provider.of<ProviderProduksi>(context, listen: false)
                        .updateDataLoadingTube(context, int.parse(tare.text),
                            int.parse(empty.text), 0, 2, idStr);
                    setState(() {
                      _showForm = false;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        WidgetButtonCustom(
          FullWidth: MediaQuery.of(context).size.width * 0.25,
          FullHeight: MediaQuery.of(context).size.height * 0.03,
          title: 'Submit',
          onpressed: () {
            Provider.of<ProviderProduksi>(context, listen: false)
                .updateDataLoadingTube(context, int.parse(tare.text),
                    int.parse(empty.text), 0, 2, idStr);
            setState(() {
              _showForm = false;
            });
          },
          bgColor: PRIMARY_COLOR,
          color: Colors.transparent,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
      ],
    );
  }

  Widget _buildWeightFormFilled(int tw, int ew, String idStr) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "Filled Weight\n(Kg)",
                  style: subtitleTextBlack,
                ),
              ),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
                child: const Center(child: Text(":"))),
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: WidgetForm(
                  controller: tare,
                  alert: 'harus Diisi',
                  hint: "",
                  border: InputBorder.none,
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Text(
                "Status",
                style: subtitleTextBlack,
              ),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
                child: const Center(child: Text(":"))),
            Expanded(
              flex: 4,
              child: Align(
                alignment: Alignment.centerLeft,
                child: GroupButton(
                    isRadio: true,
                    options: GroupButtonOptions(
                      selectedColor: PRIMARY_COLOR,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    onSelected: (value, index, isSelected) {
                      print('DATA KLIK : $value - $index - $isSelected');
                    },
                    buttons: const ['OK', "NO"]),
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        WidgetButtonCustom(
          FullWidth: MediaQuery.of(context).size.width * 0.25,
          FullHeight: MediaQuery.of(context).size.height * 0.03,
          title: 'Submit',
          onpressed: () {
            Provider.of<ProviderProduksi>(context, listen: false)
                .updateDataLoadingTube(
                    context, tw, ew, int.parse(tare.text), 3, idStr);
            setState(() {
              _showForm = false;
            });
          },
          bgColor: PRIMARY_COLOR,
          color: Colors.transparent,
        ),
      ],
    );
  }
}
