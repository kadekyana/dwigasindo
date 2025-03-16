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
