import 'dart:async';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_Order.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';

class ComponentDetailAsset extends StatefulWidget {
  ComponentDetailAsset({super.key});

  @override
  _ComponentDetailAssetState createState() => _ComponentDetailAssetState();
}

class _ComponentDetailAssetState extends State<ComponentDetailAsset>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int currentIndex = 0;
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
      currentIndex = _tabController.index;
      print(currentIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderOrder>(context);
    final data = provider.summary?.data;
    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Nama Asset',
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
            height: 150.h,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100.w,
                  height: 85.h,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(12)),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Container(
                  width: 200.w,
                  height: 100.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 40.h,
                        child: WidgetButtonCustom(
                          FullWidth: width,
                          FullHeight: 40.h,
                          title: "Check In",
                          color: PRIMARY_COLOR,
                          bgColor: PRIMARY_COLOR,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      SizedBox(
                        height: 40.h,
                        child: WidgetButtonCustom(
                          FullWidth: width,
                          FullHeight: 40.h,
                          title: "Check In",
                          color: PRIMARY_COLOR,
                          bgColor: PRIMARY_COLOR,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Column(
                    children: [
                      if (currentIndex == 0)
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: FaIcon(
                                      FontAwesomeIcons.screwdriverWrench)),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "Maintenance",
                                  style: subtitleTextBlack,
                                ),
                              )
                            ],
                          ),
                        ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.print,
                                size: 30.h,
                              ),
                            ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "Print Label",
                                style: subtitleTextBlack,
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
          SizedBox(
            height: 10.h,
          ),
          TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: "Detail"),
              Tab(text: "Komponen"),
              Tab(text: "History"),
              Tab(text: "File"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [ComponentListDetail(), CompponentLisKomponen()],
            ),
          )
        ],
      ),
    );
  }
}

class ComponentListDetail extends StatefulWidget {
  const ComponentListDetail({
    super.key,
  });

  @override
  State<ComponentListDetail> createState() => _ComponentListDetailState();
}

class _ComponentListDetailState extends State<ComponentListDetail> {
  List<bool> check = [true, false];
  bool non = false;
  GroupButtonController? menu = GroupButtonController(selectedIndex: 0);
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderOrder>(context);
    final providerDis = Provider.of<ProviderDistribusi>(context);

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: (provider.produk!.data!.isEmpty)
                  ? const Center(
                      child: Text('Belum Terdapat Produk Trash'),
                    )
                  : Container(
                      width: double.maxFinite,
                      height: 100.h,
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
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 5.h),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(color: Colors.grey.shade300),
                                ),
                              ),
                              child: Row(
                                children: [
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
                                                child: Text('Lorem Ipsum',
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                    'Lokasi Aseet',
                                                    style:
                                                        subtitleTextNormalblack,
                                                  ),
                                                ),
                                              ),
                                              const Text(':'),
                                              Expanded(
                                                flex: 3,
                                                child: Text('Lorem Ipsum',
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                    'Serial',
                                                    style:
                                                        subtitleTextNormalblack,
                                                  ),
                                                ),
                                              ),
                                              const Text(':'),
                                              Expanded(
                                                flex: 3,
                                                child: Text('Lorem Ipsum',
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                    'Tanggal Pembelian',
                                                    style:
                                                        subtitleTextNormalblack,
                                                  ),
                                                ),
                                              ),
                                              const Text(':'),
                                              Expanded(
                                                flex: 3,
                                                child: Text('Lorem Ipsum',
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                    'Supplier',
                                                    style:
                                                        subtitleTextNormalblack,
                                                  ),
                                                ),
                                              ),
                                              const Text(':'),
                                              Expanded(
                                                flex: 3,
                                                child: Text('Lorem Ipsum',
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                    'Asset',
                                                    style:
                                                        subtitleTextNormalblack,
                                                  ),
                                                ),
                                              ),
                                              const Text(':'),
                                              Expanded(
                                                flex: 3,
                                                child: Text('Lorem Ipsum',
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                    'Jenis Asset',
                                                    style:
                                                        subtitleTextNormalblack,
                                                  ),
                                                ),
                                              ),
                                              const Text(':'),
                                              Expanded(
                                                flex: 3,
                                                child: Text('Lorem Ipsum',
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                    'Merek',
                                                    style:
                                                        subtitleTextNormalblack,
                                                  ),
                                                ),
                                              ),
                                              const Text(':'),
                                              Expanded(
                                                flex: 3,
                                                child: Text('Lorem Ipsum',
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                    'Departement',
                                                    style:
                                                        subtitleTextNormalblack,
                                                  ),
                                                ),
                                              ),
                                              const Text(':'),
                                              Expanded(
                                                flex: 3,
                                                child: Text('Lorem Ipsum',
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                child: Text('Rp. 100.000.000',
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                    'Garansi',
                                                    style:
                                                        subtitleTextNormalblack,
                                                  ),
                                                ),
                                              ),
                                              const Text(':'),
                                              Expanded(
                                                flex: 3,
                                                child: Text('\t2 Bulan',
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                    'Deskripsi',
                                                    style:
                                                        subtitleTextNormalblack,
                                                  ),
                                                ),
                                              ),
                                              const Text(':'),
                                              Expanded(
                                                flex: 3,
                                                child: Text('\tLorem Ipsum',
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                style: subtitleTextNormalGrey,
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Text('\t12/01/2025',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        subtitleTextNormalGrey),
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
                                                    'Dibuat Oleh',
                                                    style:
                                                        subtitleTextNormalGrey,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                ':',
                                                style: subtitleTextNormalGrey,
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Text('\tUser 1',
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class CompponentLisKomponen extends StatefulWidget {
  const CompponentLisKomponen({
    super.key,
  });

  @override
  State<CompponentLisKomponen> createState() => _CompponentLisKomponenState();
}

class _CompponentLisKomponenState extends State<CompponentLisKomponen> {
  List<bool> check = [true, false];
  bool non = false;
  GroupButtonController? menu = GroupButtonController(selectedIndex: 0);
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderOrder>(context);
    final providerDis = Provider.of<ProviderDistribusi>(context);

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
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
                                                        '\t${(data.isGrade == true) ? providerDis.getGrade(data.tubeGradeId!) : "-"}',
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
                                          title: "Check Out",
                                          onpressed: () async {},
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
                                          onpressed: () async {},
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
    final provider = Provider.of<ProviderOrder>(context);
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
                      itemCount: provider.produkTrash!.data!.length,
                      itemBuilder: (context, index) {
                        final data = provider.produkTrash?.data![index];
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
                                                        '\t${(data.isGrade == true) ? providerDis.getGrade(data.tubeGradeId!) : "-"}',
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
