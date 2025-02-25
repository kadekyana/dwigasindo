import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_sales.dart';
import 'package:dwigasindo/views/menus/component_sales/component_menu_buat_tugas.dart';
import 'package:dwigasindo/views/menus/component_sales/component_menu_detail_sales_informasi.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class ComponentMenuSelesInformation extends StatefulWidget {
  ComponentMenuSelesInformation({super.key, required this.title});
  String title;

  @override
  State<ComponentMenuSelesInformation> createState() =>
      _ComponentDataMasterCustomerState();
}

class _ComponentDataMasterCustomerState
    extends State<ComponentMenuSelesInformation> {
  List<bool> check = [true, false];
  bool non = false;
  GroupButtonController? menu = GroupButtonController(selectedIndex: 0);

  @override
  Widget build(BuildContext context) {
    print(widget.title);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderSales>(context);
    final data = provider.listSales?.data;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(horizontal: 20),
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
                itemCount: data!.length,
                itemBuilder: (context, index) {
                  final dataCard = data[index];
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
                        Container(
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
                                    color: Colors.green, // Warna biru tua
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(30),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text("Good", style: titleText),
                                ),
                              ),
                              // Bagian kanan (TW: 36.8)
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  width: 100.w,
                                  padding: EdgeInsets.only(right: 10.w),
                                  child: FittedBox(
                                    alignment: Alignment.bottomRight,
                                    fit: BoxFit.scaleDown,
                                    child: Text("Dibuat Oleh : User 1",
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
                                top: BorderSide(color: Colors.grey.shade300),
                              ),
                            ),
                            child: Row(
                              children: [
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
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Nama Sales',
                                                  style:
                                                      subtitleTextNormalblack,
                                                ),
                                              ),
                                            ),
                                            const Text(':'),
                                            Expanded(
                                              flex: 3,
                                              child: Text('\t${dataCard.name}',
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
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'NIK',
                                                  style:
                                                      subtitleTextNormalblack,
                                                ),
                                              ),
                                            ),
                                            Text(':'),
                                            Expanded(
                                              flex: 3,
                                              child: Text('\t${dataCard.nik}',
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
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Status Karyawan',
                                                  style:
                                                      subtitleTextNormalblack,
                                                ),
                                              ),
                                            ),
                                            Text(':'),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                  '\t${(dataCard.statusEmployee == 1) ? "Tetap" : "Kontrak"}',
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
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Sales',
                                                  style:
                                                      subtitleTextNormalblack,
                                                ),
                                              ),
                                            ),
                                            Text(':'),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                  '\t${provider.formatCurrency(dataCard.totalSales as num)}',
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
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Lama Kerja',
                                                  style:
                                                      subtitleTextNormalblack,
                                                ),
                                              ),
                                            ),
                                            Text(':'),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                  '\t${dataCard.workSinceDesc}',
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
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Dibuat Pada',
                                                  style: subtitleTextNormalGrey,
                                                ),
                                              ),
                                            ),
                                            Text(':',
                                                style: subtitleTextNormalGrey),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                  '\t${provider.formatDate(dataCard.createdAt.toString())}',
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
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: CircularPercentIndicator(
                                            radius: 45.0,
                                            lineWidth: 5,
                                            percent: dataCard.totalSales! > 0
                                                ? dataCard.totalRemaining! /
                                                    dataCard.totalSales!
                                                : 0.0,
                                            center: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                    "${provider.formatCurrency(dataCard.totalSales as num)}"
                                                        .toString(),
                                                    style:
                                                        minisubtitleTextBlack),
                                                Text("Lagi",
                                                    style:
                                                        minisubtitleTextGrey),
                                              ],
                                            ),
                                            backgroundColor:
                                                Colors.grey.shade300,
                                            progressColor: Colors.blue,
                                            circularStrokeCap:
                                                CircularStrokeCap.round,
                                          ),
                                        ),
                                        SizedBox(height: 5.0),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: width,
                          height: 40.h,
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          margin: EdgeInsets.only(bottom: 10.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              WidgetButtonCustom(
                                  FullWidth: 150.w,
                                  FullHeight: 35.h,
                                  title: "Buat Tugas",
                                  onpressed: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ComponentMenuBuatTugas(),
                                      ),
                                    );
                                  },
                                  bgColor: PRIMARY_COLOR,
                                  color: Colors.transparent),
                              WidgetButtonCustom(
                                  FullWidth: 150.w,
                                  FullHeight: 35.h,
                                  title: "Lihat Data",
                                  onpressed: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ComponentMenuDetailSalesInformasi(
                                          title: widget.title,
                                        ),
                                      ),
                                    );
                                  },
                                  bgColor: PRIMARY_COLOR,
                                  color: Colors.transparent),
                            ],
                          ),
                        )
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
