import 'dart:async';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';

import '../../../providers/provider_order.dart';

class ComponentMenuMasterProduk extends StatefulWidget {
  ComponentMenuMasterProduk({super.key, required this.title});
  String title;

  @override
  _ComponentMenuMasterProdukState createState() =>
      _ComponentMenuMasterProdukState();
}

class _ComponentMenuMasterProdukState extends State<ComponentMenuMasterProduk>
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
    final provider = Provider.of<ProviderOrder>(context);
    final data = provider.summary?.data;
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
            height: 100.h,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Card(
                      elevation: 2,
                      child: Padding(
                        padding: EdgeInsets.all(10.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Image.asset("assets/images/target.png")),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: "Total Produk\n",
                                      style: minisubtitleTextBlack),
                                  TextSpan(
                                      text:
                                          data?.totalProduct?.toString() ?? "0",
                                      style: subtitleTextBoldBlack),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Card(
                      elevation: 2,
                      child: Padding(
                        padding: EdgeInsets.all(10.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child:
                                    Image.asset("assets/images/revenue.png")),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: "Total Gas\n",
                                      style: minisubtitleTextBlack),
                                  TextSpan(
                                      text:
                                          data?.totalTypeGas?.toString() ?? "0",
                                      style: subtitleTextBoldBlack),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Card(
                      elevation: 2,
                      child: Padding(
                        padding: EdgeInsets.all(10.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child:
                                    Image.asset("assets/images/customer.png")),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: "Total Jasa\n",
                                      style: minisubtitleTextBlack),
                                  TextSpan(
                                      text: data?.totalTypeService.toString() ??
                                          "0",
                                      style: subtitleTextBoldBlack),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: WidgetButtonCustom(
              FullWidth: width,
              FullHeight: 40.h,
              title: "Buat Produk",
              onpressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ComponentTambahProduk(title: 'Buat Produk'),
                  ),
                );
              },
              bgColor: PRIMARY_COLOR,
              color: Colors.transparent,
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
              Tab(text: "List Produk"),
              Tab(text: "List Trash"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ComponentProdukMaster(),
                ComponentProdukTrashMaster(),
                // Konten untuk setiap tab
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ComponentProdukMaster extends StatefulWidget {
  const ComponentProdukMaster({
    super.key,
  });

  @override
  State<ComponentProdukMaster> createState() => _ComponentProdukMasterState();
}

class _ComponentProdukMasterState extends State<ComponentProdukMaster> {
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
                        onSubmit: () async {
                          await provider.searchProduk(context, search.text);
                        },
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
                                              "Dibuat Oleh : ${data?.createdBy ?? "-"}",
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
                                                        '\t${data?.name ?? "-"}',
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
                                                        '\t${(data?.tubeGradeId != null) ? providerDis.getGrade(data!.tubeGradeId!) : "-"}',
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
                                                        '\t${(data?.note == "") ? "-" : data?.note}',
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
                                                        '\t${provider.formatCurrency(data?.price ?? 0)}',
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
                                                        '\t${provider.formatDate(data?.createdAt.toString() ?? "-")} | ${provider.formatTime(data?.createdAt.toString() ?? "-")}',
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
                                          title: "Hapus",
                                          onpressed: () async {
                                            showModalBottomSheet(
                                              context: context,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            20)),
                                              ),
                                              isScrollControlled: true,
                                              builder: (context) {
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 16,
                                                    right: 16,
                                                    top: 16,
                                                    bottom:
                                                        MediaQuery.of(context)
                                                                .viewInsets
                                                                .bottom +
                                                            16,
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      // Bagian Atas (Title)
                                                      Center(
                                                        child: Text(
                                                            'Yakin Ingin Menghapus',
                                                            style:
                                                                subtitleTextBlack),
                                                      ),
                                                      SizedBox(height: 16.h),
                                                      // Bagian Bawah (Button Kembali dan Hapus)
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          WidgetButtonCustom(
                                                              FullWidth:
                                                                  width * 0.45,
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
                                                          SizedBox(
                                                              height: 10.w),
                                                          WidgetButtonCustom(
                                                              FullWidth:
                                                                  width * 0.45,
                                                              FullHeight:
                                                                  height * 0.05,
                                                              title: "Hapus",
                                                              bgColor:
                                                                  SECONDARY_COLOR,
                                                              onpressed:
                                                                  () async {
                                                                await provider
                                                                    .deleteMasterProduk(
                                                                        context,
                                                                        data?.id ??
                                                                            0);
                                                                Navigator.pop(
                                                                    context);
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
                                          bgColor: SECONDARY_COLOR,
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
                                          title: "Ubah",
                                          onpressed: () async {
                                            await provider.getMasterProdukId(
                                                context, data?.id ?? 0);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ComponentEditProduk(
                                                  title: "Ubah Produk Master",
                                                  id: data?.id ?? 0,
                                                ),
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

class ComponentProdukTrashMaster extends StatefulWidget {
  const ComponentProdukTrashMaster({
    super.key,
  });

  @override
  State<ComponentProdukTrashMaster> createState() =>
      _ComponentProdukTrashMasterState();
}

class _ComponentProdukTrashMasterState
    extends State<ComponentProdukTrashMaster> {
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
                          child: Stack(
                            children: [
                              Column(
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
                                            width:
                                                120.w, // 30% dari lebar layar
                                            height: double.infinity,
                                            decoration: const BoxDecoration(
                                              color:
                                                  PRIMARY_COLOR, // Warna biru tua
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(8),
                                                bottomRight:
                                                    Radius.circular(30),
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(
                                                (data?.type == 1)
                                                    ? "Gas"
                                                    : "Jasa",
                                                style: titleText),
                                          ),
                                        ),
                                        // Bagian kanan (TW: 36.8)
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            width: width * 0.35,
                                            padding:
                                                EdgeInsets.only(right: 10.w),
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
                                                          alignment: Alignment
                                                              .centerLeft,
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
                                                            '\t${data.name ?? "-"}',
                                                            overflow:
                                                                TextOverflow
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
                                                          alignment: Alignment
                                                              .centerLeft,
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
                                                            overflow:
                                                                TextOverflow
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
                                                          alignment: Alignment
                                                              .centerLeft,
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
                                                            overflow:
                                                                TextOverflow
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
                                                          alignment: Alignment
                                                              .centerLeft,
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
                                                            overflow:
                                                                TextOverflow
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
                                                          alignment: Alignment
                                                              .centerLeft,
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
                                                            overflow:
                                                                TextOverflow
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
                                ],
                              ),
                              Positioned(
                                top: 50.h,
                                left: 125.w,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Transform.rotate(
                                    angle: -25 *
                                        3.1415927 /
                                        180, // Rotasi 45 derajat
                                    child: const Opacity(
                                      opacity: 0.2, // Transparansi watermark
                                      child: Text(
                                        "TRASH",
                                        style: TextStyle(
                                          fontSize: 50,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
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
  int? selectJenis;
  GroupButtonController? jenis = GroupButtonController();
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
                        setState(() {
                          selectJenis = index;
                        });
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
            if (selectJenis == 0)
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
            // ),
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
