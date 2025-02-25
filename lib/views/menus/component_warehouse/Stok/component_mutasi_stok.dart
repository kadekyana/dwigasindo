import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../providers/provider_item.dart';

class ComponentMutasiStok extends StatefulWidget {
  final String vendor;
  final String nama;
  final String stokAda;
  final String StokTakada;

  const ComponentMutasiStok(
      {super.key,
      required this.vendor,
      required this.nama,
      required this.stokAda,
      required this.StokTakada});
  @override
  _ComponentMutasiStokState createState() => _ComponentMutasiStokState();
}

class _ComponentMutasiStokState extends State<ComponentMutasiStok> {
  // Data untuk grafik spline
  int StokKeluar = 0;
  List<_ChartData> data = [
    _ChartData(1, 100),
    _ChartData(2, 300),
    _ChartData(3, 600),
    _ChartData(4, 1000),
    _ChartData(5, 2000),
    _ChartData(6, 2000),
    _ChartData(7, 2000),
    _ChartData(8, 2000),
    _ChartData(9, 2200),
    _ChartData(10, 2300),
    _ChartData(11, 2500),
    _ChartData(12, 1500),
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderItem>(context);
    final dataMutasi = provider.mutasi;
    return Scaffold(
      appBar: AppBar(title: Text('Data Lengkap')),
      body: Container(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Column(
          children: [
            Container(
              width: width,
              height: height * 0.1,
              padding: EdgeInsets.symmetric(horizontal: width * 0.02),
              decoration: BoxDecoration(
                color: PRIMARY_COLOR,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Nama Item : ${widget.nama}',
                                style: subtitleText,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: FittedBox(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Stok Tersedia : ${widget.stokAda}',
                                style: subtitleText,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Vendor \t\t\t\t\t\t\t\t: ${widget.vendor}',
                                style: subtitleText,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: FittedBox(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Stok Terpakai : ${StokKeluar} ',
                                style: subtitleText,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SfCartesianChart(
                legend: Legend(isVisible: true),
                primaryXAxis: NumericAxis(
                  title: AxisTitle(text: 'Bulan'),
                ),
                primaryYAxis: NumericAxis(
                  title: AxisTitle(text: 'Stok'),
                ),
                series: <CartesianSeries<dynamic, dynamic>>[
                  SplineSeries<_ChartData, double>(
                    dataSource: data,
                    xValueMapper: (_ChartData sales, _) => sales.month,
                    yValueMapper: (_ChartData sales, _) => sales.sales,
                    markerSettings: MarkerSettings(isVisible: true),
                    name: 'Item',
                  ),
                ],
              ),
            ),
            Container(
              width: width,
              height: height * 0.05,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'List Mutasi',
                    style: titleTextBlack,
                  ),
                  Container(
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
                ],
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Expanded(
              flex: 2,
              child: (dataMutasi?.data.length == 0)
                  ? const Center(
                      child: Text('Belum Terdapat Data Mutasi'),
                    )
                  : ListView.builder(
                      itemCount: dataMutasi?.data.length,
                      itemBuilder: (context, index) {
                        final data = dataMutasi?.data[index];
                        if (data?.datumOperator == "-") {
                          StokKeluar = (StokKeluar + data!.quantity);
                        }
                        return (data?.datumOperator == "+")
                            ? CardMasuk(
                                width: width,
                                height: height,
                                data: data,
                              )
                            : CardKeluar(
                                width: width,
                                height: height,
                                data: data,
                              );
                      }),
            ),
          ],
        ),
      ),
    );
  }
}

class CardBiru extends StatelessWidget {
  const CardBiru({
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
      height: height * 0.15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 2), color: Colors.grey.shade400, blurRadius: 1)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width * 0.4,
            height: height * 0.035,
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomRight: Radius.circular(20)),
              color: COMPLEMENTARY_COLOR3,
            ),
            child: Center(
              child: FittedBox(
                child: Text(
                  '27 Sep 2024 | 10:00:00',
                  style: titleText,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: 'Oxygen\n', style: subtitleTextBlack),
                            TextSpan(
                                text: 'Nama Vendor\n',
                                style: subtitleTextBlack),
                            TextSpan(
                                text: 'Lokasi : \n', style: subtitleTextBlack),
                          ],
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: width * 0.3,
                          height: height * 0.1,
                          decoration: BoxDecoration(
                            color: COMPLEMENTARY_COLOR3,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: 'Stok Keluar\n',
                                      style: subtitleText),
                                  TextSpan(
                                    text: '500\n',
                                    style: minisubtitleText,
                                  ),
                                  TextSpan(
                                    text: 'MoU',
                                    style: titleText,
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
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

class CardOrange extends StatelessWidget {
  const CardOrange({
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
      height: height * 0.15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 2), color: Colors.grey.shade400, blurRadius: 1)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width * 0.4,
            height: height * 0.03,
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomRight: Radius.circular(20)),
              color: COMPLEMENTARY_COLOR5,
            ),
            child: Center(
              child: FittedBox(
                child: Text(
                  '27 Sep 2024 | 10:00:00',
                  style: titleText,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: 'Oxygen\n', style: superTitleTextBlack),
                            TextSpan(
                                text: 'Nama Vendor\n',
                                style: subtitleTextBlack),
                            TextSpan(
                                text: 'Lokasi : \n', style: subtitleTextBlack),
                          ],
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: width * 0.3,
                          height: height * 0.1,
                          decoration: BoxDecoration(
                            color: COMPLEMENTARY_COLOR5,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: 'Stok Keluar\n',
                                      style: subtitleText),
                                  TextSpan(
                                    text: '500\n',
                                    style: minisubtitleText,
                                  ),
                                  TextSpan(
                                    text: 'MoU',
                                    style: titleText,
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
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

class CardKeluar extends StatelessWidget {
  const CardKeluar({
    super.key,
    required this.width,
    required this.height,
    required this.data,
  });

  final double width;
  final double height;
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderItem>(context);

    return Container(
      width: width,
      height: height * 0.15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 2), color: Colors.grey.shade400, blurRadius: 1)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width * 0.4,
            height: height * 0.03,
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomRight: Radius.circular(20)),
              color: SECONDARY_COLOR,
            ),
            child: Center(
              child: FittedBox(
                child: Text(
                  "${provider.formatDate(data.createdAt.toString())} | ${provider.formatTime(data.createdAt.toString())}",
                  style: titleText,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: '${data.itemName}\n',
                              style: superTitleTextBlack),
                          TextSpan(
                              text: 'Lokasi Gudang : ${data.warehouseName}\n',
                              style: subtitleTextBlack),
                          // TextSpan(
                          //     text: 'Nama PO : ', style: subtitleTextBlack),
                        ],
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: width * 0.3,
                        height: height * 0.1,
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
                                  style: subtitleText,
                                ),
                                TextSpan(
                                    text: '${data.quantity}\n',
                                    style: subtitleText),
                                TextSpan(
                                  text: 'MoU',
                                  style: subtitleText,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
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

class CardMasuk extends StatelessWidget {
  const CardMasuk({
    super.key,
    required this.width,
    required this.height,
    required this.data,
  });

  final double width;
  final double height;
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderItem>(context);

    return Container(
      width: width,
      height: 100.h,
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 2), color: Colors.grey.shade400, blurRadius: 1)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width * 0.4,
            height: height * 0.03,
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomRight: Radius.circular(20)),
              color: COMPLEMENTARY_COLOR4,
            ),
            child: Center(
              child: FittedBox(
                child: Text(
                  "${provider.formatDate(data.createdAt.toString())} | ${provider.formatTime(data.createdAt.toString())}",
                  style: titleText,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: '${data.itemName}\n',
                                style: superTitleTextBlack),
                            TextSpan(
                                text: '${data.warehouseName}\n',
                                style: superTitleTextBlack),
                            // TextSpan(
                            //     text: 'Nama PO : ', style: subtitleTextBlack),
                          ],
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      margin: EdgeInsets.only(bottom: 10.h),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: width * 0.3,
                          height: height * 0.1,
                          decoration: BoxDecoration(
                            color: COMPLEMENTARY_COLOR4,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: 'Stok Masuk\n',
                                      style: subtitleText),
                                  TextSpan(
                                    text: '${data.quantity}\n',
                                    style: minisubtitleText,
                                  ),
                                  TextSpan(
                                    text: 'MoU',
                                    style: titleText,
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
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

// Model data untuk grafik
class _ChartData {
  _ChartData(this.month, this.sales);
  final double month;
  final double sales;
}
