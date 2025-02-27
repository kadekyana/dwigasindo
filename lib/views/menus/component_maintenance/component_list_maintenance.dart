import 'dart:async';

import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/model/modelLoadingTube.dart';
import 'package:dwigasindo/providers/provider_Order.dart';
import 'package:dwigasindo/providers/provider_sales.dart';
import 'package:dwigasindo/views/menus/component_maintenance/component_button_maintenance.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';

class ComponentListMaintenance extends StatefulWidget {
  ComponentListMaintenance({super.key, required this.title});
  String title;

  @override
  _ComponentListMaintenanceState createState() =>
      _ComponentListMaintenanceState();
}

class _ComponentListMaintenanceState extends State<ComponentListMaintenance>
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

    _tabController.addListener(() {
      final currentIndex = _tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderSales>(context);
    final summary = provider.modelSummaryMaintenance?.data;
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
                                      text: "Total\n",
                                      style: minisubtitleTextBlack),
                                  TextSpan(
                                      text: "${summary?.totalMaintenance}",
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
                                      text: "Selesai\n",
                                      style: minisubtitleTextBlack),
                                  TextSpan(
                                      text: "${summary?.totalDone}",
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
                                      text: "Afkir\n",
                                      style: minisubtitleTextBlack),
                                  TextSpan(
                                      text: "${summary?.totalAfkir}",
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
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.w),
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
          SizedBox(
            height: 10.h,
          ),
          TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: "List"),
              Tab(text: "Ready to use"),
              Tab(text: "Afkir"),
              Tab(text: "Retur"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ComponentMenuList(),
                // Konten untuk setiap tab
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
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Column(
          children: [
            SizedBox(
              width: double.maxFinite,
              height: height * 0.1,
              child: GroupButton(
                  controller: menu,
                  options: GroupButtonOptions(
                      buttonWidth: width * 0.4,
                      borderRadius: BorderRadius.circular(8),
                      selectedColor: PRIMARY_COLOR),
                  isRadio: true,
                  onSelected: (value, index, isSelected) async {
                    if (index == 0) {
                      setState(() {
                        check = true;
                      });
                      await provider.getListMaintenance(context, 1, 0);
                    } else {
                      setState(() {
                        check = false;
                      });
                      await provider.getListMaintenance(context, 2, 0);
                    }
                  },
                  buttons: ['High Preasure', 'C2H2']),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: data?.length,
                itemBuilder: (context, index) {
                  print(data?.length);
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                      width: 130.w,
                                      height: 40.h,
                                      decoration: BoxDecoration(
                                        color: (dataCard?.lastStatus == 9 ||
                                                dataCard?.lastStatus == 0)
                                            ? Colors.grey
                                            : (dataCard?.lastStatus == 1 ||
                                                    dataCard?.lastStatus == 2)
                                                ? Colors.orange
                                                : (dataCard?.lastStatus == 3)
                                                    ? Colors.green
                                                    : Colors.red,
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          bottomLeft: Radius.circular(30),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          (dataCard?.lastStatus == 9)
                                              ? "Pending"
                                              : (dataCard?.lastStatus == 0)
                                                  ? "Pengecekan"
                                                  : (dataCard?.lastStatus == 1)
                                                      ? "Konfirmasi"
                                                      : (dataCard?.lastStatus ==
                                                              2)
                                                          ? "Ganti Sparepart"
                                                          : (dataCard?.lastStatus ==
                                                                  3)
                                                              ? "Ready to Use"
                                                              : (dataCard?.lastStatus ==
                                                                      4)
                                                                  ? "Retur Customer"
                                                                  : "Afkir",
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.025, vertical: 5.h),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                          color: Colors.grey.shade300),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 90.w,
                                        height: 80.h,
                                        decoration: BoxDecoration(
                                            border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(12)),
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
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'Jenis Tabung',
                                                        style:
                                                            subtitleTextBlack,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        ' : ',
                                                        style:
                                                            subtitleTextBlack,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        dataCard?.tubeTypeName ??
                                                            "-",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.justify,
                                                        style:
                                                            subtitleTextBlack,
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
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'Jenis Gas',
                                                        style:
                                                            subtitleTextBlack,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        ' : ',
                                                        style:
                                                            subtitleTextBlack,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        dataCard?.tubeGasName ??
                                                            "-",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.justify,
                                                        style:
                                                            subtitleTextBlack,
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
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'Grade',
                                                        style:
                                                            subtitleTextBlack,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        ' : ',
                                                        style:
                                                            subtitleTextBlack,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          dataCard?.tubeGradeName ??
                                                              "-",
                                                          style:
                                                              subtitleTextBlack),
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
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'Lokasi',
                                                        style:
                                                            subtitleTextBlack,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        ' : ',
                                                        style:
                                                            subtitleTextBlack,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text("-",
                                                          style:
                                                              subtitleTextBlack),
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
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'Milik',
                                                        style:
                                                            subtitleTextBlack,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        ' : ',
                                                        style:
                                                            subtitleTextBlack,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          (dataCard?.ownerShipType ==
                                                                  null)
                                                              ? "-"
                                                              : (dataCard?.ownerShipType ==
                                                                      1)
                                                                  ? "Asset"
                                                                  : "Customer",
                                                          style:
                                                              subtitleTextBlack),
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
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'Dibuat Oleh',
                                                        style:
                                                            subtitleTextNormal,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        ' : ',
                                                        style:
                                                            subtitleTextNormal,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          dataCard?.createdByName ??
                                                              "-",
                                                          style:
                                                              subtitleTextNormal),
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
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'Dibuat Pada',
                                                        style:
                                                            subtitleTextNormal,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        ' : ',
                                                        style:
                                                            subtitleTextNormal,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          provider.formatDate(
                                                              dataCard!
                                                                  .createdAt
                                                                  .toString()),
                                                          style:
                                                              subtitleTextNormal),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: WidgetButtonCustom(
                                        FullWidth: width * 0.3,
                                        FullHeight: 30.h,
                                        title: "Update Status",
                                        onpressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Dialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: SizedBox(
                                                  height: 400.h,
                                                  child: Stack(
                                                    children: <Widget>[
                                                      // Bagian isi dialog
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 60.h),
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              width: 300.w,
                                                              height: 40.h,
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          20.w),
                                                              child:
                                                                  WidgetButtonCustom(
                                                                FullWidth:
                                                                    200.w,
                                                                FullHeight:
                                                                    50.h,
                                                                title:
                                                                    "Pengecekan",
                                                                onpressed:
                                                                    dataCard.lastStatus !=
                                                                            9
                                                                        ? null
                                                                        : () {
                                                                            if (check ==
                                                                                true) {
                                                                              Navigator.push(
                                                                                context,
                                                                                MaterialPageRoute(
                                                                                  builder: (context) => ComponentButtonMaintenance(
                                                                                    title: 'Pergantian Sparepart',
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            } else {
                                                                              Navigator.push(
                                                                                context,
                                                                                MaterialPageRoute(
                                                                                  builder: (context) => FormC2H2(
                                                                                    title: 'Pergantian Sparepart',
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            }
                                                                          },
                                                                color:
                                                                    PRIMARY_COLOR,
                                                                bgColor: dataCard
                                                                            .lastStatus !=
                                                                        9
                                                                    ? Colors
                                                                        .grey
                                                                    : PRIMARY_COLOR,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 10.h,
                                                            ),
                                                            Container(
                                                              width: 300.w,
                                                              height: 40.h,
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          20.w),
                                                              child:
                                                                  WidgetButtonCustom(
                                                                FullWidth:
                                                                    200.w,
                                                                FullHeight:
                                                                    50.h,
                                                                title:
                                                                    "Konfirmasi",
                                                                onpressed:
                                                                    dataCard.lastStatus !=
                                                                            0
                                                                        ? null
                                                                        : () {
                                                                            Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                builder: (context) => UpdateStatusToUsers(
                                                                                  title: 'Pergantian Sparepart',
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                color:
                                                                    PRIMARY_COLOR,
                                                                bgColor: dataCard
                                                                            .lastStatus !=
                                                                        0
                                                                    ? Colors
                                                                        .grey
                                                                    : PRIMARY_COLOR,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 10.h,
                                                            ),
                                                            Container(
                                                              width: 300.w,
                                                              height: 40.h,
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          20.w),
                                                              child:
                                                                  WidgetButtonCustom(
                                                                FullWidth:
                                                                    200.w,
                                                                FullHeight:
                                                                    50.h,
                                                                title:
                                                                    "Pergantian Sparepart",
                                                                onpressed:
                                                                    dataCard.lastStatus !=
                                                                            1
                                                                        ? null
                                                                        : () {
                                                                            Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                builder: (context) => UpdateStatusToUsers(
                                                                                  title: 'Pergantian Sparepart',
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                color:
                                                                    PRIMARY_COLOR,
                                                                bgColor: dataCard
                                                                            .lastStatus !=
                                                                        1
                                                                    ? Colors
                                                                        .grey
                                                                    : PRIMARY_COLOR,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 10.h,
                                                            ),
                                                            Container(
                                                              width: 300.w,
                                                              height: 40.h,
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          20.w),
                                                              child:
                                                                  WidgetButtonCustom(
                                                                FullWidth:
                                                                    200.w,
                                                                FullHeight:
                                                                    50.h,
                                                                title:
                                                                    "Ready To Use",
                                                                onpressed:
                                                                    dataCard.lastStatus !=
                                                                            2
                                                                        ? null
                                                                        : () {
                                                                            Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                builder: (context) => UpdateStatusToUsers(
                                                                                  title: 'Ready To Use',
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                color:
                                                                    PRIMARY_COLOR,
                                                                bgColor: dataCard
                                                                            .lastStatus !=
                                                                        2
                                                                    ? Colors
                                                                        .grey
                                                                    : PRIMARY_COLOR,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 10.h,
                                                            ),
                                                            Container(
                                                              width: 300.w,
                                                              height: 40.h,
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          20.w),
                                                              child:
                                                                  WidgetButtonCustom(
                                                                FullWidth:
                                                                    200.w,
                                                                FullHeight:
                                                                    50.h,
                                                                title:
                                                                    "Retur Customer",
                                                                onpressed:
                                                                    dataCard.lastStatus !=
                                                                            1
                                                                        ? null
                                                                        : () {
                                                                            Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                builder: (context) => UpdateStatusToUsers(
                                                                                  title: 'Retur Customer',
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                color:
                                                                    PRIMARY_COLOR,
                                                                bgColor: dataCard
                                                                            .lastStatus !=
                                                                        1
                                                                    ? Colors
                                                                        .grey
                                                                    : PRIMARY_COLOR,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 10.h,
                                                            ),
                                                            Container(
                                                              width: 300.w,
                                                              height: 40.h,
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          20.w),
                                                              child:
                                                                  WidgetButtonCustom(
                                                                FullWidth:
                                                                    200.w,
                                                                FullHeight:
                                                                    50.h,
                                                                title: "Afkir",
                                                                onpressed:
                                                                    dataCard.lastStatus !=
                                                                            1
                                                                        ? null
                                                                        : () {
                                                                            Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                builder: (context) => FormAfkir(
                                                                                  title: 'Ready To Use',
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                color:
                                                                    PRIMARY_COLOR,
                                                                bgColor: dataCard
                                                                            .lastStatus !=
                                                                        1
                                                                    ? Colors
                                                                        .grey
                                                                    : PRIMARY_COLOR,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      // Bagian atas kiri dan kanan
                                                      Positioned(
                                                        left: 10,
                                                        top: 10,
                                                        child: TextButton(
                                                          onPressed: () {
                                                            // Aksi untuk Update
                                                            print(
                                                                "Update clicked");
                                                          },
                                                          child: Text(
                                                              'Pilih Status',
                                                              style:
                                                                  titleTextBlack),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        right: 10,
                                                        top: 10,
                                                        child: IconButton(
                                                          icon:
                                                              Icon(Icons.close),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
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
                                        title: "Lihat",
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
          ],
        ),
      ),
    );
  }
}
