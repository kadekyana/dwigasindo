import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../providers/provider_item.dart';

class ComponentMutasiStok extends StatefulWidget {
  @override
  _ComponentMutasiStokState createState() => _ComponentMutasiStokState();
}

class _ComponentMutasiStokState extends State<ComponentMutasiStok> {
  // Data untuk grafik spline
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
      body: (provider.isLoading == true)
          ? Center(
              child: Container(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
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
                    child: const Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Center(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Nama Item : O2',
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
                                      'Stok Tersedia : Jhon Doe',
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
                                      'Vendor \t\t\t\t\t\t\t\t: O2',
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
                                      'Stok Terpakai : \t\t\t\t\t\tClient ',
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
                          name: 'Stok',
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
                        const Text(
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
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            width: width,
                            height: height * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 2),
                                    color: Colors.grey.shade400,
                                    blurRadius: 1)
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: width * 0.4,
                                  height: height * 0.035,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.05),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(20)),
                                    color: COMPLEMENTARY_COLOR4,
                                  ),
                                  child: const Center(
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
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.03),
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
                                                    text: 'Oxygen\n',
                                                    style: TextStyle(
                                                      fontSize: width * 0.08,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: 'Nama Vendor\n',
                                                    style: TextStyle(
                                                      fontSize: width * 0.04,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: 'Nama PO : ',
                                                    style: TextStyle(
                                                      fontSize: width * 0.03,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.black,
                                                    ),
                                                  ),
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
                                                  color: COMPLEMENTARY_COLOR4,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Center(
                                                  child: RichText(
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: 'Stok Masuk\n',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  width * 0.035,
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  'Manrope',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        TextSpan(
                                                          text: '1.500\n',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  width * 0.08,
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  'Manrope',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        TextSpan(
                                                          text: 'MoU',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  width * 0.03,
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  'Manrope',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Container(
                            width: width,
                            height: height * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 2),
                                    color: Colors.grey.shade400,
                                    blurRadius: 1)
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: width * 0.4,
                                  height: height * 0.035,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.05),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(20)),
                                    color: SECONDARY_COLOR,
                                  ),
                                  child: const Center(
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
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.03),
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
                                                    text: 'Oxygen\n',
                                                    style: TextStyle(
                                                      fontSize: width * 0.08,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: 'Nama Vendor\n',
                                                    style: TextStyle(
                                                      fontSize: width * 0.04,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: 'Grup Rak : \n',
                                                    style: TextStyle(
                                                      fontSize: width * 0.03,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: 'Jumlah Tabung : ',
                                                    style: TextStyle(
                                                      fontSize: width * 0.03,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.black,
                                                    ),
                                                  ),
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
                                                  color: SECONDARY_COLOR,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Center(
                                                  child: RichText(
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: 'Stok Keluar\n',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  width * 0.035,
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  'Manrope',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        TextSpan(
                                                          text: '500\n',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  width * 0.08,
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  'Manrope',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        TextSpan(
                                                          text: 'MoU',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  width * 0.03,
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  'Manrope',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Container(
                            width: width,
                            height: height * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 2),
                                    color: Colors.grey.shade400,
                                    blurRadius: 1)
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: width * 0.4,
                                  height: height * 0.035,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.05),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(20)),
                                    color: COMPLEMENTARY_COLOR5,
                                  ),
                                  child: const Center(
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
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.03),
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
                                                    text: 'Oxygen\n',
                                                    style: TextStyle(
                                                      fontSize: width * 0.08,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: 'Nama Vendor\n',
                                                    style: TextStyle(
                                                      fontSize: width * 0.04,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: 'Lokasi : \n',
                                                    style: TextStyle(
                                                      fontSize: width * 0.03,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.black,
                                                    ),
                                                  ),
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
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Center(
                                                  child: RichText(
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: 'Stok Keluar\n',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  width * 0.035,
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  'Manrope',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        TextSpan(
                                                          text: '500\n',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  width * 0.08,
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  'Manrope',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        TextSpan(
                                                          text: 'MoU',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  width * 0.03,
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  'Manrope',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Container(
                            width: width,
                            height: height * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 2),
                                    color: Colors.grey.shade400,
                                    blurRadius: 1)
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: width * 0.4,
                                  height: height * 0.035,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.05),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(20)),
                                    color: COMPLEMENTARY_COLOR3,
                                  ),
                                  child: const Center(
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
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.03),
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
                                                    text: 'Oxygen\n',
                                                    style: TextStyle(
                                                      fontSize: width * 0.08,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: 'Nama Vendor\n',
                                                    style: TextStyle(
                                                      fontSize: width * 0.04,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: 'Lokasi : \n',
                                                    style: TextStyle(
                                                      fontSize: width * 0.03,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.black,
                                                    ),
                                                  ),
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
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Center(
                                                  child: RichText(
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: 'Stok Keluar\n',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  width * 0.035,
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  'Manrope',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        TextSpan(
                                                          text: '500\n',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  width * 0.08,
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  'Manrope',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        TextSpan(
                                                          text: 'MoU',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  width * 0.03,
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  'Manrope',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
