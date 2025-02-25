import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/views/menus/component_produksi/produksi_c2h2/control/isi_pemakaian_hopper.dart';
import 'package:dwigasindo/views/menus/component_produksi/produksi_c2h2/control/tambah_control_compressor.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timeline_list/timeline_list.dart';

class DetailControlC2H2 extends StatefulWidget {
  DetailControlC2H2({super.key, required this.title});
  String title;

  @override
  State<DetailControlC2H2> createState() => _DetailControlC2H2State();
}

class _DetailControlC2H2State extends State<DetailControlC2H2> {
  final GroupButtonController _groupButtonController = GroupButtonController(
    selectedIndex: 0, // "Tanki" berada pada indeks 0
  );
  bool selectButton = true;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: WidgetAppbar(
        title: widget.title,
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
                  builder: (context) =>
                      TambahControlCompressor(title: widget.title),
                ),
              );
            },
            icon: const Icon(
              Icons.add_circle_outline_rounded,
              color: Colors.black,
            ),
          ),
        ],
        center: true,
        colorBack: Colors.black,
        colorTitle: Colors.black,
        colorBG: Colors.grey.shade100,
      ),
      body: Container(
        width: width,
        height: height,
        padding: EdgeInsets.only(top: 10.h, left: 15.w, right: 15.w),
        child: Column(
          children: [
            (widget.title == "Stok Bahan Baku")
                ? Align(
                    alignment: Alignment.center,
                    child: GroupButton(
                        isRadio: true,
                        enableDeselect: true,
                        options: GroupButtonOptions(
                            buttonWidth: 80.w,
                            selectedColor: PRIMARY_COLOR,
                            borderRadius: BorderRadius.circular(8),
                            elevation: 0),
                        onSelected: (value, index, isSelected) {
                          print('DATA KLIK : $value - $index - $isSelected');
                        },
                        buttons: ['Karbit', "DMF", "ACT"]),
                  )
                : (widget.title == "Pemakaian CaCl2")
                    ? Align(
                        alignment: Alignment.center,
                        child: GroupButton(
                            isRadio: true,
                            enableDeselect: true,
                            options: GroupButtonOptions(
                                buttonWidth: 80.w,
                                selectedColor: PRIMARY_COLOR,
                                borderRadius: BorderRadius.circular(8),
                                elevation: 0),
                            onSelected: (value, index, isSelected) {
                              print(
                                  'DATA KLIK : $value - $index - $isSelected');
                            },
                            buttons: ['CaCl2', "CaC2"]),
                      )
                    : SizedBox.shrink(),
            if (widget.title == 'Stok Bahan Baku' ||
                widget.title == "Pemakaian CaCl2")
              Divider(),
            SizedBox(
              width: width,
              height: 50.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: 'Stok Tersedia\n', style: subtitleTextBlack),
                        TextSpan(text: '1.0000\n', style: subtitleTextBlack),
                        TextSpan(text: 'MoU\n\n', style: minisubtitleTextBlack),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: 'Stok Keluar\n', style: subtitleTextBlack),
                        TextSpan(text: '500\n', style: subtitleTextBlack),
                        TextSpan(text: 'MoU\n\n', style: minisubtitleTextBlack),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: width,
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
                    ),
                  ),
                ],
              ),
            ),
            (widget.title == "Pemakaian CaCl2" ||
                    widget.title == "Stok Bahan Baku")
                ? Container(
                    width: width,
                    height: 50.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        WidgetButtonCustom(
                          FullWidth: 165.w,
                          FullHeight: 40.h,
                          title: "Kartu Stok",
                          onpressed: () {},
                          color: PRIMARY_COLOR,
                          bgColor: PRIMARY_COLOR,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        WidgetButtonCustom(
                          FullWidth: 165.w,
                          FullHeight: 40.h,
                          title: "Tambah",
                          onpressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => tambahPemakaian(
                                  title: widget.title,
                                ),
                              ),
                            );
                          },
                          color: PRIMARY_COLOR,
                          bgColor: PRIMARY_COLOR,
                        )
                      ],
                    ),
                  )
                : (widget.title == "Pemakaian Generator")
                    ? Align(
                        alignment: Alignment.center,
                        child: GroupButton(
                            isRadio: true,
                            controller: _groupButtonController,
                            options: GroupButtonOptions(
                                buttonWidth: 165.w,
                                buttonHeight: 50.h,
                                textAlign: TextAlign.center,
                                selectedColor: PRIMARY_COLOR,
                                borderRadius: BorderRadius.circular(8),
                                elevation: 0),
                            onSelected: (value, index, isSelected) {
                              print(
                                  'DATA KLIK : $value - $index - $isSelected');
                              setState(() {
                                selectButton = index !=
                                    1; // False jika "BB Lainnya" dipilih
                              });
                            },
                            buttons: [
                              'Pemakaian\nCalcium Carbidest',
                              "Control Air &\n Waktu Drain"
                            ]),
                      )
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: GroupButton(
                            isRadio: true,
                            enableDeselect: true,
                            options: GroupButtonOptions(
                                buttonWidth: 150.w,
                                buttonHeight: 50.h,
                                textAlign: TextAlign.center,
                                selectedColor: PRIMARY_COLOR,
                                borderRadius: BorderRadius.circular(8),
                                elevation: 0),
                            onSelected: (value, index, isSelected) {
                              print(
                                  'DATA KLIK : $value - $index - $isSelected');
                            },
                            buttons: ['List\nControl Compressor']),
                      ),
            SizedBox(
              height: 10.h,
            ),
            if (widget.title == "Pemakaian Generator")
              (selectButton == true)
                  ? Container(
                      width: width,
                      height: 40.h,
                      child: WidgetButtonCustom(
                        FullWidth: width,
                        FullHeight: 40.h,
                        title: "Isi Pemakaian Hopper",
                        onpressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => IsiPemakaianHopper(
                                title: widget.title,
                              ),
                            ),
                          );
                        },
                        color: PRIMARY_COLOR,
                        bgColor: PRIMARY_COLOR,
                      ),
                    )
                  : Container(
                      width: width,
                      height: 40.h,
                      child: WidgetButtonCustom(
                        FullWidth: width,
                        FullHeight: 40.h,
                        title: "Isi Waktu Drain",
                        onpressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => IsiWaktuDrain(
                                title: widget.title,
                              ),
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
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return (widget.title == "Stok Bahan Baku" ||
                          widget.title == "Pemakaian CaCl2")
                      ? cardStokPemakaian(width: width, height: height)
                      : (widget.title == "Control Compressor")
                          ? cardControl(
                              width: width,
                              height: 190.h,
                              data: [
                                {
                                  'shift': '1',
                                  'controlJam': '09:15',
                                  'pendingin': 'OK',
                                  'pelumas': 'OK'
                                },
                                {
                                  'shift': '2',
                                  'controlJam': '10:30',
                                  'pendingin': 'OK',
                                  'pelumas': 'OK'
                                },
                                {
                                  'shift': '3',
                                  'controlJam': '10:30',
                                  'pendingin': 'OK',
                                  'pelumas': 'OK'
                                },
                                // Tambahkan maksimal hingga 5 data
                              ],
                            )
                          : (selectButton == true)
                              ? CardPemakaianGenerator(
                                  width: width,
                                  height: 190.h,
                                )
                              : cardControlAir(width: width, height: height);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class cardControlAir extends StatelessWidget {
  cardControlAir({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;
  final List<Map<String, String>> data = [
    {'shift': '1', 'jam': '09:15'},
    {'shift': '1', 'jam': '11:15'},
    {'shift': '1', 'jam': '13:25'},
    {'shift': '2', 'jam': '15:05'},
    {'shift': '2', 'jam': '17:30'},
    {'shift': '2', 'jam': '15:05'},
    {'shift': '2', 'jam': '17:30'},
  ];

  @override
  Widget build(BuildContext context) {
    Map<String, List<Map<String, String>>> groupedData = {};
    for (var entry in data) {
      groupedData.putIfAbsent(entry['shift']!, () => []).add(entry);
    }

    return Container(
      width: width,
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 1),
            color: Colors.grey.shade400,
            blurRadius: 1,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header tanggal
          Container(
            width: 120.w,
            height: 40.h,
            decoration: const BoxDecoration(
              color: Color(0xFF1D2340),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Text(
                '27 - 11 - 2024',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),

          _buildTableHeader(),
          Column(
            children: groupedData.entries.map((entry) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Timeline.builder(
                      properties: TimelineProperties(
                        markerGap: 10.h,
                        iconGap: 0.h,
                        iconSize: 10.w,
                      ),
                      context: context,
                      markerCount: entry.value.length,
                      horizontalPadding: 10.w,
                      markerBuilder: (context, index) {
                        return _buildTimelineItem(entry.value[index]);
                      },
                    ),
                  ),
                  SizedBox(height: 5.h),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Center(
      child: Container(
        width: width,
        padding: EdgeInsets.only(left: 30.w, right: 15.w, top: 10.h),
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey.shade400))),
        child: Row(
          children: [
            _buildHeaderText('Shift'),
            _buildHeaderText('Jam'),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderText(String text) {
    return Expanded(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
          style: subtitleTextBoldBlack,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Marker _buildTimelineItem(Map<String, String> item) {
    return Marker(
      child: _buildRow(item),
    );
  }

  Widget _buildRow(Map<String, String> item) {
    return Container(
      width: 300.w,
      child: Row(
        children: [
          _buildCellText(item['shift'] ?? '-'),
          _buildCellText(item['jam'] ?? '-'),
        ],
      ),
    );
  }

  Widget _buildCellText(String text) {
    return Expanded(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
          style: subtitleTextBlack,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class CardPemakaianGenerator extends StatelessWidget {
  CardPemakaianGenerator({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;
  final List<Map<String, String>> data = [
    {'shift': '1', 'jam': '09:15-11:15', 'hopper': '1', 'jumlah': '2 Drum'},
    {'shift': '1', 'jam': '11:15-13:25', 'hopper': '2', 'jumlah': '2 Drum'},
    {'shift': '1', 'jam': '13:25-15:05', 'hopper': '1', 'jumlah': '2 Drum'},
    {'shift': '2', 'jam': '15:05-17:30', 'hopper': '2', 'jumlah': '3 Drum'},
    {'shift': '2', 'jam': '17:30-19:45', 'hopper': '1', 'jumlah': '2 Drum'},
    {'shift': '2', 'jam': '15:05-17:30', 'hopper': '2', 'jumlah': '3 Drum'},
    {'shift': '2', 'jam': '17:30-19:45', 'hopper': '1', 'jumlah': '2 Drum'},
  ];

  @override
  Widget build(BuildContext context) {
    Map<String, List<Map<String, String>>> groupedData = {};
    for (var entry in data) {
      groupedData.putIfAbsent(entry['shift']!, () => []).add(entry);
    }

    return Container(
      width: width,
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 1),
            color: Colors.grey.shade400,
            blurRadius: 1,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header tanggal
          Container(
            width: 120.w,
            height: 40.h,
            decoration: const BoxDecoration(
              color: Color(0xFF1D2340),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Text(
                '27 - 11 - 2024',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
          _buildTableHeader(),
          Column(
            children: groupedData.entries.map((entry) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Timeline.builder(
                      physics: NeverScrollableScrollPhysics(),
                      properties: TimelineProperties(
                        markerGap: 10.h,
                        iconGap: 0.h,
                        iconSize: 10.w,
                      ),
                      context: context,
                      markerCount: entry.value.length,
                      horizontalPadding: 10.w,
                      markerBuilder: (context, index) {
                        return _buildTimelineItem(entry.value[index]);
                      },
                    ),
                  ),
                  SizedBox(height: 5.h),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Center(
      child: Container(
        width: width,
        padding: EdgeInsets.only(left: 30.w, right: 15.w, top: 10.h),
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey.shade400))),
        child: Row(
          children: [
            _buildHeaderText('Shift'),
            _buildHeaderText('Jam'),
            _buildHeaderText('Hopper'),
            _buildHeaderText('Jumlah'),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderText(String text) {
    return Expanded(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
          style: subtitleTextBoldBlack,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Marker _buildTimelineItem(Map<String, String> item) {
    return Marker(
      child: _buildRow(item),
    );
  }

  Widget _buildRow(Map<String, String> item) {
    return Container(
      width: 300.w,
      child: Row(
        children: [
          _buildCellText(item['shift'] ?? '-'),
          _buildCellText(item['jam'] ?? '-'),
          _buildCellText(item['hopper'] ?? '-'),
          _buildCellText(item['jumlah'] ?? '-'),
        ],
      ),
    );
  }

  Widget _buildCellText(String text) {
    return Expanded(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
          style: subtitleTextBlack,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

// class cardRed extends StatelessWidget {
//   const cardRed({
//     super.key,
//     required this.width,
//     required this.height,
//   });

//   final double width;
//   final double height;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: width,
//       height: 140.h,
//       margin: EdgeInsets.only(bottom: 10.h),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//               offset: const Offset(0, 1),
//               color: Colors.grey.shade400,
//               blurRadius: 1)
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             padding: EdgeInsets.only(right: 10.w),
//             width: width,
//             height: 40.h,
//             child: Row(
//               children: [
//                 Container(
//                   width: width * 0.4,
//                   height: 40.h,
//                   decoration: const BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(8),
//                         bottomRight: Radius.circular(20)),
//                     color: PRIMARY_COLOR,
//                   ),
//                   child: Center(
//                     child: FittedBox(
//                       alignment: Alignment.center,
//                       fit: BoxFit.scaleDown,
//                       child: Text(
//                         '27 - 11 - 2024 | 10:00',
//                         style: subtitleText,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: FittedBox(
//                     alignment: Alignment.centerRight,
//                     fit: BoxFit.scaleDown,
//                     child: Text(
//                       'Kode Produksi : D1231231321',
//                       style: subtitleTextBlack,
//                       textAlign: TextAlign.right,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 3,
//             child: Container(
//               padding: EdgeInsets.symmetric(
//                 horizontal: 10.w,
//               ),
//               decoration: BoxDecoration(
//                   border: Border(top: BorderSide(color: Colors.grey.shade300))),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     width: 210.w,
//                     decoration: const BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(8),
//                       ),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                             width: 100.w,
//                             height: 25.h,
//                             child: FittedBox(
//                                 alignment: Alignment.centerLeft,
//                                 fit: BoxFit.scaleDown,
//                                 child: Text('Oxygen',
//                                     style: superTitleTextBlack))),
//                         SizedBox(
//                           width: 200.w,
//                           height: 15.h,
//                           child: Text('PT. Dwigasindo Abadi',
//                               style: subtitleTextBlack),
//                         ),
//                         SizedBox(
//                             width: 220.w,
//                             height: 16.h,
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: Text('Nomor PO',
//                                       style: subtitleTextNormalblack),
//                                 ),
//                                 Text(
//                                   " : ",
//                                   style: subtitleTextNormalblack,
//                                 ),
//                                 Expanded(
//                                   flex: 2,
//                                   child: Text('T12398192',
//                                       style: subtitleTextNormalblack),
//                                 ),
//                               ],
//                             )),
//                         SizedBox(
//                             width: 220.w,
//                             height: 16.h,
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: Text('Rak',
//                                       style: subtitleTextNormalblack),
//                                 ),
//                                 Text(
//                                   " : ",
//                                   style: subtitleTextNormalblack,
//                                 ),
//                                 Expanded(
//                                   flex: 2,
//                                   child:
//                                       Text('2', style: subtitleTextNormalblack),
//                                 ),
//                               ],
//                             )),
//                         SizedBox(
//                             width: 220.w,
//                             height: 16.h,
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: Text('Jumlah',
//                                       style: subtitleTextNormalblack),
//                                 ),
//                                 Text(
//                                   " : ",
//                                   style: subtitleTextNormalblack,
//                                 ),
//                                 Expanded(
//                                   flex: 2,
//                                   child: Text('200',
//                                       style: subtitleTextNormalblack),
//                                 ),
//                               ],
//                             )),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     decoration: const BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                         bottomRight: Radius.circular(8),
//                       ),
//                     ),
//                     child: Container(
//                       width: width * 0.3,
//                       height: height * 0.1,
//                       decoration: BoxDecoration(
//                         color: SECONDARY_COLOR,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Center(
//                         child: RichText(
//                           text: TextSpan(
//                             children: [
//                               TextSpan(
//                                 text: 'Stok Tersedia\n',
//                                 style: minisubtitleText,
//                               ),
//                               TextSpan(
//                                   text: '500\n', style: superTitleTextWhite),
//                               TextSpan(
//                                 text: 'MoU',
//                                 style: minisubtitleText,
//                               ),
//                             ],
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class cardStokPemakaian extends StatelessWidget {
  const cardStokPemakaian({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 125.h,
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 1),
              color: Colors.grey.shade400,
              blurRadius: 1)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width,
            height: 40.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: width * 0.4,
                  height: 40.h,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomRight: Radius.circular(20)),
                    color: PRIMARY_COLOR,
                  ),
                  child: Center(
                    child: FittedBox(
                      alignment: Alignment.center,
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '27 - 11 - 2024 | 10:00',
                        style: subtitleText,
                      ),
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
                horizontal: 10.w,
              ),
              decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey.shade300))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 210.w,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 100.w,
                          height: 25.h,
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: Text('Karbit', style: superTitleTextBlack),
                          ),
                        ),
                        SizedBox(
                          width: 200.w,
                          height: 15.h,
                          child: Text('PT. Dwigasindo Abadi',
                              style: subtitleTextBlack),
                        ),
                        SizedBox(
                            width: 220.w,
                            height: 16.h,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text('Nomor PO',
                                      style: subtitleTextNormalblack),
                                ),
                                Text(
                                  " : ",
                                  style: subtitleTextNormalblack,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text('T12398192',
                                      style: subtitleTextNormalblack),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Container(
                      width: 90.h,
                      height: 70.h,
                      decoration: BoxDecoration(
                        color: SECONDARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Stok Keluar\n',
                                style: minisubtitleText,
                              ),
                              TextSpan(
                                  text: '500\n', style: superTitleTextWhite),
                              TextSpan(
                                text: 'Drum',
                                style: minisubtitleText,
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class cardControl extends StatelessWidget {
  const cardControl({
    super.key,
    required this.width,
    required this.height,
    required this.data, // Tambahkan parameter data
  });

  final double width;
  final double height;
  final List<Map<String, String>> data; // Data dinamis dalam bentuk list

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: data.length * height,
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 1),
            color: Colors.grey.shade400,
            blurRadius: 1,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120.w,
            height: 40.h,
            decoration: const BoxDecoration(
              color: Color(0xFF1D2340),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Text('27 - 11 - 2024', style: titleText),
            ),
          ),
          Expanded(
            // Gunakan Expanded untuk mencegah overflow
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: data.length.clamp(1, 5), // Minimal 1, maksimal 5
              itemBuilder: (context, index) {
                final item = data[index];
                return Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildRow('Shift', 'Control Jam', 'Sirkulasi Pendingin',
                          'Oil Pelumas'),
                      _buildRow(
                        item['shift'] ?? '-',
                        item['controlJam'] ?? '-',
                        item['pendingin'] ?? '-',
                        item['pelumas'] ?? '-',
                      ),
                      _buildRow('', 'Pressure', 'Drain', 'Safety Valve'),
                      _buildRow('Stage 1', item['pendingin'] ?? '-',
                          item['pendingin'] ?? '-', item['pendingin'] ?? '-'),
                      _buildRow('Stage 2', item['pendingin'] ?? '-',
                          item['pendingin'] ?? '-', item['pendingin'] ?? '-'),
                      _buildRow('Stage 3', item['pendingin'] ?? '-',
                          item['pendingin'] ?? '-', item['pendingin'] ?? '-'),
                      if (index < data.length - 1)
                        Divider(color: Colors.grey.shade300),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String first, String second, String third, String fourth) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCellTitle(first, TextAlign.left),
          _buildCellTitle(second, TextAlign.center),
          _buildCellTitle(third, TextAlign.center),
          _buildCellTitle(fourth, TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildCellTitle(
    String text,
    TextAlign align,
  ) {
    return SizedBox(
      width: 70.w,
      child: Text(
        text,
        style: subtitleTextBoldBlack,
        textAlign: align,
      ),
    );
  }
}

class tambahPemakaian extends StatefulWidget {
  tambahPemakaian({super.key, this.uuid, required this.title});
  String? uuid;
  String title;
  @override
  State<tambahPemakaian> createState() => _tambahPemakaianState();
}

class _tambahPemakaianState extends State<tambahPemakaian> {
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take a Photo'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  TextEditingController kode = TextEditingController();
  TextEditingController keterangan = TextEditingController();

  SingleSelectController<String?> kategori =
      SingleSelectController<String?>(null);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    // final provider = Provider.of<ProviderItem>(context);

    // final categories = provider.allcategory?.data
    //     .map((data) => {'id': data.id, 'name': data.name})
    //     .toList();

    // final locations = provider.location?.data
    //     .map((data) => {'id': data.id, 'name': data.name})
    //     .toList();

    // final units = provider.units?.data
    //     .map((data) => {'id': data.id, 'name': data.name})
    //     .toList();

    // final vendorData = provider.supplier?.data
    //     .map((data) => {'id': data.id, 'name': data.name})
    //     .toList();

    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Tambah Item',
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
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              (widget.title == "Stok Bahan Baku")
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 10.h),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: GroupButton(
                            isRadio: true,
                            enableDeselect: true,
                            options: GroupButtonOptions(
                                buttonWidth: 80.w,
                                selectedColor: PRIMARY_COLOR,
                                borderRadius: BorderRadius.circular(8),
                                elevation: 0),
                            onSelected: (value, index, isSelected) {
                              print(
                                  'DATA KLIK : $value - $index - $isSelected');
                            },
                            buttons: ['Karbit', "DMF", "ACT"]),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 10.h),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: GroupButton(
                            isRadio: true,
                            enableDeselect: true,
                            options: GroupButtonOptions(
                                buttonWidth: 80.w,
                                selectedColor: PRIMARY_COLOR,
                                borderRadius: BorderRadius.circular(8),
                                elevation: 0),
                            onSelected: (value, index, isSelected) {
                              print(
                                  'DATA KLIK : $value - $index - $isSelected');
                            },
                            buttons: ['CaCl2', "CaC2"]),
                      ),
                    ),
              // Container(
              //   width: width,
              //   height: 80.h,
              //   child: ListTile(
              //     title: Container(
              //       margin: EdgeInsets.only(bottom: 8.h),
              //       child: Text(
              //         'Kategori',
              //         style: subtitleTextBlack,
              //       ),
              //     ),
              //     subtitle: CustomDropdown(
              //       items: ['a', 'b'],
              //       hintText: 'Unit',
              //       controller: kategori,
              //       onChanged: (value) {
              //         print(value);
              //       },
              //     ),
              //   ),
              // ),
              SizedBox(
                height: height * 0.005,
              ),
              Container(
                width: width,
                height: height * 0.1,
                child: ListTile(
                  title: Text(
                    'Jumlah',
                    style: subtitleTextBlack,
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: WidgetForm(
                      controller: kode,
                      alert: 'Jumlah Bahan Baku',
                      hint: 'Jumlah Bahan Baku',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ),
              // Container(
              //   width: width,
              //   height: 80.h,
              //   child: Align(
              //     alignment: Alignment.center,
              //     child: GestureDetector(
              //       onTap:
              //           _showImageSourceDialog, // Panggil fungsi saat button diklik
              //       child: SizedBox(
              //         width: width,
              //         height: height * 0.1,
              //         child: ListTile(
              //           title: Text(
              //             'Upload Image',
              //             style: subtitleTextBlack,
              //           ),
              //           subtitle: Container(
              //             height: 100.h,
              //             margin: EdgeInsets.only(top: height * 0.01),
              //             decoration: BoxDecoration(
              //               border: Border.all(color: Colors.grey.shade400),
              //               borderRadius: BorderRadius.circular(12),
              //             ),
              //             child: _imageFile != null
              //                 ? Image.file(
              //                     _imageFile!,
              //                     width: 50,
              //                     height: 50,
              //                     fit: BoxFit.fitHeight,
              //                   )
              //                 : Padding(
              //                     padding: EdgeInsets.all(10.h),
              //                     child: SvgPicture.asset(
              //                         'assets/images/gambar.svg'),
              //                   ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: height * 0.03,
              // ),
              // Container(
              //   width: width,
              //   height: height * 0.1,
              //   child: ListTile(
              //     title: Text(
              //       'Keterangan',
              //       style: subtitleTextBlack,
              //     ),
              //     subtitle: Container(
              //       margin: EdgeInsets.only(top: height * 0.01),
              //       child: WidgetForm(
              //         controller: keterangan,
              //         typeInput: TextInputType.number,
              //         alert: 'Keterangan',
              //         hint: 'Keterangan',
              //         border: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(12)),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 30.h,
              // ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: width,
        height: height * 0.06,
        margin: EdgeInsets.only(bottom: 10.h),
        child: ListTile(
          subtitle: WidgetButtonCustom(
              FullWidth: 340.w,
              FullHeight: 40.h,
              title: 'Submit',
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
                    // provider.createItem(
                    //     context,
                    //     kode.text,
                    //     nama.text,
                    //     selectKategori!,
                    //     selectLokasi!,
                    //     selectUnit!,
                    //     int.parse(stok.text),
                    //     int.parse(harga.text),
                    //     int.parse(limit.text),
                    //     selectVendor!,
                    //     1),
                  ]);

                  // Navigate sesuai kondisi
                  Navigator.pop(context); // Tutup Dialog Loading
                  Navigator.pop(context);
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
