import 'dart:async';

import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/model/modelLoadingTube.dart';
import 'package:dwigasindo/providers/provider_sales.dart';
import 'package:dwigasindo/views/menus/component_maintenance/component_button_maintenance.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';

class ComponentClaimList extends StatefulWidget {
  ComponentClaimList({super.key, required this.title});
  String title;

  @override
  _ComponentClaimListState createState() => _ComponentClaimListState();
}

class _ComponentClaimListState extends State<ComponentClaimList>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int? _selectedCardIndex;
  final bool _showForm = false;
  Set<int> expandedCards = {};

  final TextEditingController tare = TextEditingController();
  final TextEditingController empty = TextEditingController();

  late Map<int, StreamController<ModelLoadingTube>> _streamControllers;

  GroupButtonController? menu = GroupButtonController(selectedIndex: 0);
  bool selectMenu = true;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this);

    // Menambahkan listener untuk mendeteksi perubahan tab
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        final currentIndex = _tabController.index;
        // Memanggil fungsi untuk mendapatkan data sesuai tab yang aktif
        _getDataForTab(currentIndex);
      }
    });
  }

  // Fungsi untuk mendapatkan data sesuai tab yang aktif
  void _getDataForTab(int tabIndex) {
    // Fungsi untuk mengambil data berdasarkan tab yang aktif
    switch (tabIndex) {
      case 0:
        // Tab List
        print("Get data for List");
        Provider.of<ProviderSales>(context, listen: false)
            .getListMaintenance(context, 0, 0);
        // Panggil fungsi untuk mendapatkan data List
        break;
      case 1:
        // Tab Ready to use
        print("Get data for Ready to use");
        Provider.of<ProviderSales>(context, listen: false)
            .getListMaintenance(context, 0, 3);
        // Panggil fungsi untuk mendapatkan data Ready to use
        break;
      case 2:
        // Tab Afkir
        print("Get data for Afkir");
        Provider.of<ProviderSales>(context, listen: false)
            .getListMaintenance(context, 0, 5);
        // Panggil fungsi untuk mendapatkan data Afkir
        break;
      case 3:
        // Tab Retur
        print("Get data for Retur");
        Provider.of<ProviderSales>(context, listen: false)
            .getListMaintenance(context, 0, 4);
        // Panggil fungsi untuk mendapatkan data Retur
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    _tabController.dispose(); // Jangan lupa untuk dispose controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderSales>(context);
    final summary = provider.modelSummaryMaintenance?.data;
    return Scaffold(
      appBar: WidgetAppbar(
        title: "List Tabung Claim",
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
          TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: "List"),
              Tab(text: "Maintenance"),
              Tab(text: "Return Customer"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ComponentMenuList(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ComponentMenuList extends StatefulWidget {
  const ComponentMenuList({
    super.key,
  });

  @override
  State<ComponentMenuList> createState() => _ComponentMenuListState();
}

class _ComponentMenuListState extends State<ComponentMenuList> {
  bool check = true;
  GroupButtonController? menu = GroupButtonController(selectedIndex: 0);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderSales>(context);
    final data = provider.maintenance?.data;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: ListView.builder(
          itemCount: data?.length,
          itemBuilder: (context, index) {
            final dataCard = data?[index];
            return (data!.isEmpty)
                ? Container(
                    width: double.maxFinite,
                    height: 200.h,
                    child: Center(
                      child: Text("Belum Terdapat Data"),
                    ),
                  )
                : Container(
                    width: double.maxFinite,
                    height: 200.h,
                    margin: EdgeInsets.only(bottom: 10.h),
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
                          height: 40.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 130.w,
                                height: 40.h,
                                decoration: const BoxDecoration(
                                  color: PRIMARY_COLOR,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(30),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    dataCard?.maintenanceNo ?? "-",
                                    style: titleText,
                                  ),
                                ),
                              ),
                              Container(
                                  width: 100.w,
                                  height: 30.h,
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: WidgetButtonCustom(
                                    FullWidth: 100.w,
                                    FullHeight: 30.h,
                                    title: "Riwayat",
                                    color: PRIMARY_COLOR,
                                    bgColor: PRIMARY_COLOR,
                                  )),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 0.025, vertical: 5.h),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(color: Colors.grey.shade300),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 90.w,
                                  height: 80.h,
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Produk',
                                                  style: subtitleTextBlack,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  ' : ',
                                                  style: subtitleTextBlack,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  dataCard?.tubeTypeName ?? "-",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.justify,
                                                  style: subtitleTextBlack,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Grade',
                                                  style: subtitleTextBlack,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  ' : ',
                                                  style: subtitleTextBlack,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                    dataCard?.tubeGradeName ??
                                                        "-",
                                                    style: subtitleTextBlack),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Lokasi',
                                                  style: subtitleTextBlack,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  ' : ',
                                                  style: subtitleTextBlack,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                alignment: Alignment.centerLeft,
                                                child: Text("-",
                                                    style: subtitleTextBlack),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Milik',
                                                  style: subtitleTextBlack,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  ' : ',
                                                  style: subtitleTextBlack,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                    (dataCard?.ownerShipType ==
                                                            null)
                                                        ? "-"
                                                        : (dataCard?.ownerShipType ==
                                                                1)
                                                            ? "Asset"
                                                            : "Customer",
                                                    style: subtitleTextBlack),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Catatan',
                                                  style: subtitleTextBlack,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  ' : ',
                                                  style: subtitleTextBlack,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  dataCard?.tubeGasName ?? "-",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.justify,
                                                  style: subtitleTextBlack,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Dibuat Oleh',
                                                  style: subtitleTextNormal,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  ' : ',
                                                  style: subtitleTextNormal,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                    dataCard?.createdByName ??
                                                        "-",
                                                    style: subtitleTextNormal),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Dibuat Pada',
                                                  style: subtitleTextNormal,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  ' : ',
                                                  style: subtitleTextNormal,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                    provider.formatDate(
                                                        dataCard!.createdAt
                                                            .toString()),
                                                    style: subtitleTextNormal),
                                              ),
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
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: 10.h, left: 10.w, right: 10.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: WidgetButtonCustom(
                                  FullWidth: width * 0.3,
                                  FullHeight: 30.h,
                                  title: "Maintenance",
                                  onpressed: () {},
                                  bgColor: PRIMARY_COLOR,
                                  color: Colors.transparent,
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                child: WidgetButtonCustom(
                                  FullWidth: width * 0.3,
                                  FullHeight: 30.h,
                                  title: "Verifikasi",
                                  onpressed: () {},
                                  bgColor: PRIMARY_COLOR,
                                  color: Colors.transparent,
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                child: WidgetButtonCustom(
                                  FullWidth: width * 0.3,
                                  FullHeight: 30.h,
                                  title: "Claim Produksi",
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
                  );
          },
        ),
      ),
    );
  }
}
