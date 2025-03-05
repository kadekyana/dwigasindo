import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_sales.dart';
import 'package:dwigasindo/views/menus/component_maintenance/component_list_maintenance.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MenuMaintenance extends StatelessWidget {
  const MenuMaintenance({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderSales>(context);
    // List map untuk data
    final List<Map<String, dynamic>> items = [
      {'title': 'List Maintenance'},
      {'title': 'Item Penunjang'},
    ];

    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Maintenance',
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
        padding: EdgeInsets.symmetric(horizontal: 15.w),
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
                    provider.getListMaintenance(context, 1, 0),
                    provider.getSummaryMaintenance(context),
                    provider.getUsersPic(context),
                    provider.getItemSupport(context),
                  ]);

                  // Navigate sesuai kondisi
                  Navigator.of(context).pop(); // Tutup Dialog Loading
                  (item['title'] == "List Maintenance")
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ComponentListMaintenance(
                              title: 'List Maintenance',
                            ),
                          ),
                        )
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ComponentItemSupport(
                              title: item['title'],
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

class ComponentItemSupport extends StatefulWidget {
  ComponentItemSupport({super.key, required this.title});
  String title;
  @override
  _ComponentItemSupportState createState() => _ComponentItemSupportState();
}

class _ComponentItemSupportState extends State<ComponentItemSupport> {
  // Data untuk grafik spline

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderSales>(context);
    final data = provider.itemSupport?.data;
    return Scaffold(
      appBar: WidgetAppbar(
        title: widget.title,
        back: true,
        route: () {
          Navigator.pop(context);
        },
        colorBG: Colors.grey.shade100,
        colorTitle: Colors.black,
        colorBack: Colors.black,
        center: true,
      ),
      body: Container(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Column(
          children: [
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
                                          dataCard?.code ?? "-",
                                          style: titleText,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 130.w,
                                      height: 40.h,
                                      decoration: BoxDecoration(
                                        color: PRIMARY_COLOR,
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          bottomLeft: Radius.circular(30),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "-",
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
                                                        dataCard?.availableStock
                                                                .toString() ??
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
                                                        dataCard?.categoryName ??
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
                                                          dataCard?.itemName ??
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
                                                      child: Text("Customer",
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
                                                      child: Text("-",
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
                              // Padding(
                              //   padding: EdgeInsets.only(
                              //       bottom: 10.h, left: 10.w, right: 10.w),
                              //   child: Row(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       Expanded(
                              //         child: WidgetButtonCustom(
                              //           FullWidth: width * 0.3,
                              //           FullHeight: 30.h,
                              //           title: "Update Status",
                              //           onpressed: () {
                              //             showDialog(
                              //               context: context,
                              //               builder: (BuildContext context) {
                              //                 return Dialog(
                              //                   shape: RoundedRectangleBorder(
                              //                     borderRadius:
                              //                         BorderRadius.circular(10),
                              //                   ),
                              //                   child: SizedBox(
                              //                     height: 400.h,
                              //                     child: Stack(
                              //                       children: <Widget>[
                              //                         // Bagian isi dialog
                              //                         Padding(
                              //                           padding:
                              //                               EdgeInsets.only(
                              //                                   top: 60.h),
                              //                           child: Column(
                              //                             children: [
                              //                               Container(
                              //                                 width: 300.w,
                              //                                 height: 40.h,
                              //                                 margin: EdgeInsets
                              //                                     .symmetric(
                              //                                         horizontal:
                              //                                             20.w),
                              //                                 child:
                              //                                     WidgetButtonCustom(
                              //                                   FullWidth:
                              //                                       200.w,
                              //                                   FullHeight:
                              //                                       50.h,
                              //                                   title:
                              //                                       "Pengecekan",
                              //                                   onpressed:
                              //                                       dataCard.lastStatus !=
                              //                                               9
                              //                                           ? null
                              //                                           : () {

                              //                                                 Navigator.push(
                              //                                                   context,
                              //                                                   MaterialPageRoute(
                              //                                                     builder: (context) => ComponentButtonMaintenance(
                              //                                                       title: 'Pergantian Sparepart',
                              //                                                       id: dataCard.id!,
                              //                                                     ),
                              //                                                   ),
                              //                                                 );

                              //                                             },
                              //                                   color:
                              //                                       PRIMARY_COLOR,
                              //                                   bgColor: dataCard
                              //                                               .lastStatus !=
                              //                                           9
                              //                                       ? Colors
                              //                                           .grey
                              //                                       : PRIMARY_COLOR,
                              //                                 ),
                              //                               ),
                              //                               SizedBox(
                              //                                 height: 10.h,
                              //                               ),
                              //                               Container(
                              //                                 width: 300.w,
                              //                                 height: 40.h,
                              //                                 margin: EdgeInsets
                              //                                     .symmetric(
                              //                                         horizontal:
                              //                                             20.w),
                              //                                 child:
                              //                                     WidgetButtonCustom(
                              //                                   FullWidth:
                              //                                       200.w,
                              //                                   FullHeight:
                              //                                       50.h,
                              //                                   title:
                              //                                       "Konfirmasi",
                              //                                   onpressed:
                              //                                       dataCard.lastStatus !=
                              //                                               0
                              //                                           ? null
                              //                                           : () {
                              //                                               Navigator.push(
                              //                                                 context,
                              //                                                 MaterialPageRoute(
                              //                                                   builder: (context) => UpdateStatusToUsers(
                              //                                                     title: 'Pergantian Sparepart',
                              //                                                     id: dataCard.id!,
                              //                                                     lastStatus: 1,
                              //                                                   ),
                              //                                                 ),
                              //                                               );
                              //                                             },
                              //                                   color:
                              //                                       PRIMARY_COLOR,
                              //                                   bgColor: dataCard
                              //                                               .lastStatus !=
                              //                                           0
                              //                                       ? Colors
                              //                                           .grey
                              //                                       : PRIMARY_COLOR,
                              //                                 ),
                              //                               ),
                              //                               SizedBox(
                              //                                 height: 10.h,
                              //                               ),
                              //                               Container(
                              //                                 width: 300.w,
                              //                                 height: 40.h,
                              //                                 margin: EdgeInsets
                              //                                     .symmetric(
                              //                                         horizontal:
                              //                                             20.w),
                              //                                 child:
                              //                                     WidgetButtonCustom(
                              //                                   FullWidth:
                              //                                       200.w,
                              //                                   FullHeight:
                              //                                       50.h,
                              //                                   title:
                              //                                       "Pergantian Sparepart",
                              //                                   onpressed:
                              //                                       dataCard.lastStatus !=
                              //                                               1
                              //                                           ? null
                              //                                           : () {
                              //                                               Navigator.push(
                              //                                                 context,
                              //                                                 MaterialPageRoute(
                              //                                                   builder: (context) => UpdateStatusToUsers(
                              //                                                     title: 'Pergantian Sparepart',
                              //                                                     id: dataCard.id!,
                              //                                                     lastStatus: dataCard.lastStatus!,
                              //                                                   ),
                              //                                                 ),
                              //                                               );
                              //                                             },
                              //                                   color:
                              //                                       PRIMARY_COLOR,
                              //                                   bgColor: dataCard
                              //                                               .lastStatus !=
                              //                                           1
                              //                                       ? Colors
                              //                                           .grey
                              //                                       : PRIMARY_COLOR,
                              //                                 ),
                              //                               ),
                              //                               SizedBox(
                              //                                 height: 10.h,
                              //                               ),
                              //                               Container(
                              //                                 width: 300.w,
                              //                                 height: 40.h,
                              //                                 margin: EdgeInsets
                              //                                     .symmetric(
                              //                                         horizontal:
                              //                                             20.w),
                              //                                 child:
                              //                                     WidgetButtonCustom(
                              //                                   FullWidth:
                              //                                       200.w,
                              //                                   FullHeight:
                              //                                       50.h,
                              //                                   title:
                              //                                       "Ready To Use",
                              //                                   onpressed:
                              //                                       dataCard.lastStatus !=
                              //                                               2
                              //                                           ? null
                              //                                           : () {
                              //                                               Navigator.push(
                              //                                                 context,
                              //                                                 MaterialPageRoute(
                              //                                                   builder: (context) => UpdateStatusToUsers(
                              //                                                     title: 'Ready To Use',
                              //                                                     id: dataCard.id!,
                              //                                                     lastStatus: 3,
                              //                                                   ),
                              //                                                 ),
                              //                                               );
                              //                                             },
                              //                                   color:
                              //                                       PRIMARY_COLOR,
                              //                                   bgColor: dataCard
                              //                                               .lastStatus !=
                              //                                           2
                              //                                       ? Colors
                              //                                           .grey
                              //                                       : PRIMARY_COLOR,
                              //                                 ),
                              //                               ),
                              //                               SizedBox(
                              //                                 height: 10.h,
                              //                               ),
                              //                               Container(
                              //                                 width: 300.w,
                              //                                 height: 40.h,
                              //                                 margin: EdgeInsets
                              //                                     .symmetric(
                              //                                         horizontal:
                              //                                             20.w),
                              //                                 child:
                              //                                     WidgetButtonCustom(
                              //                                   FullWidth:
                              //                                       200.w,
                              //                                   FullHeight:
                              //                                       50.h,
                              //                                   title:
                              //                                       "Retur Customer",
                              //                                   onpressed:
                              //                                       dataCard.lastStatus !=
                              //                                               1
                              //                                           ? null
                              //                                           : () {
                              //                                               Navigator.push(
                              //                                                 context,
                              //                                                 MaterialPageRoute(
                              //                                                   builder: (context) => UpdateStatusToUsers(
                              //                                                     title: 'Retur Customer',
                              //                                                     id: dataCard.id!,
                              //                                                     lastStatus: 4,
                              //                                                   ),
                              //                                                 ),
                              //                                               );
                              //                                             },
                              //                                   color:
                              //                                       PRIMARY_COLOR,
                              //                                   bgColor: dataCard
                              //                                               .lastStatus !=
                              //                                           1
                              //                                       ? Colors
                              //                                           .grey
                              //                                       : PRIMARY_COLOR,
                              //                                 ),
                              //                               ),
                              //                               SizedBox(
                              //                                 height: 10.h,
                              //                               ),
                              //                               Container(
                              //                                 width: 300.w,
                              //                                 height: 40.h,
                              //                                 margin: EdgeInsets
                              //                                     .symmetric(
                              //                                         horizontal:
                              //                                             20.w),
                              //                                 child:
                              //                                     WidgetButtonCustom(
                              //                                   FullWidth:
                              //                                       200.w,
                              //                                   FullHeight:
                              //                                       50.h,
                              //                                   title: "Afkir",
                              //                                   onpressed:
                              //                                       dataCard.lastStatus !=
                              //                                               1
                              //                                           ? null
                              //                                           : () {
                              //                                               Navigator.push(
                              //                                                 context,
                              //                                                 MaterialPageRoute(
                              //                                                   builder: (context) => FormAfkir(
                              //                                                     title: 'Ready To Use',
                              //                                                     id: dataCard.id!,
                              //                                                   ),
                              //                                                 ),
                              //                                               );
                              //                                             },
                              //                                   color:
                              //                                       PRIMARY_COLOR,
                              //                                   bgColor: dataCard
                              //                                               .lastStatus !=
                              //                                           1
                              //                                       ? Colors
                              //                                           .grey
                              //                                       : PRIMARY_COLOR,
                              //                                 ),
                              //                               ),
                              //                             ],
                              //                           ),
                              //                         ),
                              //                         // Bagian atas kiri dan kanan
                              //                         Positioned(
                              //                           left: 10,
                              //                           top: 10,
                              //                           child: TextButton(
                              //                             onPressed: () {
                              //                               // Aksi untuk Update
                              //                               print(
                              //                                   "Update clicked");
                              //                             },
                              //                             child: Text(
                              //                                 'Pilih Status',
                              //                                 style:
                              //                                     titleTextBlack),
                              //                           ),
                              //                         ),
                              //                         Positioned(
                              //                           right: 10,
                              //                           top: 10,
                              //                           child: IconButton(
                              //                             icon:
                              //                                 Icon(Icons.close),
                              //                             onPressed: () {
                              //                               Navigator.pop(
                              //                                   context);
                              //                             },
                              //                           ),
                              //                         ),
                              //                       ],
                              //                     ),
                              //                   ),
                              //                 );
                              //               },
                              //             );
                              //           },
                              //           bgColor: PRIMARY_COLOR,
                              //           color: Colors.transparent,
                              //         ),
                              //       ),
                              //       SizedBox(
                              //         width: 10.w,
                              //       ),
                              //       Expanded(
                              //         child: WidgetButtonCustom(
                              //           FullWidth: width * 0.3,
                              //           FullHeight: 30.h,
                              //           title: "Lihat",
                              //           onpressed: () {},
                              //           bgColor: PRIMARY_COLOR,
                              //           color: Colors.transparent,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
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
