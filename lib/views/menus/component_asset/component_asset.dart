import 'dart:async';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_Order.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/providers/provider_sales.dart';
import 'package:dwigasindo/views/menus/component_asset/component_detail.dart';
import 'package:dwigasindo/views/menus/component_asset/component_form.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';

class ComponentAsset extends StatefulWidget {
  ComponentAsset({super.key});

  @override
  _ComponentAssetState createState() => _ComponentAssetState();
}

class _ComponentAssetState extends State<ComponentAsset>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Set<int> expandedCards = {};

  final TextEditingController tare = TextEditingController();
  final TextEditingController empty = TextEditingController();

  GroupButtonController? menu = GroupButtonController(selectedIndex: 0);
  bool selectMenu = true;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this);

    _tabController.addListener(() {
      final currentIndex = _tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderSales>(context);
    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Asset',
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
          TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: "List Asset"),
              Tab(text: "List Arsip"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                CompponentLisAsset(),
                CompponetListArsip(),
                // Konten untuk setiap tab
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CompponentLisAsset extends StatefulWidget {
  const CompponentLisAsset({
    super.key,
  });

  @override
  State<CompponentLisAsset> createState() => _CompponentLisAssetState();
}

class _CompponentLisAssetState extends State<CompponentLisAsset> {
  List<bool> check = [true, false];
  bool non = false;
  GroupButtonController? menu = GroupButtonController(selectedIndex: 0);
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderSales>(context);
    final providerDis = Provider.of<ProviderDistribusi>(context);

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              width: double.maxFinite,
              height: height * 0.1,
              child: Row(
                children: [
                  // Search bar
                  Expanded(
                    flex: 6,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade400,
                          ),
                          borderRadius: BorderRadius.circular(16)),
                      child: WidgetForm(
                        alert: 'Search',
                        hint: 'Search',
                        controller: search,
                        onSubmit: () async {},
                        border: InputBorder.none,
                        preicon: const Icon(
                          Icons.search_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  // filter bar
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                      color: PRIMARY_COLOR,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.filter_list,
                        color: Colors.white,
                      ),
                    ),
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: (provider.produk!.data!.isEmpty)
                  ? const Center(
                      child: Text('Belum Terdapat Produk Trash'),
                    )
                  : ListView.builder(
                      itemCount: provider.produk!.data!.length,
                      itemBuilder: (context, index) {
                        final data = provider.produk?.data![index];
                        return Container(
                          width: double.maxFinite,
                          height: 200.h,
                          margin: EdgeInsets.only(bottom: height * 0.02),
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
                                child: Stack(
                                  children: [
                                    // Bagian hijau (OK)

                                    // Bagian biru (No. 12345)
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        width: 120.w, // 30% dari lebar layar
                                        height: double.infinity,
                                        decoration: const BoxDecoration(
                                          color:
                                              PRIMARY_COLOR, // Warna biru tua
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(30),
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                            (data?.type == 1)
                                                ? "Jenis Asset"
                                                : "Jenis Asset",
                                            style: titleText),
                                      ),
                                    ),
                                    // Bagian kanan (TW: 36.8)
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        width: width * 0.35,
                                        padding: EdgeInsets.only(right: 10.w),
                                        child: FittedBox(
                                          alignment: Alignment.centerRight,
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                              "Dibuat Oleh : ${data!.createdBy}",
                                              style: minisubtitleTextGrey),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 5.h),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                          color: Colors.grey.shade300),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 80.w,
                                        height: 100.h,
                                        decoration: BoxDecoration(
                                            border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                      ),
                                      SizedBox(
                                        width: 10.w,
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
                                                    flex: 2,
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'Nama Asset',
                                                        style:
                                                            subtitleTextNormalblack,
                                                      ),
                                                    ),
                                                  ),
                                                  const Text(':'),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                        '\t${data.name}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            subtitleTextNormalblack),
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
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'Lokasi Asset',
                                                        style:
                                                            subtitleTextNormalblack,
                                                      ),
                                                    ),
                                                  ),
                                                  const Text(':'),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                        '\t${(data.tubeGradeId != null) ? providerDis.getGrade(data.tubeGradeId!) : "-"}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            subtitleTextNormalblack),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'Asset Tag',
                                                        style:
                                                            subtitleTextNormalblack,
                                                      ),
                                                    ),
                                                  ),
                                                  const Text(':'),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                        '\t${(data.note == "") ? "-" : data.note}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            subtitleTextNormalblack),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'Serial',
                                                        style:
                                                            subtitleTextNormalblack,
                                                      ),
                                                    ),
                                                  ),
                                                  const Text(':'),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text('\t-',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            subtitleTextNormalblack),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'Mark',
                                                        style:
                                                            subtitleTextNormalblack,
                                                      ),
                                                    ),
                                                  ),
                                                  const Text(':'),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text('\t-',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            subtitleTextNormalblack),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'Supplier',
                                                        style:
                                                            subtitleTextNormalblack,
                                                      ),
                                                    ),
                                                  ),
                                                  const Text(':'),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text('\t-',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            subtitleTextNormalblack),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'Dibuat Pada',
                                                        style:
                                                            subtitleTextNormalGrey,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    ':',
                                                    style:
                                                        subtitleTextNormalGrey,
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                        '\t${provider.formatDate(data.createdAt.toString())} | ${provider.formatTime(data.createdAt.toString())}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            subtitleTextNormalGrey),
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
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 10.w, right: 10.w, bottom: 5.h),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: WidgetButtonCustom(
                                          FullWidth: width,
                                          FullHeight: 40.h,
                                          title: "Check In",
                                          onpressed: () async {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ComponentFormAsset(
                                                  title: 'Check In Asset',
                                                ),
                                              ),
                                            );
                                          },
                                          bgColor: PRIMARY_COLOR,
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Expanded(
                                        child: WidgetButtonCustom(
                                          FullWidth: width,
                                          FullHeight: 40.h,
                                          title: "Check Out",
                                          onpressed: () async {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ComponentFormAsset(
                                                  title: 'Check Out Asset',
                                                ),
                                              ),
                                            );
                                          },
                                          bgColor: PRIMARY_COLOR,
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Expanded(
                                        child: WidgetButtonCustom(
                                          FullWidth: width,
                                          FullHeight: 40.h,
                                          title: "Lihat Data",
                                          onpressed: () async {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ComponentDetailAsset(),
                                              ),
                                            );
                                          },
                                          bgColor: PRIMARY_COLOR,
                                          color: Colors.transparent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class CompponetListArsip extends StatefulWidget {
  const CompponetListArsip({
    super.key,
  });

  @override
  State<CompponetListArsip> createState() => _CompponetListArsipState();
}

class _CompponetListArsipState extends State<CompponetListArsip> {
  List<bool> check = [true, false];
  bool non = false;
  GroupButtonController? menu = GroupButtonController(selectedIndex: 0);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderSales>(context);
    final providerDis = Provider.of<ProviderDistribusi>(context);

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              width: double.maxFinite,
              height: height * 0.1,
              child: Row(
                children: [
                  // Search bar
                  Expanded(
                    flex: 6,
                    child: Container(
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
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  // filter bar
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                      color: PRIMARY_COLOR,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.filter_list,
                        color: Colors.white,
                      ),
                    ),
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: (provider.produkTrash!.data!.isEmpty)
                  ? const Center(
                      child: Text('Belum Terdapat Produk Trash'),
                    )
                  : ListView.builder(
                      itemCount: provider.produkTrash?.data?.length,
                      itemBuilder: (context, index) {
                        final data = provider.produkTrash?.data?[index];
                        return Container(
                          width: double.maxFinite,
                          height: 160.h,
                          margin: EdgeInsets.only(bottom: height * 0.02),
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
                                child: Stack(
                                  children: [
                                    // Bagian hijau (OK)

                                    // Bagian biru (No. 12345)
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        width: 120.w, // 30% dari lebar layar
                                        height: double.infinity,
                                        decoration: const BoxDecoration(
                                          color:
                                              PRIMARY_COLOR, // Warna biru tua
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(30),
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                            (data?.type == 1) ? "Gas" : "Jasa",
                                            style: titleText),
                                      ),
                                    ),
                                    // Bagian kanan (TW: 36.8)
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        width: width * 0.35,
                                        padding: EdgeInsets.only(right: 10.w),
                                        child: FittedBox(
                                          alignment: Alignment.centerRight,
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                              "Dibuat Oleh : ${data!.createdBy}",
                                              style: minisubtitleTextGrey),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 5.h),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                          color: Colors.grey.shade300),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 80.w,
                                        height: 100.h,
                                        decoration: BoxDecoration(
                                            border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                      ),
                                      SizedBox(
                                        width: 10.w,
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
                                                    flex: 2,
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'Nama Produk',
                                                        style:
                                                            subtitleTextNormalblack,
                                                      ),
                                                    ),
                                                  ),
                                                  const Text(':'),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                        '\t${data.name}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            subtitleTextNormalblack),
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
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'Grade',
                                                        style:
                                                            subtitleTextNormalblack,
                                                      ),
                                                    ),
                                                  ),
                                                  const Text(':'),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                        '\t${(data.tubeGradeId != null) ? providerDis.getGrade(data.tubeGradeId!) : "-"}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            subtitleTextNormalblack),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'Catatan',
                                                        style:
                                                            subtitleTextNormalblack,
                                                      ),
                                                    ),
                                                  ),
                                                  const Text(':'),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                        '\t${(data.note == "") ? "-" : data.note}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            subtitleTextNormalblack),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'Harga',
                                                        style:
                                                            subtitleTextNormalblack,
                                                      ),
                                                    ),
                                                  ),
                                                  const Text(':'),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                        '\t${provider.formatCurrency(data.price as num)}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            subtitleTextNormalblack),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'Dibuat Pada',
                                                        style:
                                                            subtitleTextNormalGrey,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    ':',
                                                    style:
                                                        subtitleTextNormalGrey,
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                        '\t${provider.formatDate(data.createdAt.toString())} | ${provider.formatTime(data.createdAt.toString())}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            subtitleTextNormalGrey),
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
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 10.w, right: 10.w, bottom: 5.h),
                                  child: WidgetButtonCustom(
                                    FullWidth: width,
                                    FullHeight: 40.h,
                                    title: "Lihat Produk",
                                    onpressed: () {},
                                    bgColor: PRIMARY_COLOR,
                                    color: Colors.transparent,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class ComponentTambahProduk extends StatefulWidget {
  ComponentTambahProduk({super.key, required this.title});
  String title;
  @override
  State<ComponentTambahProduk> createState() => _ComponentTambahProdukState();
}

class _ComponentTambahProdukState extends State<ComponentTambahProduk> {
  TextEditingController serial = TextEditingController();
  bool cek = false;
  bool tlp = false;
  int? selectGradeId;
  bool selectGrade = false;
  GroupButtonController? jenis = GroupButtonController(selectedIndex: 0);
  TextEditingController nama = TextEditingController();
  TextEditingController kode = TextEditingController();
  GroupButtonController? gradeA = GroupButtonController();
  GroupButtonController? gradeC = GroupButtonController(selectedIndex: 0);
  TextEditingController hpp = TextEditingController();
  TextEditingController catatan = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<ProviderOrder>(context);
    return Scaffold(
      appBar: WidgetAppbar(
        title: widget.title,
        back: true,
        center: true,
        colorBG: Colors.grey.shade100,
        colorBack: Colors.black,
        colorTitle: Colors.black,
        route: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: width,
              height: 80.h,
              child: ListTile(
                title: Text(
                  'Jenis Produk',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      isRadio: true,
                      controller: jenis,
                      options: GroupButtonOptions(
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                      },
                      buttons: const ['Gas', "Jasa"]),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 80.h,
              child: ListTile(
                title: Text(
                  'Nama Produk',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: WidgetForm(
                    controller: nama,
                    alert: 'Nama Produk',
                    hint: 'Nama Produk',
                    typeInput: TextInputType.text,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 80.h,
              child: ListTile(
                title: Text(
                  'Harga',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: WidgetForm(
                    controller: kode,
                    change: (value) {},
                    alert: 'Harga',
                    hint: 'Harga',
                    typeInput: TextInputType.number,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 80.h,
              child: ListTile(
                title: Text(
                  'Apakah Menggunakan Grade ?',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      isRadio: true,
                      controller: gradeA,
                      options: GroupButtonOptions(
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                        if (gradeA?.selectedIndex == 1) {
                          setState(() {
                            selectGrade = false;
                            selectGradeId = null;
                          });
                        } else {
                          setState(() {
                            selectGrade = true;
                            selectGradeId = null;
                          });
                        }
                      },
                      buttons: const ['Grade', "Non Grade"]),
                ),
              ),
            ),
            if (selectGrade == true)
              SizedBox(
                width: width,
                height: 80.h,
                child: ListTile(
                  title: Text(
                    'Pilih Grade',
                    style: subtitleTextBlack,
                  ),
                  subtitle: Align(
                    alignment: Alignment.topLeft,
                    child: Consumer<ProviderDistribusi>(
                      builder: (context, provider, child) {
                        final grade = provider.tubeGrades?.data
                            .map((data) => {'id': data.id, 'name': data.name})
                            .toList();
                        return GroupButton(
                          controller: gradeC,
                          isRadio: true,
                          options: GroupButtonOptions(
                            selectedColor: PRIMARY_COLOR,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          onSelected: (value, index, isSelected) {
                            print('DATA KLIK : $value - $index - $isSelected');
                            if (value != null) {
                              final ID = grade.firstWhere(
                                (item) => item['name'] == value,
                              );
                              setState(() {
                                selectGradeId = int.parse(ID['id'].toString());
                              });
                              print("Selected ID: $selectGradeId");
                            }
                          },
                          buttons: grade!.map((e) => e['name']).toList(),
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
                  'HPP',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: WidgetForm(
                    controller: hpp,
                    alert: 'HPP',
                    hint: 'HPP',
                    typeInput: TextInputType.text,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 110.h,
              child: ListTile(
                title: Text(
                  'Catatan',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  height: 70.h,
                  child: TextField(
                    controller: catatan,
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
            SizedBox(
              height: height * 0.05,
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: width,
        height: height * 0.06,
        child: Align(
          alignment: Alignment.topCenter,
          child: WidgetButtonCustom(
              FullWidth: width * 0.9,
              FullHeight: height * 0.05,
              title: 'Simpan',
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
                    provider.createProduk(
                        context,
                        nama.text,
                        int.parse(hpp.text),
                        int.parse(kode.text),
                        catatan.text,
                        (jenis!.selectedIndex! + 1),
                        (gradeA?.selectedIndex == 0) ? true : false,
                        (selectGradeId == null) ? null : selectGradeId!),
                  ]);
                  Navigator.of(context).pop(); // Tutup Dialog Loading
                } catch (e) {
                  Navigator.of(context).pop(); // Tutup Dialog Loading
                  print('Error: $e');
                  // Tambahkan pesan error jika perlu
                }
              },
              bgColor: PRIMARY_COLOR,
              color: PRIMARY_COLOR),
        ),
      ),
    );
  }
}

class ComponentEditProduk extends StatefulWidget {
  ComponentEditProduk({super.key, required this.title, required this.id});
  String title;
  int id;
  @override
  State<ComponentEditProduk> createState() => _ComponentEditProdukState();
}

class _ComponentEditProdukState extends State<ComponentEditProduk> {
  TextEditingController serial = TextEditingController();
  bool cek = false;
  bool tlp = false;
  int? selectGradeId;
  bool selectGrade = true;
  GroupButtonController? jenis = GroupButtonController(selectedIndex: 0);
  TextEditingController nama = TextEditingController();
  TextEditingController kode = TextEditingController();
  GroupButtonController? gradeA = GroupButtonController(selectedIndex: 0);
  GroupButtonController? gradeC = GroupButtonController(selectedIndex: 0);
  TextEditingController hpp = TextEditingController();
  TextEditingController catatan = TextEditingController();

  @override
  void initState() {
    super.initState();
    final dataProduk =
        Provider.of<ProviderOrder>(context, listen: false).produkSatuan?.data;

    if (dataProduk != null) {
      nama.text = dataProduk.name ?? '';
      kode.text = dataProduk.price.toString();
      hpp.text = dataProduk.hpp.toString();
      catatan.text = dataProduk.note ?? '';

      // Set the type of product (Gas or Jasa)
      jenis?.selectIndex(dataProduk.isGrade == true ? 0 : 1);

      // Set selectGrade based on isGrade
      selectGrade = dataProduk.isGrade ?? true;

      // If there's a grade, pre-select it
      if (selectGrade) {
        gradeA?.selectIndex(0); // Select Grade by default
        gradeC?.selectIndex(
          dataProduk.tubeGradeId == 1
              ? 0
              : dataProduk.tubeGradeId == 2
                  ? 1
                  : 2,
        );
        selectGradeId = dataProduk.tubeGradeId;
      } else {
        gradeA?.selectIndex(1); // Select Non Grade if not using grade
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<ProviderOrder>(context);

    return Scaffold(
      appBar: WidgetAppbar(
        title: widget.title,
        back: true,
        center: true,
        colorBG: Colors.grey.shade100,
        colorBack: Colors.black,
        colorTitle: Colors.black,
        route: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Container(
            //   width: width,
            //   height: 80.h,
            //   child: ListTile(
            //     title: Text(
            //       'Jenis Produk',
            //       style: subtitleTextBlack,
            //     ),
            //     subtitle: Align(
            //       alignment: Alignment.topLeft,
            //       child: GroupButton(
            //         isRadio: true,
            //         controller: jenis,
            //         options: GroupButtonOptions(
            //           selectedColor: PRIMARY_COLOR,
            //           borderRadius: BorderRadius.circular(8),
            //         ),
            //         onSelected: (value, index, isSelected) {
            //           print('DATA KLIK : $value - $index - $isSelected');
            //         },
            //         buttons: ['Gas', "Jasa"],
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   width: width,
            //   height: 80.h,
            //   child: ListTile(
            //     title: Text(
            //       'Nama Produk',
            //       style: subtitleTextBlack,
            //     ),
            //     subtitle: Container(
            //       margin: EdgeInsets.only(top: height * 0.01),
            //       child: WidgetForm(
            //         controller: nama,
            //         alert: 'Nama Produk',
            //         hint: 'Nama Produk',
            //         typeInput: TextInputType.text,
            //         enable: false,
            //         border: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(12)),
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(
              width: width,
              height: 80.h,
              child: ListTile(
                title: Text(
                  'Harga',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: WidgetForm(
                    controller: kode,
                    change: (value) {},
                    alert: 'Harga',
                    hint: 'Harga',
                    typeInput: TextInputType.number,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
            // Container(
            //   width: width,
            //   height: 80.h,
            //   child: ListTile(
            //     title: Text(
            //       'Apakah Menggunakan Grade ?',
            //       style: subtitleTextBlack,
            //     ),
            //     subtitle: Align(
            //       alignment: Alignment.topLeft,
            //       child: GroupButton(
            //         isRadio: true,
            //         controller: gradeA,
            //         options: GroupButtonOptions(
            //           selectedColor: PRIMARY_COLOR,
            //           borderRadius: BorderRadius.circular(8),
            //         ),
            //         onSelected: (value, index, isSelected) {
            //           print('DATA KLIK : $value - $index - $isSelected');
            //           if (gradeA?.selectedIndex == 1) {
            //             setState(() {
            //               selectGrade = false;
            //             });
            //           } else {
            //             setState(() {
            //               selectGrade = true;
            //             });
            //           }
            //         },
            //         buttons: ['Grade', "Non Grade"],
            //       ),
            //     ),
            //   ),
            // ),
            // if (selectGrade == true)
            //   Container(
            //     width: width,
            //     height: 80.h,
            //     child: ListTile(
            //       title: Text(
            //         'Pilih Grade',
            //         style: subtitleTextBlack,
            //       ),
            //       subtitle: Align(
            //         alignment: Alignment.topLeft,
            //         child: Consumer<ProviderDistribusi>(
            //           builder: (context, provider, child) {
            //             final grade = provider.tubeGrades?.data
            //                 .map((data) => {'id': data.id, 'name': data.name})
            //                 .toList();
            //             return GroupButton(
            //               controller: gradeC,
            //               isRadio: true,
            //               options: GroupButtonOptions(
            //                 selectedColor: PRIMARY_COLOR,
            //                 borderRadius: BorderRadius.circular(8),
            //               ),
            //               onSelected: (value, index, isSelected) {
            //                 print('DATA KLIK : $value - $index - $isSelected');
            //                 if (value != null) {
            //                   final ID = grade.firstWhere(
            //                     (item) => item['name'] == value,
            //                   );
            //                   setState(() {
            //                     selectGradeId = int.parse(ID['id'].toString());
            //                   });
            //                   print("Selected ID: $selectGradeId");
            //                 }
            //               },
            //               buttons: grade!.map((e) => e['name']).toList(),
            //             );
            //           },
            //         ),
            //       ),
            //     ),
            //   ),
            SizedBox(
              width: width,
              height: 80.h,
              child: ListTile(
                title: Text(
                  'HPP',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: WidgetForm(
                    controller: hpp,
                    alert: 'HPP',
                    hint: 'HPP',
                    typeInput: TextInputType.text,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 110.h,
              child: ListTile(
                title: Text(
                  'Catatan',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  height: 70.h,
                  child: TextField(
                    controller: catatan,
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
            SizedBox(
              height: height * 0.05,
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: width,
        height: height * 0.06,
        child: Align(
          alignment: Alignment.topCenter,
          child: WidgetButtonCustom(
              FullWidth: width * 0.9,
              FullHeight: height * 0.05,
              title: 'Simpan',
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
                print(selectGradeId);
                try {
                  await Future.wait([
                    provider.updateProduk(context, int.parse(hpp.text),
                        int.parse(kode.text), catatan.text, widget.id),
                  ]);
                  Navigator.of(context).pop(); // Tutup Dialog Loading
                } catch (e) {
                  Navigator.of(context).pop(); // Tutup Dialog Loading
                  print('Error: $e');
                }
              },
              bgColor: PRIMARY_COLOR,
              color: PRIMARY_COLOR),
        ),
      ),
    );
  }
}
