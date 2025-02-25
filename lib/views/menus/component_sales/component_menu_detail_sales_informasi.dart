import 'dart:async';

import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/model/modelLoadingTube.dart';
import 'package:dwigasindo/providers/provider_produksi.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:group_button/group_button.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ComponentMenuDetailSalesInformasi extends StatefulWidget {
  ComponentMenuDetailSalesInformasi({super.key, required this.title});
  String title;

  @override
  _ComponentMenuDetailSalesInformasiState createState() =>
      _ComponentMenuDetailSalesInformasiState();
}

class _ComponentMenuDetailSalesInformasiState
    extends State<ComponentMenuDetailSalesInformasi>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int? _selectedCardIndex;
  bool _showForm = false;
  Set<int> expandedCards = {};

  final TextEditingController tare = TextEditingController();
  final TextEditingController empty = TextEditingController();

  late Map<int, StreamController<ModelLoadingTube>> _streamControllers;

  GroupButtonController? menu = GroupButtonController(selectedIndex: 0);
  bool selectMenu = true;

  @override
  void initState() {
    super.initState();

    // Inisialisasi StreamController untuk setiap status (tab)
    _streamControllers = {
      0: StreamController<ModelLoadingTube>.broadcast(),
      1: StreamController<ModelLoadingTube>.broadcast(),
      2: StreamController<ModelLoadingTube>.broadcast(),
      3: StreamController<ModelLoadingTube>.broadcast(),
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
    Timer.periodic(Duration(seconds: 1), (timer) async {
      if (!_streamControllers[status]!.isClosed) {
        final data = await Provider.of<ProviderProduksi>(context, listen: false)
            .getTubeLoading(context, status);
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

  List<_ChartData> data = [
    _ChartData('Jan', 35),
    _ChartData('Feb', 300),
    _ChartData('Mar', 600),
    _ChartData('Apr', 1000),
    _ChartData('Mei', 1000),
    _ChartData('Jun', 1000),
    _ChartData('Jul', 2000),
    _ChartData('Ags', 2000),
    _ChartData('Sep', 2000),
    _ChartData('Okt', 2000),
    _ChartData('Nov', 2200),
    _ChartData('Des', 2300),
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: WidgetAppbar(
        title: widget.title,
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
            height: 10.h,
          ),
          Container(
            width: width,
            height: 400.h,
            margin: EdgeInsets.symmetric(horizontal: 15.w),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade400,
                ),
                borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                SizedBox(
                  height: 5.h,
                ),
                Expanded(
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 5.h),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        )),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text('Nama Sales',
                                                style: subtitleTextBoldBlack))),
                                    Text(':\t'),
                                    Expanded(
                                      child: Text("Jhon Doe",
                                          style: subtitleTextBlack),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text('NIK',
                                                style: subtitleTextBoldBlack))),
                                    Text(':\t'),
                                    Expanded(
                                      child: Text("2200202021318",
                                          style: subtitleTextBlack),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text('Status Karyawan',
                                                style: subtitleTextBoldBlack))),
                                    Text(':\t'),
                                    Expanded(
                                      child: Text("Tetap",
                                          style: subtitleTextBlack),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text('Pencapaian Sales',
                                                style: subtitleTextBoldBlack))),
                                    Text(':\t'),
                                    Expanded(
                                      child: Text("Rp.100.000.000",
                                          style: subtitleTextBlack),
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
                ),
                SizedBox(
                  height: 5.h,
                ),
                Expanded(
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: CircularPercentIndicator(
                            radius: 45.h, // Ukuran radius lingkaran
                            lineWidth: 5, // Ketebalan garis progress
                            percent: 50.0 / 100.0, // Nilai progress (0.0 - 1.0)
                            center: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Target", // Teks di bawah angka
                                    style: minisubtitleTextGrey),
                                Text("5.000.000", // Angka persentase
                                    style: subtitleTextBlack),
                                Text("Lagi", // Teks di bawah angka
                                    style: minisubtitleTextGrey),
                              ],
                            ),
                            backgroundColor: Colors
                                .grey.shade300, // Warna background lingkaran
                            progressColor: PRIMARY_COLOR, // Warna progress
                            circularStrokeCap:
                                CircularStrokeCap.round, // Gaya ujung progress
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
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text('Jumlah Leads',
                                                style: subtitleTextBoldBlack))),
                                    Text(':\t'),
                                    Expanded(
                                      child:
                                          Text("5", style: subtitleTextBlack),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text('Jumlah Customer',
                                                style: subtitleTextBoldBlack))),
                                    Text(':\t'),
                                    Expanded(
                                      child:
                                          Text("18", style: subtitleTextBlack),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text('Jumlah Order',
                                                style: subtitleTextBoldBlack))),
                                    Text(':\t'),
                                    Expanded(
                                      child:
                                          Text("15", style: subtitleTextBlack),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text('Jumlah Closing',
                                                style: subtitleTextBoldBlack))),
                                    Text(':\t'),
                                    Expanded(
                                      child:
                                          Text("5", style: subtitleTextBlack),
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
                ),
                SizedBox(
                  height: 5.h,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: SfCartesianChart(
                      primaryXAxis: const CategoryAxis(
                        title: AxisTitle(text: 'Bulan'),
                        // Rotasi teks agar lebih terbaca
                        majorGridLines: MajorGridLines(
                            width: 0), // Hilangkan garis grid vertikal
                      ),
                      primaryYAxis: const NumericAxis(
                        title: AxisTitle(text: 'Jumlah Penjualan'),
                        minimum: 0,
                        maximum: 2500,
                        interval: 500,
                      ),
                      tooltipBehavior:
                          TooltipBehavior(enable: true), // Tooltip saat hover
                      series: <CartesianSeries<_ChartData, String>>[
                        SplineSeries<_ChartData, String>(
                          dataSource: data,
                          xValueMapper: (_ChartData sales, _) => sales.month,
                          yValueMapper: (_ChartData sales, _) => sales.sales,
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: true),
                          markerSettings: const MarkerSettings(
                              isVisible: true), // Tampilkan titik data
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: "History Order"),
              Tab(text: "Customer"),
              Tab(text: "Leads"),
              Tab(text: "Tugas"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Konten untuk setiap tab
                _buildSelesaiProduksiQCTab(width, height),
                _buildKondisiTab(width, height),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSelesaiProduksiQCTab(double width, double height) {
    return StreamBuilder<ModelLoadingTube>(
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
                  SizedBox(height: 10),
                  // (data.tubeLoadingDetail?.length != 0)
                  //     ? Expanded(
                  //         child: ListView.builder(
                  //           itemCount: data.tubeLoadingDetail!.length,
                  //           itemBuilder: (context, index) {
                  //             final dataTube = data.tubeLoadingDetail![index];
                  //             print(dataTube.tubeNo);
                  //             return Column(
                  //               children: [
                  //                 _buildInfoCard(
                  //                   isOkay: true,
                  //                   width: width,
                  //                   height: height,
                  //                   data: {
                  //                     "id": dataTube.idStr ?? "-",
                  //                     "tube": dataTube.tubeId ?? "-",
                  //                     "no": dataTube.tubeNo ?? "-",
                  //                     'EW': dataTube.emptyWeight ?? "-",
                  //                     'Rak': dataTube.tubeShelfName ?? "-",
                  //                     'FW': dataTube.filledWeight ?? "-",
                  //                     'TW': dataTube.tareWeight ?? "-",
                  //                     'status': "OK",
                  //                     'Solven': "-",
                  //                     'date': "-",
                  //                     'time': "-",
                  //                     'creator': "-",
                  //                   },
                  //                   onIsiDataPressed: () {},
                  //                 ),
                  //               ],
                  //             );
                  //           },
                  //         ),
                  //       )
                  //     :
                  Expanded(
                    child: Center(
                      child: Text(
                        'Belum Terdapat Data',
                        style: titleTextBlack,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(child: Text('No data found'));
        }
      },
    );
  }

  Widget _buildKondisiTab(double width, double height) {
    return StreamBuilder<ModelLoadingTube>(
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
            child:
                // (data.tubeLoadingDetail?.length != 0)
                //     ? Padding(
                //         padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                //         child: Column(
                //           children: [
                //             SizedBox(
                //               height: 10.h,
                //             ),
                //             Expanded(
                //               child: ListView.builder(
                //                 itemCount: data.tubeLoadingDetail!.length,
                //                 itemBuilder: (context, index) {
                //                   final dataTube = data.tubeLoadingDetail![index];

                //                   return Column(
                //                     children: [
                //                       _buildInfoCardKondisi(
                //                         isOkay: true,
                //                         width: width,
                //                         height: height,
                //                         showIsiDataButton: false,
                //                         data: {
                //                           "id": dataTube.idStr ?? "-",
                //                           "tube": dataTube.tubeId ?? "-",
                //                           "no": dataTube.tubeNo ?? "-",
                //                           'EW': dataTube.emptyWeight ?? "-",
                //                           'Rak': dataTube.tubeShelfName ?? "-",
                //                           'FW': dataTube.filledWeight ?? "-",
                //                           'TW': dataTube.tareWeight ?? "-",
                //                           'status': (dataTube.tubeStatus == 0)
                //                               ? "NO"
                //                               : "OK",
                //                           'Solven': "-",
                //                           'date': "-",
                //                           'time': "-",
                //                           'creator': "-",
                //                         },
                //                         isExpanded: expandedCards.contains(index),
                //                         onToggleExpand: () {
                //                           setState(() {
                //                             if (expandedCards.contains(index)) {
                //                               expandedCards.remove(index);
                //                             } else {
                //                               expandedCards.add(index);
                //                             }
                //                           });
                //                         },
                //                         onIsiDataPressed: () {
                //                           if (_selectedCardIndex != index ||
                //                               !_showForm) {
                //                             setState(() {
                //                               _selectedCardIndex = index;
                //                               _showForm = true;
                //                             });
                //                             _stopStream(3);
                //                           } else {
                //                             setState(() {
                //                               _showForm = false;
                //                             });
                //                             _startStream(3);
                //                           }
                //                         },
                //                       ),
                //                       if (_showForm && _selectedCardIndex == index)
                //                         const SizedBox(height: 16),
                //                     ],
                //                   );
                //                 },
                //               ),
                //             ),
                //           ],
                //         ),
                //       )
                //     :
                Expanded(
              child: Center(
                  child: Text(
                'Belum Terdapat Data',
                style: titleTextBlack,
              )),
            ),
          );
        } else {
          return Center(child: Text('No data found'));
        }
      },
    );
  }

  Widget _buildInfoCard({
    required double width,
    required double height,
    required Map<String, dynamic> data,
    bool isKondisi = false,
    bool showMaintenanceButton =
        true, // Default untuk menampilkan tombol Maintenance
    bool showIsiDataButton =
        true, // Default untuk menampilkan tombol Maintenance
    bool isOkay = false,
    required VoidCallback onIsiDataPressed,
  }) {
    return Container(
      width: width,
      height: 160.h,
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
          (isOkay == true)
              ? _buildListItemHeaderS(width, data)
              : _buildListItemHeader(width, data),
          _buildListItemBody(width, height, data, showMaintenanceButton,
              (isOkay) == true ? true : false),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width * 0.01,
                ),
                Expanded(
                  child: WidgetButtonCustom(
                      FullWidth:
                          (showIsiDataButton) ? width * 0.25 : width * 0.35,
                      FullHeight: 30,
                      title: 'Riwayat',
                      onpressed: () async {},
                      bgColor: PRIMARY_COLOR,
                      color: Colors.transparent),
                ),
                SizedBox(
                  width: width * 0.01,
                ),
                (showMaintenanceButton)
                    ? Expanded(
                        child: WidgetButtonCustom(
                          FullWidth:
                              (showIsiDataButton) ? width * 0.25 : width * 0.35,
                          FullHeight: 30,
                          title: 'Maintenance',
                          onpressed: () {},
                          bgColor: PRIMARY_COLOR,
                          color: Colors.transparent,
                        ),
                      )
                    : SizedBox.shrink(),
                SizedBox(
                  width: width * 0.01,
                ),
                (showIsiDataButton)
                    ? Expanded(
                        child: WidgetButtonCustom(
                          FullWidth: width * 0.25,
                          FullHeight: 30,
                          title: 'Isi Data',
                          onpressed: onIsiDataPressed,
                          bgColor: PRIMARY_COLOR,
                          color: Colors.transparent,
                        ),
                      )
                    : SizedBox()
              ],
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCardKondisi({
    required double width,
    required double height,
    required Map<String, dynamic> data,
    required bool isExpanded,
    required VoidCallback onToggleExpand,
    bool showMaintenanceButton = true,
    bool showIsiDataButton = true,
    bool isOkay = false,
    required VoidCallback onIsiDataPressed,
  }) {
    return Container(
      width: width,
      height: isExpanded ? 400.h : 200.h,
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
          (isOkay == true)
              ? _buildListItemHeaderS(width, data)
              : _buildListItemHeader(width, data),
          _buildListItemBody(width, height, data, showMaintenanceButton,
              (isOkay) == true ? true : false),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: WidgetButtonCustom(
                    FullWidth:
                        (showIsiDataButton) ? width * 0.25 : width * 0.35,
                    FullHeight: 30,
                    title: 'Riwayat',
                    onpressed: () async {},
                    bgColor: PRIMARY_COLOR,
                    color: Colors.transparent,
                  ),
                ),
                SizedBox(width: width * 0.01),
                if (showMaintenanceButton)
                  Expanded(
                    child: WidgetButtonCustom(
                      FullWidth:
                          (showIsiDataButton) ? width * 0.25 : width * 0.35,
                      FullHeight: 30,
                      title: 'Maintenance',
                      onpressed: () {},
                      bgColor: PRIMARY_COLOR,
                      color: Colors.transparent,
                    ),
                  ),
                SizedBox(width: width * 0.01),
                if (showIsiDataButton)
                  Expanded(
                    child: WidgetButtonCustom(
                      FullWidth: width * 0.25,
                      FullHeight: 30,
                      title: 'Isi Data',
                      onpressed: onIsiDataPressed,
                      bgColor: PRIMARY_COLOR,
                      color: Colors.transparent,
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 5.h),
          if (isExpanded)
            Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    children: [
                      Divider(),
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
                                child: Text('Tabung Bawah',
                                    style: minisubtitleTextBlack)),
                            Text(':\t'),
                            Expanded(
                              child:
                                  SvgPicture.asset('assets/images/ceklist.svg'),
                            ),
                            Expanded(
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Safety Flug',
                                        style: minisubtitleTextBlack))),
                            Text(':\t'),
                            Expanded(
                              child:
                                  SvgPicture.asset('assets/images/ceklist.svg'),
                            ),
                            Expanded(
                                child: Text('Tekanan (17 - 19) bar',
                                    style: minisubtitleTextBlack)),
                            Text(':'),
                            Expanded(
                              child: Text('18', style: minisubtitleTextBlack),
                            ),
                            Expanded(
                                child:
                                    Text('Pen', style: minisubtitleTextBlack)),
                            Text(':'),
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
                                child: Text('Body Tabung',
                                    style: minisubtitleTextBlack)),
                            Text(':\t'),
                            Expanded(
                              child:
                                  SvgPicture.asset('assets/images/ceklist.svg'),
                            ),
                            Expanded(
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Isi Gas(Kg)',
                                        style: minisubtitleTextBlack))),
                            Text(':\t'),
                            Expanded(
                              child:
                                  Text('10000', style: minisubtitleTextBlack),
                            ),
                            Expanded(
                                child: Text('Teflon',
                                    style: minisubtitleTextBlack)),
                            Text(':'),
                            Expanded(
                              child:
                                  SvgPicture.asset('assets/images/ceklist.svg'),
                            ),
                            Expanded(
                                child: Text('Kaki Tabung',
                                    style: minisubtitleTextBlack)),
                            Text(':'),
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
                                child:
                                    Text('Krop', style: minisubtitleTextBlack)),
                            Text(':\t'),
                            Expanded(
                              child:
                                  SvgPicture.asset('assets/images/ceklist.svg'),
                            ),
                            Expanded(
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Tutup Tabung',
                                        style: minisubtitleTextBlack))),
                            Text(':\t'),
                            Expanded(
                              child:
                                  SvgPicture.asset('assets/images/ceklist.svg'),
                            ),
                            Expanded(
                                child: Text('Draft Valve',
                                    style: minisubtitleTextBlack)),
                            Text(':'),
                            Expanded(
                              child:
                                  SvgPicture.asset('assets/images/ceklist.svg'),
                            ),
                            Expanded(
                                child: Text('', style: minisubtitleTextBlack)),
                            Text(''),
                            Expanded(
                              child: Text(
                                "",
                                style: minisubtitleTextNormal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Dibuat oleh',
                                    style: minisubtitleTextNormal),
                              ),
                            ),
                            Text(':\t'),
                            Expanded(
                              flex: 2,
                              child: Align(
                                child: Text(
                                  "Dwi Gitayana Putra",
                                  style: minisubtitleTextNormal,
                                ),
                              ),
                            ),
                            Expanded(
                                child: Align(
                              child: Text('Dibuat pada',
                                  style: minisubtitleTextNormal),
                            )),
                            Text(':\t'),
                            Expanded(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "11 - 8 - 2024 | 10 : 30",
                                  style: minisubtitleTextNormal,
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

  Widget _buildListItemHeader(double width, Map<String, dynamic> data) {
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
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text('Dibuat oleh: -', style: subtitleTextNormal),
            ),
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
      child: Stack(
        children: [
          // Bagian hijau (OK)
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: width * 0.45, // Lebar hingga setengah layar
              height: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: width * 0.06),
              decoration: BoxDecoration(
                color: (data['status'].toString() == "NO")
                    ? SECONDARY_COLOR
                    : const Color(0xFF4CAF50), // Warna hijau
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    topLeft: Radius.circular(15)),
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(data['status'].toString(), style: titleText),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: FittedBox(
                      alignment: Alignment.bottomRight,
                      fit: BoxFit.scaleDown,
                      child: Text('TW: ${data['TW'].toString()}',
                          style: minisubtitleTextBlack),
                    ),
                  ),
                  Expanded(
                    child: FittedBox(
                      alignment: Alignment.topRight,
                      fit: BoxFit.scaleDown,
                      child: Text('Dibuat Oleh: User 1',
                          style: minisubtitleTextNormal),
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

  Widget _buildListItemBodyKondisi(double width, double height,
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
                            flex: 2,
                            child: Text('Prefill', style: subtitleTextBlack)),
                        Expanded(
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('EW', style: subtitleTextBlack))),
                        Text(':\t'),
                        Expanded(
                          child: Text('${data['EW'] ?? "-"}',
                              style: subtitleTextBlack),
                        ),
                        Expanded(
                            child: Text('Solven', style: subtitleTextBlack)),
                        Text(':'),
                        Expanded(
                          child: Text('\t -', style: subtitleTextBlack),
                        ),
                      ],
                    ),
                  ),
                  // Baris tengah
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child:
                                Text('Production', style: subtitleTextBlack)),
                        Expanded(child: Text('Rak', style: subtitleTextBlack)),
                        const Text(':\t'),
                        Expanded(
                          child: Text("-", style: subtitleTextBlack),
                        ),
                        Expanded(child: Text('', style: subtitleTextBlack)),
                        const Text(''),
                        Expanded(
                          child: Text('', style: subtitleTextBlack),
                        ),
                      ],
                    ),
                  ),
                  // Baris bawah
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text('Postfill', style: subtitleTextBlack)),
                        Expanded(
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('FW', style: subtitleTextBlack))),
                        Text(':\t'),
                        Expanded(
                          child: Text('${data['FW'] ?? "-"}',
                              style: subtitleTextBlack),
                        ),
                        (fm == true)
                            ? Expanded(
                                child: Text('FM', style: subtitleTextBlack))
                            : Expanded(child: SizedBox.shrink()),
                        (fm == true) ? Text(':') : const Text(''),
                        (fm == true)
                            ? Expanded(
                                child: Text('\t${data['FM'] ?? "-"}',
                                    style: subtitleTextBlack),
                              )
                            : Expanded(child: SizedBox.shrink()),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child:
                                Text('Dibuat Pada', style: subtitleTextNormal)),
                        Expanded(
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('-', style: subtitleTextNormal))),
                        Expanded(child: SizedBox.shrink()),
                        Expanded(child: SizedBox.shrink()),
                        Expanded(child: SizedBox.shrink()),
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
                            flex: 2,
                            child: Text('Prefill', style: subtitleTextBlack)),
                        Expanded(
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('EW', style: subtitleTextBlack))),
                        Text(':\t'),
                        Expanded(
                          child: Text('${data['EW'] ?? "-"}',
                              style: subtitleTextBlack),
                        ),
                        Expanded(
                            child: Text('Solven', style: subtitleTextBlack)),
                        Text(':'),
                        Expanded(
                          child: Text('\t -', style: subtitleTextBlack),
                        ),
                      ],
                    ),
                  ),
                  // Baris tengah
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child:
                                Text('Production', style: subtitleTextBlack)),
                        Expanded(child: Text('Rak', style: subtitleTextBlack)),
                        const Text(':\t'),
                        Expanded(
                          child: Text("-", style: subtitleTextBlack),
                        ),
                        Expanded(child: Text('', style: subtitleTextBlack)),
                        const Text(''),
                        Expanded(
                          child: Text('', style: subtitleTextBlack),
                        ),
                      ],
                    ),
                  ),
                  // Baris bawah
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text('Postfill', style: subtitleTextBlack)),
                        Expanded(
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('FW', style: subtitleTextBlack))),
                        Text(':\t'),
                        Expanded(
                          child: Text('${data['FW'] ?? "-"}',
                              style: subtitleTextBlack),
                        ),
                        (fm == true)
                            ? Expanded(
                                child: Text('FM', style: subtitleTextBlack))
                            : Expanded(child: SizedBox.shrink()),
                        (fm == true) ? Text(':') : const Text(''),
                        (fm == true)
                            ? Expanded(
                                child: Text('\t${data['FM'] ?? "-"}',
                                    style: subtitleTextBlack),
                              )
                            : Expanded(child: SizedBox.shrink()),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child:
                                Text('Dibuat Pada', style: subtitleTextNormal)),
                        Expanded(
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('-', style: subtitleTextNormal))),
                        Expanded(child: SizedBox.shrink()),
                        Expanded(child: SizedBox.shrink()),
                        Expanded(child: SizedBox.shrink()),
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

// / Model data untuk grafik
class _ChartData {
  _ChartData(this.month, this.sales);
  final String month;
  final double sales;
}
