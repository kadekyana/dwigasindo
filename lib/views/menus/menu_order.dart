import 'dart:async';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/model/modelLoadingTube.dart';
import 'package:dwigasindo/providers/provider_Order.dart';
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
                    providerSa.getAllOrder(context, 2),
                    providerItem.getAllItem(context),
                    providerSa.getSummaryOrder(context),
                    provider.getMasterProduk(context),
                    provider.getMasterProdukTrash(context),
                    providerDis.getAllTubeGrade(context),
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
                ComponentMenuListPO(),
                ComponentMenuListRetail(),
                // Konten untuk setiap tab
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ComponentMenuListPO extends StatefulWidget {
  const ComponentMenuListPO({
    super.key,
  });

  @override
  State<ComponentMenuListPO> createState() => _ComponentMenuListPOState();
}

class _ComponentMenuListPOState extends State<ComponentMenuListPO> {
  List<bool> check = [true, false];
  bool non = false;
  GroupButtonController? menu = GroupButtonController(selectedIndex: 0);
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProviderOrder>(context, listen: false);
    provider.getAllOrder(context, 1);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderOrder>(context);
    final data = provider.order?.data;

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
              child: ListView.builder(
                itemCount: data?.length,
                itemBuilder: (context, index) {
                  final dataCard = data?[index];
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
                                    'PO20241212001',
                                    style: titleText,
                                  ),
                                ),
                              ),
                              Container(
                                width: 130.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  color: (data == true)
                                      ? Colors.green
                                      : SECONDARY_COLOR,
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomLeft: Radius.circular(30),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    (data == true) ? "Approve" : "Reject",
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
                                top: BorderSide(color: Colors.grey.shade300),
                              ),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                          'Gas',
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          'Produk',
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
                                          'Argon IG',
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
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                        child: Text('PT. Lorem Ipsum',
                                            style: subtitleTextBlack),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                        child: Text('Rp.70.000.000',
                                            style: subtitleTextBlack),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                        child: Text('User 1',
                                            style: subtitleTextNormal),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                        child: Text('17 - 12 - 2024',
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: WidgetButtonCustom(
                                  FullWidth: width * 0.3,
                                  FullHeight: 30.h,
                                  title: "Lihat Order",
                                  onpressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ComponentDetailOrder(),
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

class ComponentMenuListRetail extends StatefulWidget {
  const ComponentMenuListRetail({
    super.key,
  });

  @override
  State<ComponentMenuListRetail> createState() =>
      _ComponentMenuListRetailState();
}

class _ComponentMenuListRetailState extends State<ComponentMenuListRetail> {
  List<bool> check = [true, false];
  bool non = false;
  GroupButtonController? menu = GroupButtonController(selectedIndex: 0);

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProviderOrder>(context, listen: false);
    provider.getAllOrder(context, 2);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final providerOr = Provider.of<ProviderOrder>(context);
    final provider = Provider.of<ProviderSales>(context);
    final data = provider.order?.data;
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
              child: ListView.builder(
                itemCount: data?.length,
                itemBuilder: (context, index) {
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  color: (dataCard.approvalStatus == "Approve")
                                      ? Colors.green
                                      : (dataCard.approvalStatus == "Review")
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
                                    style: (dataCard.approvalStatus == "Review")
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
                                top: BorderSide(color: Colors.grey.shade300),
                              ),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                            provider.formatCurrency(dataCard
                                                .totalTransaction as num),
                                            style: subtitleTextBlack),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                        child: Text('${dataCard.createdBy}',
                                            style: subtitleTextNormal),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                            provider.formatDate(
                                                dataCard.createdAt.toString()),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          child: CircularProgressIndicator(),
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
  GroupButtonController? button = GroupButtonController(selectedIndex: 0);
  GroupButtonController? buat = GroupButtonController(selectedIndex: 0);
  bool cek = false;
  int jenis = 0;
  int cari = 0;
  int? selectProdukId;
  int? selectItemId;

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

  List<Map<String, dynamic>> formList = []; // List untuk menyimpan data form
  List<Map<String, dynamic>> formListB = []; // List untuk menyimpan data form
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
    });
  }

  // Fungsi untuk menghapus form terakhir
  void _removeForm(int index) {
    setState(() {
      formList.removeAt(index);
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
    });
  }

  // Fungsi untuk menghapus form terakhir
  void _removeFormB(int index) {
    setState(() {
      formListB.removeAt(index);
    });
  }

  String? pdfPath;

  // Function to handle the PDF upload
  void _onPdfPicked(String path) {
    setState(() {
      pdfPath = path; // Store the PDF file path
    });
  }

  // Function to allow replacing the PDF (upload a new one)
  void _replacePdf() {
    setState(() {
      pdfPath = null; // Clear the current PDF path to allow re-upload
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<ProviderOrder>(context);
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
              height: 80.h,
              child: ListTile(
                title: Text(
                  'Jenis Customer',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: Consumer<ProviderSales>(
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
                            selectPicId2 = int.parse(selected['id'].toString());
                          });

                          print("Selected ID: $selectPicId2");
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
                  'Jenis Order',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      isRadio: true,
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
              height: 80.h,
              child: ListTile(
                title: Text(
                  'Jenis Order',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      isRadio: true,
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
            if (pdfPath == null) // Only show if PDF is not uploaded yet
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: PdfUploadWidget(
                  onFilePicked: (path) {
                    _onPdfPicked(path); // Update PDF path on pick
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
                        style: const TextStyle(color: Colors.red)),
                    SizedBox(height: 10.h),
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
                                  .map((data) =>
                                      {'id': data.id, 'name': data.name})
                                  .toList();

                              return CustomAutocomplete(
                                data:
                                    produk.map((e) => e['name']).toList() ?? [],
                                displayString: (item) => item.toString(),
                                onSelected: (item) {
                                  print("Selected Item: $item");

                                  final selected = produk.firstWhere(
                                    (e) => e['name'] == item,
                                  );

                                  setState(() {
                                    selectProdukId =
                                        int.parse(selected!['id'].toString());
                                  });

                                  setState(() {
                                    formList[index]['product_id'] =
                                        selectProdukId;
                                  });

                                  print("Selected ID: $selectProdukId");
                                },
                                labelText: 'Cari Barang',
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
                          'Hpp',
                          style: subtitleTextBlack,
                        ),
                        subtitle: Container(
                          margin: EdgeInsets.only(top: height * 0.01),
                          child: WidgetForm(
                            change: (value) {
                              setState(() {
                                formList[index]['hpp'] = value;
                              });
                            },
                            alert: 'Hpp',
                            hint: 'Hpp',
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
                          'Hpp Baru',
                          style: subtitleTextBlack,
                        ),
                        subtitle: Container(
                          margin: EdgeInsets.only(top: height * 0.01),
                          child: WidgetForm(
                            change: (value) {
                              setState(() {
                                formList[index]['new_hpp'] = value;
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
                                formList[index]['qty'] = value;
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
                                  .map((data) =>
                                      {'id': data.id, 'name': data.name})
                                  .toList();

                              return CustomAutocomplete(
                                data: item.map((e) => e['name']).toList() ?? [],
                                displayString: (item) => item.toString(),
                                onSelected: (value) {
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
                                  });

                                  print("Selected ID: $selectItemId");
                                },
                                labelText: 'Cari Item',
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
                          'Hpp',
                          style: subtitleTextBlack,
                        ),
                        subtitle: Container(
                          margin: EdgeInsets.only(top: height * 0.01),
                          child: WidgetForm(
                            change: (value) {
                              setState(() {
                                formListB[index]['hpp'] = value;
                              });
                            },
                            alert: 'Hpp',
                            hint: 'Hpp',
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
                          'Hpp Baru',
                          style: subtitleTextBlack,
                        ),
                        subtitle: Container(
                          margin: EdgeInsets.only(top: height * 0.01),
                          child: WidgetForm(
                            change: (value) {
                              setState(() {
                                formListB[index]['new_hpp'] = value;
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
                                formListB[index]['qty'] = value;
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
                // provider.createProdukOrder(
                //   context,
                // );
              },
              bgColor: PRIMARY_COLOR,
              color: PRIMARY_COLOR),
        ),
      ),
    );
  }
}
