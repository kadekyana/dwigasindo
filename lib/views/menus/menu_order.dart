import 'dart:async';
import 'dart:io';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/model/modelAllOrder.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/providers/provider_item.dart';
import 'package:dwigasindo/providers/provider_sales.dart';
import 'package:dwigasindo/views/menus/component_order/component_detail_order.dart';
import 'package:dwigasindo/views/menus/component_order/component_produk_master.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:dwigasindo/widgets/widget_pdf.dart';
import 'package:dwigasindo/widgets/wigdet_kecamatan.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';

import '../../providers/provider_order.dart';

class MenuOrder extends StatelessWidget {
  const MenuOrder({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderOrder>(context);
    final providerSa = Provider.of<ProviderSales>(context);
    final providerDis = Provider.of<ProviderDistribusi>(context);
    final providerItem = Provider.of<ProviderItem>(context);

    // List map untuk data
    final List<Map<String, dynamic>> items = [
      {'title': 'Order'},
      {'title': 'Master Produk'},
    ];
    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Order',
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
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index]; // Akses data dari list
            return GestureDetector(
              onTap: () async {
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
                    providerSa.getUsersPic(context),
                    providerSa.getAllOrder(context, 1),
                    providerItem.getAllItem(context),
                    providerSa.getSummaryOrder(context),
                    provider.getMasterProduk(context),
                    provider.getMasterProdukTrash(context),
                    providerDis.getAllTubeGrade(context),
                    providerDis.getAllCostumer(context),
                    provider.getData(context),
                  ]);

                  // Navigate sesuai kondisi
                  Navigator.of(context).pop(); // Tutup Dialog Loading
                  (item['title'] == "Order")
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ComponentMenuOrder(
                              title: "Menu ${item['title']}",
                            ),
                          ),
                        )
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ComponentMenuMasterProduk(
                              title: 'Menu ${item['title']}',
                            ),
                          ),
                        );
                } catch (e) {
                  Navigator.of(context).pop(); // Tutup Dialog Loading
                  print('Error: $e');
                  // Tambahkan pesan error jika perlu
                }
              },
              child: Container(
                width: double.maxFinite,
                margin: EdgeInsets.symmetric(
                  vertical: height * 0.01,
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05, vertical: height * 0.02),
                height: height * 0.12,
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
                          image: AssetImage('assets/images/distribusi.png'),
                        ),
                      ),
                    ),
                    SizedBox(width: width * 0.03),
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(item['title'], // Gunakan title dari list
                            style: titleTextBlack),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ComponentMenuOrder extends StatefulWidget {
  ComponentMenuOrder({super.key, required this.title});
  String title;

  @override
  _ComponentMenuOrderState createState() => _ComponentMenuOrderState();
}

class _ComponentMenuOrderState extends State<ComponentMenuOrder>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int? _selectedCardIndex;
  final bool _showForm = false;
  Set<int> expandedCards = {};

  final TextEditingController tare = TextEditingController();
  final TextEditingController empty = TextEditingController();

  late Map<int, StreamController<ModelAllOrder>> _streamControllers;

  GroupButtonController? menu = GroupButtonController(selectedIndex: 0);
  bool selectMenu = true;

  @override
  void initState() {
    super.initState();

    _streamControllers = {
      0: StreamController<ModelAllOrder>.broadcast(),
      1: StreamController<ModelAllOrder>.broadcast(),
      2: StreamController<ModelAllOrder>.broadcast(),
      3: StreamController<ModelAllOrder>.broadcast(),
    };

    // Mulai stream untuk setiap tab
    _startStream(0);
    _startStream(1);
    _startStream(2);
    _startStream(3);

    _tabController = TabController(length: 3, vsync: this);

    _tabController.addListener(() {
      final currentIndex = _tabController.index;

      // Mulai stream untuk tab yang aktif
      _startStream(currentIndex);
    });
  }

  void _startStream(int status) {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (!_streamControllers[status]!.isClosed) {
        final data = await Provider.of<ProviderSales>(context, listen: false)
            .getAllOrder(context, status);
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
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderOrder>(context);
    final providerSal = Provider.of<ProviderSales>(context);
    final summary = providerSal.summaryOrder?.data;
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
                                      text: "${summary?.totalOrder}",
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
                                      text: "Transaksi\n",
                                      style: minisubtitleTextBlack),
                                  TextSpan(
                                      text: "${summary?.totalTransaction}",
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
                                      text: "Customer\n",
                                      style: minisubtitleTextBlack),
                                  TextSpan(
                                      text: "${summary?.totalCustomer}",
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
              FullHeight: 30.h,
              title: 'Buat Order',
              onpressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ComponentTambahOrder(),
                  ),
                );
              },
              color: PRIMARY_COLOR,
              bgColor: PRIMARY_COLOR,
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
              Tab(text: "List Po"),
              Tab(text: "List Retail"),
              Tab(text: "Batal"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildListPo(context),
                _buildListRetail(context),
                _buildListTrash(context),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildListPo(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderSales>(context);

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
            Expanded(
              child: StreamBuilder<ModelAllOrder>(
                stream: _streamControllers[0]!.stream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    final data = snapshot.data!.data;
                    return ListView.builder(
                      itemCount: data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        final dataCard = data![index];
                        return Container(
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
                                      width: 150.w,
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
                                          '${dataCard.code}',
                                          style: subtitleText,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 150.w,
                                      height: 40.h,
                                      decoration: BoxDecoration(
                                        color: (dataCard.approvalStatus ==
                                                "Approve")
                                            ? Colors.green
                                            : (dataCard.approvalStatus ==
                                                    "Review")
                                                ? Colors.yellow
                                                : SECONDARY_COLOR,
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          bottomLeft: Radius.circular(30),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${dataCard.approvalStatus}",
                                          style: (dataCard.approvalStatus ==
                                                  "Review")
                                              ? titleTextBlack
                                              : titleText,
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
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                'Customer',
                                                style: subtitleTextBlack,
                                              ),
                                            ),
                                            SizedBox(
                                              child: Text(
                                                ' : ',
                                                style: subtitleTextBlack,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                '${dataCard.customerName}',
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.justify,
                                                style: subtitleTextBlack,
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
                                              child: Text(
                                                'Kecamatan',
                                                style: subtitleTextBlack,
                                              ),
                                            ),
                                            SizedBox(
                                              child: Text(
                                                ' : ',
                                                style: subtitleTextBlack,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                '${dataCard.districtName}',
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.justify,
                                                style: subtitleTextBlack,
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
                                              child: Text(
                                                'Jenis Produk',
                                                style: subtitleTextBlack,
                                              ),
                                            ),
                                            SizedBox(
                                              child: Text(
                                                ' : ',
                                                style: subtitleTextBlack,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                  provider.getRemarksLabel(
                                                      dataCard.remarks!),
                                                  style: subtitleTextBlack),
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
                                              child: Text(
                                                'Total Transaksi',
                                                style: subtitleTextBlack,
                                              ),
                                            ),
                                            SizedBox(
                                              child: Text(
                                                ' : ',
                                                style: subtitleTextBlack,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                  provider.formatCurrency(
                                                      dataCard.totalTransaction
                                                          as num),
                                                  style: subtitleTextBlack),
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
                                              child: Text(
                                                'Dibuat Oleh',
                                                style: subtitleTextNormal,
                                              ),
                                            ),
                                            SizedBox(
                                              child: Text(
                                                ' : ',
                                                style: subtitleTextNormal,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                  '${dataCard.createdBy}',
                                                  style: subtitleTextNormal),
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
                                              child: Text(
                                                'Dibuat Pada',
                                                style: subtitleTextNormal,
                                              ),
                                            ),
                                            SizedBox(
                                              child: Text(
                                                ' : ',
                                                style: subtitleTextNormal,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                  provider.formatDate(dataCard
                                                      .createdAt
                                                      .toString()),
                                                  style: subtitleTextNormal),
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
                                        title: "Lihat Order",
                                        onpressed: () async {
                                          // Tampilkan Dialog Loading
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            },
                                          );

                                          try {
                                            await Future.wait([
                                              provider.getDetailOrder(
                                                  context, dataCard.id!),
                                            ]);

                                            // Navigate sesuai kondisi
                                            Navigator.of(context)
                                                .pop(); // Tutup Dialog Loading
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ComponentDetailOrder(),
                                              ),
                                            );
                                          } catch (e) {
                                            Navigator.of(context)
                                                .pop(); // Tutup Dialog Loading
                                            print('Error: $e');
                                            // Tambahkan pesan error jika perlu
                                          }
                                        },
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
                    );
                  } else {
                    return const Center(child: Text('No data found'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListRetail(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderSales>(context);

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
            Expanded(
              child: StreamBuilder<ModelAllOrder>(
                stream: _streamControllers[2]!.stream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    final data = snapshot.data!.data;
                    return ListView.builder(
                      itemCount: data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        final dataCard = data![index];
                        return Container(
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
                                      width: 150.w,
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
                                          '${dataCard.code}',
                                          style: subtitleText,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 150.w,
                                      height: 40.h,
                                      decoration: BoxDecoration(
                                        color: (dataCard.approvalStatus ==
                                                "Approve")
                                            ? Colors.green
                                            : (dataCard.approvalStatus ==
                                                    "Review")
                                                ? Colors.yellow
                                                : SECONDARY_COLOR,
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          bottomLeft: Radius.circular(30),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${dataCard.approvalStatus}",
                                          style: (dataCard.approvalStatus ==
                                                  "Review")
                                              ? titleTextBlack
                                              : titleText,
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
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                'Customer',
                                                style: subtitleTextBlack,
                                              ),
                                            ),
                                            SizedBox(
                                              child: Text(
                                                ' : ',
                                                style: subtitleTextBlack,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                '${dataCard.customerName}',
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.justify,
                                                style: subtitleTextBlack,
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
                                              child: Text(
                                                'Kecamatan',
                                                style: subtitleTextBlack,
                                              ),
                                            ),
                                            SizedBox(
                                              child: Text(
                                                ' : ',
                                                style: subtitleTextBlack,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                '${dataCard.districtName}',
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.justify,
                                                style: subtitleTextBlack,
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
                                              child: Text(
                                                'Jenis Produk',
                                                style: subtitleTextBlack,
                                              ),
                                            ),
                                            SizedBox(
                                              child: Text(
                                                ' : ',
                                                style: subtitleTextBlack,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                  provider.getRemarksLabel(
                                                      dataCard.remarks!),
                                                  style: subtitleTextBlack),
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
                                              child: Text(
                                                'Total Transaksi',
                                                style: subtitleTextBlack,
                                              ),
                                            ),
                                            SizedBox(
                                              child: Text(
                                                ' : ',
                                                style: subtitleTextBlack,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                  provider.formatCurrency(
                                                      dataCard.totalTransaction
                                                          as num),
                                                  style: subtitleTextBlack),
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
                                              child: Text(
                                                'Dibuat Oleh',
                                                style: subtitleTextNormal,
                                              ),
                                            ),
                                            SizedBox(
                                              child: Text(
                                                ' : ',
                                                style: subtitleTextNormal,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                  '${dataCard.createdBy}',
                                                  style: subtitleTextNormal),
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
                                              child: Text(
                                                'Dibuat Pada',
                                                style: subtitleTextNormal,
                                              ),
                                            ),
                                            SizedBox(
                                              child: Text(
                                                ' : ',
                                                style: subtitleTextNormal,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                  provider.formatDate(dataCard
                                                      .createdAt
                                                      .toString()),
                                                  style: subtitleTextNormal),
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
                                        title: "Lihat Order",
                                        onpressed: () async {
                                          // Tampilkan Dialog Loading
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            },
                                          );

                                          try {
                                            await Future.wait([
                                              provider.getDetailOrder(
                                                  context, dataCard.id!),
                                            ]);

                                            // Navigate sesuai kondisi
                                            Navigator.of(context)
                                                .pop(); // Tutup Dialog Loading
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ComponentDetailOrder(),
                                              ),
                                            );
                                          } catch (e) {
                                            Navigator.of(context)
                                                .pop(); // Tutup Dialog Loading
                                            print('Error: $e');
                                            // Tambahkan pesan error jika perlu
                                          }
                                        },
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
                    );
                  } else {
                    return const Center(child: Text('No data found'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTrash(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderSales>(context);

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
            Expanded(
              child: StreamBuilder<ModelAllOrder>(
                stream: _streamControllers[3]!.stream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    final data = snapshot.data!.data;
                    return ListView.builder(
                      itemCount: data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        final dataCard = data![index];
                        return Container(
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
                                      width: 150.w,
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
                                          '${dataCard.code}',
                                          style: subtitleText,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 150.w,
                                      height: 40.h,
                                      decoration: BoxDecoration(
                                        color: (dataCard.approvalStatus ==
                                                "Approve")
                                            ? Colors.green
                                            : (dataCard.approvalStatus ==
                                                    "Review")
                                                ? Colors.yellow
                                                : SECONDARY_COLOR,
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          bottomLeft: Radius.circular(30),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${dataCard.approvalStatus}",
                                          style: (dataCard.approvalStatus ==
                                                  "Review")
                                              ? titleTextBlack
                                              : titleText,
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
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                'Customer',
                                                style: subtitleTextBlack,
                                              ),
                                            ),
                                            SizedBox(
                                              child: Text(
                                                ' : ',
                                                style: subtitleTextBlack,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                '${dataCard.customerName}',
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.justify,
                                                style: subtitleTextBlack,
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
                                              child: Text(
                                                'Kecamatan',
                                                style: subtitleTextBlack,
                                              ),
                                            ),
                                            SizedBox(
                                              child: Text(
                                                ' : ',
                                                style: subtitleTextBlack,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                '${dataCard.districtName}',
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.justify,
                                                style: subtitleTextBlack,
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
                                              child: Text(
                                                'Jenis Produk',
                                                style: subtitleTextBlack,
                                              ),
                                            ),
                                            SizedBox(
                                              child: Text(
                                                ' : ',
                                                style: subtitleTextBlack,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                  provider.getRemarksLabel(
                                                      dataCard.remarks!),
                                                  style: subtitleTextBlack),
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
                                              child: Text(
                                                'Total Transaksi',
                                                style: subtitleTextBlack,
                                              ),
                                            ),
                                            SizedBox(
                                              child: Text(
                                                ' : ',
                                                style: subtitleTextBlack,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                  provider.formatCurrency(
                                                      dataCard.totalTransaction
                                                          as num),
                                                  style: subtitleTextBlack),
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
                                              child: Text(
                                                'Dibuat Oleh',
                                                style: subtitleTextNormal,
                                              ),
                                            ),
                                            SizedBox(
                                              child: Text(
                                                ' : ',
                                                style: subtitleTextNormal,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                  '${dataCard.createdBy}',
                                                  style: subtitleTextNormal),
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
                                              child: Text(
                                                'Dibuat Pada',
                                                style: subtitleTextNormal,
                                              ),
                                            ),
                                            SizedBox(
                                              child: Text(
                                                ' : ',
                                                style: subtitleTextNormal,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                  provider.formatDate(dataCard
                                                      .createdAt
                                                      .toString()),
                                                  style: subtitleTextNormal),
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
                                        title: "Lihat Order",
                                        onpressed: () async {
                                          // Tampilkan Dialog Loading
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            },
                                          );

                                          try {
                                            await Future.wait([
                                              provider.getDetailOrder(
                                                  context, dataCard.id!),
                                            ]);

                                            // Navigate sesuai kondisi
                                            Navigator.of(context)
                                                .pop(); // Tutup Dialog Loading
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ComponentDetailOrder(),
                                              ),
                                            );
                                          } catch (e) {
                                            Navigator.of(context)
                                                .pop(); // Tutup Dialog Loading
                                            print('Error: $e');
                                            // Tambahkan pesan error jika perlu
                                          }
                                        },
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
                    );
                  } else {
                    return const Center(child: Text('No data found'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ComponentTambahOrder extends StatefulWidget {
  const ComponentTambahOrder({
    super.key,
  });
  @override
  State<ComponentTambahOrder> createState() => _ComponentTambahOrderState();
}

class _ComponentTambahOrderState extends State<ComponentTambahOrder> {
  TextEditingController serial = TextEditingController();
  TextEditingController poCustomer = TextEditingController();
  GroupButtonController? button = GroupButtonController(selectedIndex: 0);
  GroupButtonController? buat = GroupButtonController(selectedIndex: 0);
  bool cek = false;
  int jenisCustomer = 0;
  int cari = 0;
  int? selectProdukId;
  int? selectItemId;
  List<TextEditingController> hppBaruControllers = [];
  List<TextEditingController> hppBaruControllersB = [];

  int selectPicId = 0;
  int selectPicId1 = 0;
  int selectPicId2 = 0;

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        serial.text =
            "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
      });
    }
  }

  List<Map<String, dynamic>> formListB = []; // List untuk menyimpan data form
  List<Map<String, dynamic>> formList = []; // List untuk menyimpan data form
  // Fungsi untuk menambah form baru
  void _addForm() {
    setState(() {
      formList.add({
        "product_id": null,
        "hpp": null,
        "new_hpp": null,
        "qty": null,
        "note": null
      });
      hppBaruControllers.add(TextEditingController());
    });
  }

  // Fungsi untuk menghapus form terakhir
  void _removeForm(int index) {
    setState(() {
      formList.removeAt(index);
      hppBaruControllers[index].dispose();
      hppBaruControllers.removeAt(index);
    });
  }

  void _addFormB() {
    setState(() {
      formListB.add({
        "item_id": null,
        "hpp": null,
        "new_hpp": null,
        "qty": null,
        "note": null // null or string
      });
      hppBaruControllersB.add(TextEditingController());
    });
  }

  // Fungsi untuk menghapus form terakhir
  void _removeFormB(int index) {
    setState(() {
      formListB.removeAt(index);
      hppBaruControllersB[index].dispose();
      hppBaruControllersB.removeAt(index);
    });
  }

  String? pdfPath;
  String filepath = '';

  // Function to handle the PDF upload
  void _onPdfPicked(String path) async {
    setState(() {
      pdfPath = path; // Store the PDF file path
    });
    final provider = Provider.of<ProviderSales>(context, listen: false);
    final pathData =
        await provider.uploadFile(context, File(path), path.split("/").last);
    setState(() {
      filepath = pathData;
    });
  }

  // Function to allow replacing the PDF (upload a new one)
  void _replacePdf() {
    setState(() {
      pdfPath = null; // Clear the current PDF path to allow re-upload
    });
  }

  @override
  void dispose() {
    for (var controller in hppBaruControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<ProviderOrder>(context);
    final providerSales = Provider.of<ProviderSales>(context);
    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Buat Order',
        center: true,
        colorTitle: Colors.black,
        colorBack: Colors.black,
        colorBG: Colors.grey.shade100,
        back: true,
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
              height: 100.h,
              child: ListTile(
                title: Text(
                  'Jenis Customer',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: Consumer<ProviderDistribusi>(
                    builder: (context, provider, child) {
                      final pic = provider.customer!.data!
                          .map((data) => {'id': data.id, 'name': data.name})
                          .toList();

                      return CustomDropdown(
                        decoration: CustomDropdownDecoration(
                            closedBorder:
                                Border.all(color: Colors.grey.shade400),
                            expandedBorder:
                                Border.all(color: Colors.grey.shade400)),
                        hintText: 'Pilih Customer',
                        items: pic.map((e) => e['name']).toList(),
                        onChanged: (item) {
                          print("Selected Item: $item");

                          final selected = pic.firstWhere(
                            (e) => e['name'] == item,
                          );

                          setState(() {
                            jenisCustomer =
                                int.parse(selected['id'].toString());
                          });

                          print("Selected ID: $jenisCustomer");
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 100.h,
              child: ListTile(
                title: Text(
                  'Jenis Order',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      isRadio: true,
                      controller: buat,
                      options: GroupButtonOptions(
                        buttonWidth: 100.w,
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                      },
                      buttons: const ['PO', "Retail"]),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 100.h,
              child: ListTile(
                title: Text(
                  'PO Customer',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(
                    top: height * 0.01,
                  ),
                  child: WidgetForm(
                    controller: poCustomer,
                    alert: 'PO Customer',
                    hint: 'PO Customer',
                    typeInput: TextInputType.text,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            if (pdfPath == null) // Only show if PDF is not uploaded yet
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: PdfUploadWidget(
                  onFilePicked: (path) {
                    _onPdfPicked(path); // Update PDF path on pick and upload
                  },
                ),
              ),
            if (pdfPath != null)
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    Text(
                      'PDF Uploaded: ${pdfPath != null ? path.basename(pdfPath!) : 'No file selected'}',
                      style: const TextStyle(color: Colors.red),
                    ),
                    if (providerSales.uploadProgress < 100)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Column(
                          children: [
                            Text(
                              'Upload Progress: ${providerSales.uploadProgress.toStringAsFixed(2)}%',
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(height: 10.h),
                            LinearProgressIndicator(
                              value: providerSales.uploadProgress / 100,
                              minHeight: 10.h,
                              backgroundColor: Colors.grey[300],
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.blue),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(height: 10.h),
                    if (providerSales.uploadProgress ==
                        100) // Show replace button after upload is complete
                      WidgetButtonCustom(
                        title: 'Ganti File',
                        onpressed: _replacePdf,
                        bgColor: Colors.red,
                        color: Colors.white,
                        FullWidth: width,
                        FullHeight: 40.h,
                      ),
                  ],
                ),
              ),
            SizedBox(
              height: 10.h,
            ),
            // Gas
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: formList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.only(left: 16.w, right: 10.w, top: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Gas / Jasa ${index + 1}',
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ListTile(
                        title: Text(
                          'Pilih Produk',
                          style: subtitleTextBlack,
                        ),
                        subtitle: Container(
                          margin: EdgeInsets.only(top: height * 0.01),
                          child: Consumer<ProviderOrder>(
                            builder: (context, provider, child) {
                              final produk = provider.produk!.data!
                                  .map((data) => {
                                        'id': data.id,
                                        'name': data.name,
                                        'hpp': data.hpp
                                      })
                                  .toList();

                              return CustomDropdown(
                                decoration: CustomDropdownDecoration(
                                    closedBorder:
                                        Border.all(color: Colors.grey.shade400),
                                    expandedBorder: Border.all(
                                        color: Colors.grey.shade400)),
                                hintText: 'Pilih Customer',
                                items:
                                    produk.map((e) => e['name']).toList() ?? [],
                                onChanged: (item) {
                                  print("Selected Item: $item");

                                  final selected = produk.firstWhere(
                                    (e) => e['name'] == item,
                                  );

                                  setState(() {
                                    selectProdukId =
                                        int.parse(selected!['id'].toString());
                                    formList[index]['product_id'] =
                                        selectProdukId;
                                    formList[index]['hpp'] = selected['hpp'];
                                    formList[index]['new_hpp'] =
                                        selected['hpp'];
                                    hppBaruControllers[index].text =
                                        selected['hpp'].toString();
                                  });

                                  print("Selected ID: $selectProdukId");
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      width: width,
                      height: 80.h,
                      child: ListTile(
                        title: Text(
                          'Hpp Baru',
                          style: subtitleTextBlack,
                        ),
                        subtitle: Container(
                          margin: EdgeInsets.only(top: height * 0.01),
                          child: WidgetForm(
                            controller: hppBaruControllers[index],
                            change: (value) {
                              setState(() {
                                formList[index]['new_hpp'] =
                                    double.tryParse(value) ?? 0.0;
                              });
                            },
                            alert: 'Hpp Baru',
                            hint: 'Hpp Baru',
                            typeInput: TextInputType.number,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
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
                            change: (value) {
                              setState(() {
                                formList[index]['qty'] =
                                    int.tryParse(value) ?? 0;
                              });
                            },
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
                      height: 10.h,
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
                            onChanged: (value) {
                              setState(() {
                                formList[index]['note'] = value;
                              });
                            },
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
              height: 10.h,
            ),
            SizedBox(
              width: width,
              height: height * 0.06,
              child: Align(
                alignment: Alignment.topCenter,
                child: WidgetButtonCustom(
                    FullWidth: width * 0.9,
                    FullHeight: 40.h,
                    title: 'Tambah Form Gas / Jasa',
                    onpressed: _addForm,
                    bgColor: PRIMARY_COLOR,
                    color: PRIMARY_COLOR),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: formListB.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
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
                              onPressed: () => _removeFormB(index),
                              icon: const Icon(Icons.delete),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ListTile(
                        title: Text(
                          'Pilih Item',
                          style: subtitleTextBlack,
                        ),
                        subtitle: Container(
                          margin: EdgeInsets.only(top: height * 0.01),
                          child: Consumer<ProviderItem>(
                            builder: (context, provider, child) {
                              final item = provider.allItem!.data!
                                  .map((data) => {
                                        'id': data.id,
                                        'name': data.name,
                                        "hpp": data.price
                                      })
                                  .toList();

                              return CustomDropdown(
                                decoration: CustomDropdownDecoration(
                                    closedBorder:
                                        Border.all(color: Colors.grey.shade400),
                                    expandedBorder: Border.all(
                                        color: Colors.grey.shade400)),
                                hintText: 'Pilih Customer',
                                items:
                                    item.map((e) => e['name']).toList() ?? [],
                                onChanged: (value) {
                                  print("Selected Item: $item");

                                  final selected = item.firstWhere(
                                    (e) => e['name'] == value,
                                  );

                                  setState(() {
                                    selectItemId =
                                        int.parse(selected!['id'].toString());
                                  });

                                  setState(() {
                                    formListB[index]['item_id'] = selectItemId;
                                    formListB[index]['hpp'] = selected['hpp'];
                                    formListB[index]['new_hpp'] =
                                        selected['hpp'];
                                    hppBaruControllersB[index].text =
                                        selected['hpp'].toString();
                                  });

                                  print("Selected ID: $selectItemId");
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      width: width,
                      height: 80.h,
                      child: ListTile(
                        title: Text(
                          'Hpp Baru',
                          style: subtitleTextBlack,
                        ),
                        subtitle: Container(
                          margin: EdgeInsets.only(top: height * 0.01),
                          child: WidgetForm(
                            controller: hppBaruControllersB[index],
                            change: (value) {
                              setState(() {
                                formListB[index]['new_hpp'] =
                                    double.tryParse(value) ?? 0.0;
                              });
                            },
                            alert: 'Hpp Baru',
                            hint: 'Hpp Baru',
                            typeInput: TextInputType.number,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
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
                            change: (value) {
                              setState(() {
                                formListB[index]['qty'] =
                                    int.tryParse(value) ?? 0;
                              });
                            },
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
                      height: 10.h,
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
                            onChanged: (value) {
                              setState(() {
                                formListB[index]['note'] = value;
                              });
                            },
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
              width: width,
              height: height * 0.06,
              child: Align(
                alignment: Alignment.topCenter,
                child: WidgetButtonCustom(
                    FullWidth: width * 0.9,
                    FullHeight: 40.h,
                    title: 'Tambah Item',
                    onpressed: _addFormB,
                    bgColor: PRIMARY_COLOR,
                    color: PRIMARY_COLOR),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: width,
                height: 250.h,
                child: ListTile(
                  title: Text(
                    'PIC Approval',
                    style: subtitleTextBlack,
                  ),
                  subtitle: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Consumer<ProviderSales>(
                        builder: (context, provider, child) {
                          final pic = provider.modelUsersPic!.data!
                              .map((data) => {'id': data.id, 'name': data.name})
                              .toList();

                          return CustomDropdown(
                            decoration: CustomDropdownDecoration(
                                closedBorder:
                                    Border.all(color: Colors.grey.shade400),
                                expandedBorder:
                                    Border.all(color: Colors.grey.shade400)),
                            hintText: 'Pilih PIC Verifikasi',
                            items: pic.map((e) => e['name']).toList(),
                            onChanged: (item) {
                              print("Selected Item: $item");

                              final selected = pic.firstWhere(
                                (e) => e['name'] == item,
                              );

                              setState(() {
                                selectPicId =
                                    int.parse(selected['id'].toString());
                              });

                              print("Selected ID: $selectPicId");
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Consumer<ProviderSales>(
                        builder: (context, provider, child) {
                          final pic = provider.modelUsersPic!.data!
                              .map((data) => {'id': data.id, 'name': data.name})
                              .toList();

                          return CustomDropdown(
                            decoration: CustomDropdownDecoration(
                                closedBorder:
                                    Border.all(color: Colors.grey.shade400),
                                expandedBorder:
                                    Border.all(color: Colors.grey.shade400)),
                            hintText: 'Pilih PIC Mengetahui',
                            items: pic.map((e) => e['name']).toList(),
                            onChanged: (item) {
                              print("Selected Item: $item");

                              final selected = pic.firstWhere(
                                (e) => e['name'] == item,
                              );

                              setState(() {
                                selectPicId1 =
                                    int.parse(selected['id'].toString());
                              });

                              print("Selected ID: $selectPicId1");
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Consumer<ProviderSales>(
                        builder: (context, provider, child) {
                          final pic = provider.modelUsersPic!.data!
                              .map((data) => {'id': data.id, 'name': data.name})
                              .toList();

                          return CustomDropdown(
                            decoration: CustomDropdownDecoration(
                                closedBorder:
                                    Border.all(color: Colors.grey.shade400),
                                expandedBorder:
                                    Border.all(color: Colors.grey.shade400)),
                            hintText: 'Pilih PIC Menyetujui',
                            items: pic.map((e) => e['name']).toList(),
                            onChanged: (item) {
                              print("Selected Item: $item");

                              final selected = pic.firstWhere(
                                (e) => e['name'] == item,
                              );

                              setState(() {
                                selectPicId2 =
                                    int.parse(selected['id'].toString());
                              });

                              print("Selected ID: $selectPicId2");
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
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
                // Clean and format the data before sending
                final cleanFormList = formList
                    .where((form) =>
                        form['product_id'] != null &&
                        form['hpp'] != null &&
                        form['new_hpp'] != null &&
                        form['qty'] != null)
                    .map((form) => {
                          "product_id": form['product_id'] as int,
                          "hpp": (form['hpp'] is int || form['hpp'] is double)
                              ? form['hpp']
                              : double.parse(form['hpp'].toString()),
                          "new_hpp": (form['new_hpp'] is int ||
                                  form['new_hpp'] is double)
                              ? form['new_hpp']
                              : double.parse(form['new_hpp'].toString()),
                          "qty": form['qty'] is int
                              ? form['qty']
                              : int.parse(form['qty'].toString()),
                          "note": form['note']?.toString() ?? ""
                        })
                    .toList();

                final cleanFormListB = formListB
                    .where((form) =>
                        form['item_id'] != null &&
                        form['hpp'] != null &&
                        form['new_hpp'] != null &&
                        form['qty'] != null)
                    .map((form) => {
                          "item_id": form['item_id'] as int,
                          "hpp": (form['hpp'] is int || form['hpp'] is double)
                              ? form['hpp']
                              : double.parse(form['hpp'].toString()),
                          "new_hpp": (form['new_hpp'] is int ||
                                  form['new_hpp'] is double)
                              ? form['new_hpp']
                              : double.parse(form['new_hpp'].toString()),
                          "qty": form['qty'] is int
                              ? form['qty']
                              : int.parse(form['qty'].toString()),
                          "note": form['note']?.toString() ?? ""
                        })
                    .toList();

                if (jenisCustomer == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Pilih Customer terlebih dahulu')));
                  return;
                }

                if (cleanFormList.isEmpty && cleanFormListB.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Text('Tambahkan minimal satu item atau produk')));
                  return;
                }

                if (selectPicId == 0 ||
                    selectPicId1 == 0 ||
                    selectPicId2 == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Pilih semua PIC approval')));
                  return;
                }

                // Print untuk debugging
                print('Clean Products:');
                print(cleanFormList);
                print('Clean Items:');
                print(cleanFormListB);

                provider.createProdukOrder(
                    context,
                    jenisCustomer,
                    (buat?.selectedIndex ?? 0) + 1,
                    filepath,
                    poCustomer.text,
                    selectPicId,
                    selectPicId1,
                    selectPicId2,
                    cleanFormListB,
                    cleanFormList);
              },
              bgColor: PRIMARY_COLOR,
              color: PRIMARY_COLOR),
        ),
      ),
    );
  }
}
