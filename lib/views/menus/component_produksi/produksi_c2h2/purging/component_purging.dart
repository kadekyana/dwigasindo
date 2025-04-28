import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dwigasindo/model/modelLoadingTubeMixGas.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_produksi.dart';
import 'package:dwigasindo/views/menus/menu_scan.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';

class ComponentPurging extends StatefulWidget {
  ComponentPurging({super.key, required this.title, required this.fill});
  String title;
  int fill;

  @override
  _ComponentPurgingState createState() => _ComponentPurgingState();
}

class _ComponentPurgingState extends State<ComponentPurging>
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
    Timer.periodic(const Duration(seconds: 1), (timer) async {
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
        title: "${widget.title} Tabung",
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
          // TabBar untuk navigasi
          TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: "Purging"),
              Tab(text: "Finish"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Konten untuk setiap tab
                _buildPurgingTab(width, height),
                _buildFinishTab(width, height),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPurgingTab(double width, double height) {
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
                              builder: (context) => MenuScan(
                                    title: 'Tube',
                                  )));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PurgingIsiData(),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/scan.svg',
                                width: 30,
                                height: 30,
                              ),
                              const SizedBox(width: 5),
                              const Text('Scan Isi'),
                            ],
                          ),
                        ),
                        const Expanded(child: SizedBox.shrink()),
                        WidgetButtonCustom(
                            FullWidth: width * 0.35,
                            FullHeight: height * 0.05,
                            title: "Tambah Tabung",
                            onpressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MenuScan(
                                    title: 'Tube',
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
                                    onIsiDataPressed: () {},
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
            child: (data!.tubeLoadingDetail?.length != 0)
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.01,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                flex: 1, child: Center(child: Text('Status'))),
                            Expanded(child: Center(child: Text('OK'))),
                            Expanded(child: Center(child: Text('99'))),
                            Expanded(child: Center(child: Text('1'))),
                            Expanded(
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
                                value: 9 / 10,
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
                                  final dataTube =
                                      data.tubeLoadingDetail![index];
                                  print(dataTube.tubeNo);
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
                                          "id": dataTube.idStr ?? "-",
                                          "tube": dataTube.tubeId ?? "-",
                                          "no": dataTube.tubeNo ?? "-",
                                          'CB':
                                              dataTube.prefillCheckBody ?? "-",
                                          'CV':
                                              dataTube.prefillCheckValve ?? "-",
                                          'VENT': dataTube.prefillVent ?? "-",
                                          'HT':
                                              dataTube.prefillHammerTest ?? "-",
                                          'CT':
                                              dataTube.postfillColdTest ?? "-",
                                          'TBI': dataTube.productionT0Weight ??
                                              "-",
                                          'TBII':
                                              dataTube.postfillT2Weight ?? "-",
                                          'Rak': dataTube.tubeShelfName ?? "-",
                                          'status': "OK",
                                          'date': "-",
                                          'time': "-",
                                          'creator': "-",
                                        },
                                        onIsiDataPressed: () {},
                                      ),
                                    ],
                                  );
                                })),
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
                    title: 'Back Prefill',
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
}

class PurgingIsiData extends StatefulWidget {
  const PurgingIsiData({super.key});

  @override
  State<PurgingIsiData> createState() => _PurgingIsiDataState();
}

class _PurgingIsiDataState extends State<PurgingIsiData> {
  List<Map<String, dynamic>> formList = []; // List untuk menyimpan data form
  // Fungsi untuk menambah form baru
  void _addForm() {
    setState(() {
      formList.add({"item_id": null, "qty": null, "note": null});
    });
  }

  // Fungsi untuk menghapus form terakhir
  void _removeForm(int index) {
    setState(() {
      formList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: WidgetAppbar(
        title: "Scan Isi",
        colorBG: Colors.grey.shade100,
        colorTitle: Colors.black,
        colorBack: Colors.black,
        back: true,
        center: true,
        route: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: formList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(left: 16.w, right: 10.w, top: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Item ${index + 1}',
                              style: titleTextBlack,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: IconButton(
                              onPressed: () => _removeForm(index),
                              icon: const Icon(Icons.delete),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: width,
                      height: 100.h,
                      child: ListTile(
                        title: Text(
                          'Pilih Item',
                          style: subtitleTextBlack,
                        ),
                        subtitle: Align(
                          alignment: Alignment.topLeft,
                          child: Consumer<ProviderDistribusi>(
                            builder: (context, provider, child) {
                              // final pic = provider.customer!.data!
                              //     .map((data) => {'id': data.id, 'name': data.name})
                              //     .toList();

                              return CustomDropdown(
                                decoration: CustomDropdownDecoration(
                                    closedBorder:
                                        Border.all(color: Colors.grey.shade400),
                                    expandedBorder: Border.all(
                                        color: Colors.grey.shade400)),
                                hintText: 'Pilih Item',
                                // items: pic.map((e) => e['name']).toList(),
                                items: const ['Item 1', 'Item 2', 'Item 3'],
                                onChanged: (item) {
                                  print("Selected Item: $item");
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width,
                      height: 80.h,
                      child: ListTile(
                        title: Text(
                          'Qty',
                          style: subtitleTextBlack,
                        ),
                        subtitle: Container(
                          margin: EdgeInsets.only(top: height * 0.01),
                          child: WidgetForm(
                            change: (value) {},
                            alert: 'Qty',
                            hint: 'Qty',
                            typeInput: TextInputType.number,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    SizedBox(
                      width: width,
                      height: 120.h,
                      child: ListTile(
                        title: Text(
                          'Catatan',
                          style: subtitleTextBlack,
                        ),
                        subtitle: Container(
                          margin: EdgeInsets.only(top: height * 0.01),
                          height: 100.h,
                          child: TextField(
                            onChanged: (value) {},
                            maxLines: null,
                            expands: true,
                            decoration: InputDecoration(
                              hintText: 'Masukkan catatan di sini...',
                              contentPadding: const EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            style: subtitleTextBlack,
                            textAlignVertical: TextAlignVertical.top,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(
              height: 50.h,
            ),
            SizedBox(
              width: width,
              height: height * 0.06,
              child: Align(
                alignment: Alignment.topCenter,
                child: WidgetButtonCustom(
                    FullWidth: width * 0.9,
                    FullHeight: 40.h,
                    title: 'Tambah Form Item',
                    onpressed: _addForm,
                    bgColor: PRIMARY_COLOR,
                    color: PRIMARY_COLOR),
              ),
            ),
            SizedBox(
              width: width,
              height: height * 0.06,
              child: Align(
                alignment: Alignment.topCenter,
                child: WidgetButtonCustom(
                    FullWidth: width * 0.9,
                    FullHeight: 40.h,
                    title: 'Mulai Scan',
                    onpressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MenuScan(
                            title: 'Scan Isi',
                          ),
                        ),
                      );
                    },
                    bgColor: COMPLEMENTARY_COLOR4,
                    color: COMPLEMENTARY_COLOR4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
