import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/views/menus/component_warehouse/PenB/component_detail_permintaan_barang.dart';
import 'package:dwigasindo/views/menus/component_warehouse/PenB/component_tambah_permintaan_barang.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:group_button/group_button.dart';

class ComponentPermintaanBarang extends StatefulWidget {
  const ComponentPermintaanBarang({super.key});

  @override
  State<ComponentPermintaanBarang> createState() =>
      _ComponentPermintaanBarangState();
}

class _ComponentPermintaanBarangState extends State<ComponentPermintaanBarang> {
  List<bool> check = [true, false];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Permintaan Barang',
        center: true,
        colorTitle: Colors.black,
        colorBack: Colors.black,
        colorBG: Colors.grey.shade100,
        back: true,
        route: () {
          Navigator.pop(context);
        },
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ComponentTambahPermintaanBarang(),
                ),
              );
            },
            icon: const Icon(
              Icons.add_circle_outline_rounded,
              color: Colors.black,
            ),
          ),
        ],
      ),
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
            Align(
              alignment: Alignment.centerLeft,
              child: GroupButton(
                  isRadio: true,
                  options: GroupButtonOptions(
                    selectedColor: PRIMARY_COLOR,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onSelected: (value, index, isSelected) {
                    print('DATA KLIK : $value - $index - $isSelected');
                  },
                  buttons: const ['List SO', 'History']),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: check.length,
                itemBuilder: (context, index) {
                  final data = check[index];
                  return widgetCard(height: height, width: width, data: data);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class widgetCard extends StatelessWidget {
  const widgetCard({
    super.key,
    required this.height,
    required this.width,
    required this.data,
  });

  final double height;
  final double width;
  final bool data;

  @override
  Widget build(BuildContext context) {
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
            height: height * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: width * 0.3,
                  height: height * 0.05,
                  decoration: const BoxDecoration(
                    color: PRIMARY_COLOR,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '27 - 11 - 2024',
                      style: titleText,
                    ),
                  ),
                ),
                Container(
                  width: width * 0.3,
                  height: height * 0.05,
                  decoration: BoxDecoration(
                    color: (data == true)
                        ? COMPLEMENTARY_COLOR2
                        : Colors.grey.shade500,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(30),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      (data == true) ? "Approve" : "Menunggu",
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
                        flex: 4,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Kode Permintaan',
                                style: subtitleTextBlack,
                              ),
                            ),
                            SizedBox(
                              child: Text(' : ', style: subtitleTextBlack),
                            ),
                            Expanded(
                              child:
                                  Text('198289-AD', style: subtitleTextBlack),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SvgPicture.asset(
                              'assets/images/approve2.svg',
                              width: 30.w,
                              height: 20.h,
                            ),
                            SizedBox(
                              width: 10.h,
                            ),
                            (data == true)
                                ? SvgPicture.asset(
                                    'assets/images/approve3.svg',
                                    width: 20.w,
                                    height: 20.h,
                                  )
                                : SvgPicture.asset(
                                    'assets/images/approve1.svg',
                                    width: 20.w,
                                    height: 20.h,
                                  ),
                          ],
                        ),
                      ),
                    ],
                  )),
                  // Expanded(
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       Expanded(
                  //         flex: 2,
                  //         child: Text(
                  //           'Kode Permintaan',
                  //           style: subtitleTextBlack,
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         child: Text(
                  //           ' : ',
                  //           style: subtitleTextBlack,
                  //         ),
                  //       ),
                  //       Expanded(
                  //         flex: 2,
                  //         child: Text('2324253', style: subtitleTextBlack),
                  //       ),
                  //       SvgPicture.asset(
                  //         'assets/images/approve2.svg',
                  //         width: 20.w,
                  //         height: 20.h,
                  //       ),
                  //       SizedBox(
                  //         width: 5.w,
                  //       ),
                  //       (data == true)
                  //           ? SvgPicture.asset(
                  //               'assets/images/approve3.svg',
                  //               width: 20.w,
                  //               height: 20.h,
                  //             )
                  //           : SvgPicture.asset(
                  //               'assets/images/approve1.svg',
                  //               width: 20.w,
                  //               height: 20.h,
                  //             ),
                  //     ],
                  //   ),
                  // ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Divisi',
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
                            ' Lorem Ipsum adwadawdbadhbawudbadbaubdawu',
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
                            'Kategori',
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
                          child: Text('Bahan Baku', style: subtitleTextBlack),
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
                          child: Text('User 1', style: subtitleTextNormal),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10.h, left: 10.w, right: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: WidgetButtonCustom(
                      FullWidth: width * 0.3,
                      FullHeight: 30.h,
                      title: "Lihat Barang",
                      onpressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const ComponentDetailPermintaanBarang(),
                          ),
                        );
                      },
                      bgColor: PRIMARY_COLOR,
                      color: Colors.transparent),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
