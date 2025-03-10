import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/providers/provider_scan.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ComponentDetailSuratJalan extends StatefulWidget {
  ComponentDetailSuratJalan({
    super.key,
  });
  @override
  State<ComponentDetailSuratJalan> createState() =>
      _ComponentDetailSuratJalanState();
}

class _ComponentDetailSuratJalanState extends State<ComponentDetailSuratJalan> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderDistribusi>(context);
    final providerS = Provider.of<ProviderScan>(context);
    final data = provider.detailSuratJalan?.data;

    return PopScope(
      onPopInvoked: (didPop) async {
        await provider.clearCount('countT');
      },
      child: Scaffold(
        appBar: WidgetAppbar(
          title: 'Detail',
          colorBG: Colors.grey.shade100,
          center: true,
          sizefont: 20,
          colorBack: Colors.black,
          colorTitle: Colors.black,
          back: true,
          route: () async {
            await provider.clearCount('countT');
            Navigator.pop(context);
          },
        ),
        body: (provider.isLoadingVer == true)
            ? Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: const CircularProgressIndicator(),
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      width: width,
                      height: 120.h,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      decoration: BoxDecoration(
                        color: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(),
                          SizedBox(
                            height: 24.h,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                '${data?.sjNo}',
                                style: titleText,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'No Order',
                                          style: subtitleTextNormalwhite,
                                        ),
                                      ),
                                      Text(
                                        ' : ',
                                        style: subtitleTextNormalwhite,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          '\t${data?.orderNo}',
                                          style: subtitleTextNormalwhite,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Driver',
                                          style: subtitleTextNormalwhite,
                                        ),
                                      ),
                                      Text(
                                        ':',
                                        style: subtitleTextNormalwhite,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          '\t${data!.driverName}',
                                          overflow: TextOverflow.ellipsis,
                                          style: subtitleTextNormalwhite,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Plat No',
                                          style: subtitleTextNormalwhite,
                                        ),
                                      ),
                                      Text(
                                        ' : ',
                                        style: titleTextNormalWhite,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          '\t${data.driverVehicleNumber}',
                                          style: subtitleTextNormalwhite,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Pada',
                                          style: subtitleTextNormalwhite,
                                        ),
                                      ),
                                      Text(
                                        ' : ',
                                        style: subtitleTextNormalwhite,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          provider.formatDate(
                                              data.createdAt.toString()),
                                          overflow: TextOverflow.ellipsis,
                                          style: subtitleTextNormalwhite,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    WidgetCard(height: height, width: width),
                  ],
                ),
              ),
      ),
    );
  }
}

class WidgetCard extends StatefulWidget {
  WidgetCard({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  _WidgetCardState createState() => _WidgetCardState();
}

class _WidgetCardState extends State<WidgetCard> {
  Map<int, bool> isExpanded = {};

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderDistribusi>(context);
    final data = provider.detailSuratJalan?.data;

    return Expanded(
      child: ListView.builder(
        itemCount: data!.details?.length ?? 0,
        itemBuilder: (context, index) {
          final details = data.details?[index];
          final expanded = isExpanded[index] ?? false;
          final itemCount = details?.items?.length ?? 0;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: double.maxFinite,
            height: expanded ? 150.h + (itemCount * 40.0) : 120.h,
            margin: EdgeInsets.only(bottom: widget.height * 0.01),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  color: Colors.grey.shade300,
                  offset: const Offset(0, 2),
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
                        width: widget.width * 0.3,
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: PRIMARY_COLOR,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '${details?.bptiNo}',
                            style: titleText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(8)),
                      border: Border.fromBorderSide(
                        BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                'Driver',
                                style: subtitleTextBlack,
                              ),
                            ),
                            Text(
                              " : ",
                              style: subtitleTextBlack,
                            ),
                            Expanded(
                              flex: 3,
                              child: Text('${data?.driverName ?? "-"}',
                                  overflow: TextOverflow.ellipsis,
                                  style: subtitleTextBlack),
                            ),
                          ],
                        ),
                        Divider(),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isExpanded[index] = !(isExpanded[index] ?? false);
                            });
                          },
                          child: Expanded(
                            child: Icon(
                              expanded
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              size: 24.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        if (expanded)
                          ...details!.items!.map((item) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 4.0.h, horizontal: 8.0.w),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.all(10.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Item No: ${item.no}',
                                        style: subtitleTextBlack.copyWith(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        '${item.tubeGasName}', // Sesuaikan dengan atribut item yang ingin ditampilkan
                                        style: subtitleTextBlack,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ComponentDetailSuratJalanItem extends StatefulWidget {
  ComponentDetailSuratJalanItem({
    super.key,
  });
  @override
  State<ComponentDetailSuratJalanItem> createState() =>
      _ComponentDetailSuratJalanItemState();
}

class _ComponentDetailSuratJalanItemState
    extends State<ComponentDetailSuratJalanItem> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderDistribusi>(context);
    final providerS = Provider.of<ProviderScan>(context);
    final data = provider.suratJalanItem?.data;

    return PopScope(
      onPopInvoked: (didPop) async {
        await provider.clearCount('countT');
      },
      child: Scaffold(
        appBar: WidgetAppbar(
          title: 'Detail Surat Jalan Item',
          colorBG: Colors.grey.shade100,
          center: true,
          sizefont: 20,
          colorBack: Colors.black,
          colorTitle: Colors.black,
          back: true,
          route: () async {
            await provider.clearCount('countT');
            Navigator.pop(context);
          },
        ),
        body: (provider.isLoadingVer == true)
            ? Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: const CircularProgressIndicator(),
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      width: width,
                      height: 120.h,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      decoration: BoxDecoration(
                        color: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(),
                          SizedBox(
                            height: 24.h,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                '${data?.no}',
                                style: titleText,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Total\nItem Order',
                                          style: subtitleTextNormalwhite,
                                        ),
                                      ),
                                      Text(
                                        ' : ',
                                        style: subtitleTextNormalwhite,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          '\t${data!.details?.length}',
                                          style: subtitleTextNormalwhite,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Driver',
                                          style: subtitleTextNormalwhite,
                                        ),
                                      ),
                                      Text(
                                        ':',
                                        style: subtitleTextNormalwhite,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          '\t${data.driverName ?? data.nonUserName}',
                                          overflow: TextOverflow.ellipsis,
                                          style: subtitleTextNormalwhite,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Plat No',
                                          style: subtitleTextNormalwhite,
                                        ),
                                      ),
                                      Text(
                                        ' : ',
                                        style: titleTextNormalWhite,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          '\t${data.vehicleNumber}',
                                          style: subtitleTextNormalwhite,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Type',
                                          style: subtitleTextNormalwhite,
                                        ),
                                      ),
                                      Text(
                                        ':',
                                        style: subtitleTextNormalwhite,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          '\t${(data.type == 0) ? "Non User" : "User"}',
                                          style: subtitleTextNormalwhite,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    WidgetCardItem(height: height, width: width),
                  ],
                ),
              ),
      ),
    );
  }
}

class WidgetCardItem extends StatefulWidget {
  WidgetCardItem({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  _WidgetCardItemState createState() => _WidgetCardItemState();
}

class _WidgetCardItemState extends State<WidgetCardItem> {
  Map<int, bool> isExpanded = {};

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderDistribusi>(context);
    final data = provider.suratJalanItem?.data;

    return Expanded(
      child: ListView.builder(
        itemCount: data!.details?.length ?? 0,
        itemBuilder: (context, index) {
          final details = data.details?[index];
          final expanded = isExpanded[index] ?? false;
          final itemCount = data.details?.length ?? 0;

          // Mencari order yang sesuai dengan orderId dari details
          final order = data.orders?.firstWhere(
            (o) => o.id == details?.orderId,
          );

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: double.maxFinite,
            height: expanded ? 250.h + (itemCount * 40.0) : 120.h,
            margin: EdgeInsets.only(bottom: widget.height * 0.01),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  color: Colors.grey.shade300,
                  offset: const Offset(0, 2),
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
                        width: widget.width * 0.3,
                        height: 40.h,
                        decoration: const BoxDecoration(
                          color: PRIMARY_COLOR,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            order?.code ?? "-", // Menampilkan nomor order final
                            style: subtitleText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(8)),
                      border: Border.fromBorderSide(
                        BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 15.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text('Driver', style: subtitleTextBlack),
                            ),
                            Text(" : ", style: subtitleTextBlack),
                            Expanded(
                              flex: 3,
                              child: Text(
                                  '${data.driverName ?? data.nonUserName}',
                                  overflow: TextOverflow.ellipsis,
                                  style: subtitleTextBlack),
                            ),
                          ],
                        ),
                        Divider(),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isExpanded[index] = !(isExpanded[index] ?? false);
                            });
                          },
                          child: Icon(
                            expanded
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            size: 24.0,
                            color: Colors.black,
                          ),
                        ),
                        if (expanded)
                          Container(
                            width: double.maxFinite,
                            height: 20.h,
                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Text(
                              "Detail Item : ",
                              style: subtitleTextBlack,
                            ),
                          ),
                        if (expanded)
                          ...data.details!.map((item) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 4.0.h, horizontal: 8.0.w),
                              child: Container(
                                height: 60.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.all(10.w),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: Text(
                                              'Item No: ${item.itemName}',
                                              style: subtitleTextBlack.copyWith(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              'Qty : ${item.qty}',
                                              style: subtitleTextBlack,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              'Note: ${item.string}',
                                              overflow: TextOverflow.ellipsis,
                                              style: subtitleTextBlack.copyWith(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
