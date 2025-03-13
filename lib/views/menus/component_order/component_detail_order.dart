import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_sales.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:latlong2/latlong.dart' as CircularStrokeCap;
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class ComponentDetailOrder extends StatefulWidget {
  const ComponentDetailOrder({
    super.key,
  });

  @override
  State<ComponentDetailOrder> createState() => _ComponentDetailOrderState();
}

class _ComponentDetailOrderState extends State<ComponentDetailOrder> {
  final GroupButtonController _groupButtonController = GroupButtonController(
    selectedIndex: 0, // "Tanki" berada pada indeks 0
  );
  bool selectButton = true;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<ProviderSales>(context);
    final data = provider.detailOrder?.data;
    return Scaffold(
      appBar: WidgetAppbar(
        title: data?.code ?? '',
        back: true,
        route: () {
          Navigator.pop(context);
        },
        colorBG: Colors.grey.shade100,
        colorBack: Colors.black,
        colorTitle: Colors.black,
        center: true,
      ),
      body: Container(
        width: width,
        height: height,
        padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
        child: Column(
          children: [
            if (data!.items!.isNotEmpty)
              Expanded(
                child: Container(
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: width,
                        height: 30.h,
                        child: Center(
                            child: Text("List Item", style: titleTextBlack)),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: ListView.builder(
                            itemCount: data.items?.length,
                            itemBuilder: (context, index) {
                              final dataItem = data.items?[index];
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
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              width: 120.w,
                                              height: double.infinity,
                                              decoration: const BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(8),
                                                  bottomRight:
                                                      Radius.circular(30),
                                                ),
                                              ),
                                              alignment: Alignment.center,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Text("Item",
                                                  style: titleText),
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
                                            Expanded(
                                              flex: 2,
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 2,
                                                          child: FittedBox(
                                                            fit: BoxFit
                                                                .scaleDown,
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                                'Nama Item',
                                                                style:
                                                                    subtitleTextNormalblack),
                                                          ),
                                                        ),
                                                        const Text(':'),
                                                        Expanded(
                                                          flex: 3,
                                                          child: Text(
                                                            '\t${dataItem?.itemName ?? "-"}', // Default "-"
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                subtitleTextNormalblack,
                                                          ),
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
                                                            fit: BoxFit
                                                                .scaleDown,
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                                'Quantity',
                                                                style:
                                                                    subtitleTextNormalblack),
                                                          ),
                                                        ),
                                                        const Text(':'),
                                                        Expanded(
                                                          flex: 3,
                                                          child: Text(
                                                            '\t${(dataItem?.qty == null) ? "-" : dataItem?.qty}',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                subtitleTextNormalblack,
                                                          ),
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
                                                            fit: BoxFit
                                                                .scaleDown,
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                                'Catatan',
                                                                style:
                                                                    subtitleTextNormalblack),
                                                          ),
                                                        ),
                                                        const Text(':'),
                                                        Expanded(
                                                          flex: 3,
                                                          child: Text(
                                                            '\t${dataItem?.note ?? "-"}',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                subtitleTextNormalblack,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child:
                                                        CircularPercentIndicator(
                                                      radius: 40.w,
                                                      lineWidth: 5,
                                                      percent: (dataItem
                                                                  ?.remainigQty ==
                                                              0)
                                                          ? 1.0
                                                          : (dataItem!.remainigQty! >
                                                                  0
                                                              ? dataItem
                                                                      .remainigQty! /
                                                                  (dataItem
                                                                      .qty!)
                                                              : 0),
                                                      center: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            dataItem!.remainigQty! >
                                                                    0
                                                                ? "${dataItem.remainigQty}"
                                                                : "Kosong",
                                                            style:
                                                                minisubtitleTextBlack,
                                                          ),
                                                          Text("Lagi",
                                                              style:
                                                                  minisubtitleTextGrey),
                                                        ],
                                                      ),
                                                      backgroundColor:
                                                          Colors.grey.shade300,
                                                      progressColor:
                                                          PRIMARY_COLOR,
                                                    ),
                                                  ),
                                                  SizedBox(height: 3.h),
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
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(height: 10.h),
            if (data.products!.isNotEmpty)
              Expanded(
                child: Container(
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: width,
                        height: 30.h,
                        child: Center(
                            child:
                                Text("List Jasa / Gas", style: titleTextBlack)),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: ListView.builder(
                            itemCount: data.products?.length,
                            itemBuilder: (context, index) {
                              final dataItem = data.products?[index];
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
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              width: 120.w,
                                              height: double.infinity,
                                              decoration: const BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(8),
                                                  bottomRight:
                                                      Radius.circular(30),
                                                ),
                                              ),
                                              alignment: Alignment.center,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Text(
                                                  (dataItem?.gradeName == null)
                                                      ? "Jasa"
                                                      : "Gas",
                                                  style: titleText),
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
                                            Expanded(
                                              flex: 2,
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 2,
                                                          child: FittedBox(
                                                            fit: BoxFit
                                                                .scaleDown,
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text('Nama',
                                                                style:
                                                                    subtitleTextNormalblack),
                                                          ),
                                                        ),
                                                        const Text(':'),
                                                        Expanded(
                                                          flex: 3,
                                                          child: Text(
                                                            '\t${dataItem?.productName ?? "-"}', // Default "-"
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                subtitleTextNormalblack,
                                                          ),
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
                                                            fit: BoxFit
                                                                .scaleDown,
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                                'Quantity',
                                                                style:
                                                                    subtitleTextNormalblack),
                                                          ),
                                                        ),
                                                        const Text(':'),
                                                        Expanded(
                                                          flex: 3,
                                                          child: Text(
                                                            '\t${(dataItem?.qty == null) ? "-" : dataItem?.qty}',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                subtitleTextNormalblack,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  if (dataItem?.gradeName !=
                                                      null)
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 2,
                                                            child: FittedBox(
                                                              fit: BoxFit
                                                                  .scaleDown,
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                  'Grade',
                                                                  style:
                                                                      subtitleTextNormalblack),
                                                            ),
                                                          ),
                                                          const Text(':'),
                                                          Expanded(
                                                            flex: 3,
                                                            child: Text(
                                                              '\t${(dataItem?.gradeName == null) ? "-" : dataItem?.gradeName}',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style:
                                                                  subtitleTextNormalblack,
                                                            ),
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
                                                            fit: BoxFit
                                                                .scaleDown,
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                                'Catatan',
                                                                style:
                                                                    subtitleTextNormalblack),
                                                          ),
                                                        ),
                                                        const Text(':'),
                                                        Expanded(
                                                          flex: 3,
                                                          child: Text(
                                                            '\t${dataItem?.note ?? "-"}',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                subtitleTextNormalblack,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child:
                                                        CircularPercentIndicator(
                                                      radius: 40.w,
                                                      lineWidth: 5,
                                                      percent: (dataItem
                                                                  ?.remainigQty ==
                                                              0)
                                                          ? 1.0
                                                          : (dataItem!.remainigQty! >
                                                                  0
                                                              ? dataItem
                                                                      .remainigQty! /
                                                                  (dataItem
                                                                      .qty!)
                                                              : 0),
                                                      center: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            dataItem!.remainigQty! >
                                                                    0
                                                                ? "${dataItem.remainigQty}"
                                                                : "Kosong",
                                                            style:
                                                                minisubtitleTextBlack,
                                                          ),
                                                          Text("Lagi",
                                                              style:
                                                                  minisubtitleTextGrey),
                                                        ],
                                                      ),
                                                      backgroundColor:
                                                          Colors.grey.shade300,
                                                      progressColor:
                                                          PRIMARY_COLOR,
                                                    ),
                                                  ),
                                                  SizedBox(height: 3.h),
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
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}

class CardCatatan extends StatefulWidget {
  const CardCatatan({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  _CardCatatanState createState() => _CardCatatanState();
}

class _CardCatatanState extends State<CardCatatan> {
  bool isExpanded = false;

  final List<Map<String, String>> data = [
    {
      'tanggal': '12 - 11 - 2024',
      'jam': '13:00',
      'oleh': 'User 1',
      'info':
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s."
    },
    {
      'tanggal': '12 - 11 - 2024',
      'jam': '14:30',
      'oleh': 'User 2',
      'info': 'Pengisian gas selesai'
    },
    {
      'tanggal': '12 - 11 - 2024',
      'jam': '16:45',
      'oleh': 'User 3',
      'info': 'Pengecekan kualitas dilakukan'
    },
    {
      'tanggal': '12 - 11 - 2024',
      'jam': '18:20',
      'oleh': 'User 4',
      'info': 'Sampel gas diambil untuk uji coba'
    },
    {
      'tanggal': '12 - 11 - 2024',
      'jam': '19:55',
      'oleh': 'User 5',
      'info': 'Pengepakan tabung selesai'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      margin: const EdgeInsets.only(bottom: 10),
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
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFF1D2340),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(
              'Timeline Produksi',
              style: titleText,
              textAlign: TextAlign.center,
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: isExpanded ? data.length : 1,
              itemBuilder: (context, index) {
                return _buildListItem(data[index]);
              },
            ),
          ),
          Center(
            child: TextButton.icon(
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              icon: Icon(
                isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
              ),
              label: Text(isExpanded ? 'Tutup' : 'Lihat Semua'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(Map<String, String> item) {
    return Container(
      width: 270.w,
      padding: const EdgeInsets.all(12),
      margin: EdgeInsets.only(left: 8.w, right: 8.w, bottom: 8.h, top: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${item['tanggal']} | ${item['jam']}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Oleh: ${item['oleh']}',
            style: subtitleTextNormal,
          ),
          SizedBox(height: 4.h),
          Text(
            item['info']!,
            textAlign: TextAlign.justify,
            style: subtitleTextNormalblack,
          ),
        ],
      ),
    );
  }
}
