import 'dart:async';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/model/modelLoadingTube.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/providers/provider_sales.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
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
  bool _isLoading = false;
  Set<int> expandedCards = {};

  final TextEditingController tare = TextEditingController();
  final TextEditingController empty = TextEditingController();

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
  void _getDataForTab(int tabIndex) async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(milliseconds: 300)); // efek delay transisi
    // Fungsi untuk mengambil data berdasarkan tab yang aktif
    switch (tabIndex) {
      case 0:
        // Tab List
        Provider.of<ProviderDistribusi>(context, listen: false)
            .getClaimsAll(context, 0);
        // Panggil fungsi untuk mendapatkan data List
        break;
      case 1:
        // Tab Ready to use
        Provider.of<ProviderDistribusi>(context, listen: false)
            .getClaimsAll(context, 1);
        // Panggil fungsi untuk mendapatkan data Ready to use
        break;
      case 2:
        // Tab Afkir
        Provider.of<ProviderDistribusi>(context, listen: false)
            .getClaimsAll(context, 2);
        // Panggil fungsi untuk mendapatkan data Afkir
        break;
      case 3:
        // Tab Retur
        Provider.of<ProviderDistribusi>(context, listen: false)
            .getClaimsAll(context, 3);
        // Panggil fungsi untuk mendapatkan data Retur
        break;
      default:
        break;
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _tabController.dispose(); // Jangan lupa untuk dispose controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              Tab(text: "Pending"),
              Tab(text: "Maintenance"),
              Tab(text: "Return"),
              Tab(text: "Claim"),
            ],
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : TabBarView(
                    controller: _tabController,
                    children: const [
                      ComponentMenuList(),
                      ComponentMenuMaintenance(),
                      ComponentMenuReturn(),
                      ComponentMenuClaimProduksi(),
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
  bool _showForm = false;
  int? _selectedCardIndex;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderDistribusi>(context);
    final data = provider.claimsAll?.data;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: (data == null)
            ? Center(
                child: Text("Belum Terdapat Data"),
              )
            : ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final dataCard = data[index];
                  return
                      //  (dataCard.status != 0)
                      //     ? Container(
                      //         width: double.maxFinite,
                      //         height: height / 1.5,
                      //         child: Center(
                      //           child: Text("Belum Terdapat Data"),
                      //         ),
                      //       )
                      //     :
                      Column(
                    children: [
                      Container(
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
                                    width: 200.w,
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
                                        dataCard?.claimNo ?? "-",
                                        style: titleText,
                                      ),
                                    ),
                                  ),
                                  Container(
                                      width: 100.w,
                                      height: 30.h,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10.w),
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
                                    top:
                                        BorderSide(color: Colors.grey.shade300),
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
                                                      'Produk',
                                                      style: subtitleTextBlack,
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
                                                      style: subtitleTextBlack,
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
                                                      dataCard?.tubeCode ?? "-",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.justify,
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
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      'Grade',
                                                      style: subtitleTextBlack,
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
                                                      style: subtitleTextBlack,
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
                                                      'Milik',
                                                      style: subtitleTextBlack,
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
                                                      style: subtitleTextBlack,
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
                                                      'jenis Gas',
                                                      style: subtitleTextBlack,
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
                                                      style: subtitleTextBlack,
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
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.justify,
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
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      'Dibuat Oleh',
                                                      style: subtitleTextNormal,
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
                                                      style: subtitleTextNormal,
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
                                                        dataCard?.customerName ??
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
                                                      style: subtitleTextNormal,
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
                                                      style: subtitleTextNormal,
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
                                                            dataCard!.createdAt
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
                                      title: "Verifikasi",
                                      onpressed: () {
                                        setState(() {
                                          if (_selectedCardIndex == index) {
                                            _showForm =
                                                !_showForm; // Toggle form
                                          } else {
                                            _selectedCardIndex = index;
                                            _showForm = true;
                                          }
                                        });
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
                      ),
                      if (_showForm && _selectedCardIndex == index)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: _buildWeightForm(
                              "ID-${index + 1}", dataCard.claimNo!),
                        ),
                    ],
                  );
                },
              ),
      ),
    );
  }

  Widget _buildWeightForm(String idStr, String id) {
    SingleSelectController<String?>? form =
        SingleSelectController<String?>(null);
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Update Status",
            style: subtitleTextBoldBlack,
          ),
        ),
        SizedBox(height: 10.h),
        CustomDropdown(
          controller: form,
          decoration: CustomDropdownDecoration(
              closedBorder: Border.all(color: Colors.grey.shade400),
              expandedBorder: Border.all(color: Colors.grey.shade400)),
          hintText: 'Pilih Status',
          items: const ['Maintenance', 'Return Customer', 'Claim Produksi'],
          onChanged: (value) {},
        ),
        SizedBox(height: 10.h),
        WidgetButtonCustom(
          FullWidth: MediaQuery.of(context).size.width,
          FullHeight: 35.h,
          title: 'Submit',
          onpressed: () async {
            final provider =
                Provider.of<ProviderDistribusi>(context, listen: false);
            print(form.value);
            await provider.updateStatusClaim(
                context,
                id,
                (form.value == "Maintenance")
                    ? 1
                    : (form.value == "Return Customer")
                        ? 2
                        : 3);
            setState(() {
              _showForm = false;
            });
          },
          bgColor: PRIMARY_COLOR,
          color: Colors.transparent,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
      ],
    );
  }
}

class ComponentMenuMaintenance extends StatefulWidget {
  const ComponentMenuMaintenance({
    super.key,
  });

  @override
  State<ComponentMenuMaintenance> createState() =>
      _ComponentMenuMaintenanceState();
}

class _ComponentMenuMaintenanceState extends State<ComponentMenuMaintenance> {
  bool check = true;
  GroupButtonController? menu = GroupButtonController(selectedIndex: 0);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderDistribusi>(context);
    final data = provider.claimsAll?.data;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: (data == null)
            ? Center(
                child: Text("Belum Terdapat Data"),
              )
            : ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final dataCard = data[index];
                  return (dataCard.status != 1)
                      ? Container(
                          width: double.maxFinite,
                          height: height / 1.5,
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
                                      width: 200.w,
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
                                          dataCard?.claimNo ?? "-",
                                          style: titleText,
                                        ),
                                      ),
                                    ),
                                    Container(
                                        width: 100.w,
                                        height: 30.h,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10.w),
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
                                                        'Produk',
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
                                                        dataCard?.tubeCode ??
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
                                                        'jenis Gas',
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
                                                          dataCard?.customerName ??
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
                            ],
                          ),
                        );
                },
              ),
      ),
    );
  }
}

class ComponentMenuReturn extends StatefulWidget {
  const ComponentMenuReturn({
    super.key,
  });

  @override
  State<ComponentMenuReturn> createState() => _ComponentMenuReturnState();
}

class _ComponentMenuReturnState extends State<ComponentMenuReturn> {
  bool check = true;
  GroupButtonController? menu = GroupButtonController(selectedIndex: 0);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderDistribusi>(context);
    final data = provider.claimsAll?.data;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: (data == null)
            ? Center(
                child: Text("Belum Terdapat Data"),
              )
            : ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final dataCard = data[index];
                  return (dataCard.status != 2)
                      ? Container(
                          width: double.maxFinite,
                          height: height / 1.5,
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
                                      width: 200.w,
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
                                          dataCard?.claimNo ?? "-",
                                          style: titleText,
                                        ),
                                      ),
                                    ),
                                    Container(
                                        width: 100.w,
                                        height: 30.h,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10.w),
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
                                                        'Produk',
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
                                                        dataCard?.tubeCode ??
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
                                                        'jenis Gas',
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
                                                          dataCard?.customerName ??
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
                            ],
                          ),
                        );
                },
              ),
      ),
    );
  }
}

class ComponentMenuClaimProduksi extends StatefulWidget {
  const ComponentMenuClaimProduksi({
    super.key,
  });

  @override
  State<ComponentMenuClaimProduksi> createState() =>
      _ComponentMenuClaimProduksiState();
}

class _ComponentMenuClaimProduksiState
    extends State<ComponentMenuClaimProduksi> {
  bool check = true;
  GroupButtonController? menu = GroupButtonController(selectedIndex: 0);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderDistribusi>(context);
    final data = provider.claimsAll?.data;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: (data == null)
            ? Center(
                child: Text("Belum Terdapat Data"),
              )
            : ListView.builder(
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
                                width: 200.w,
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
                                    dataCard?.claimNo ?? "-",
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
                                                  dataCard?.tubeCode ?? "-",
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
                                                  'jenis Gas',
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
                                                    dataCard?.customerName ??
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
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
