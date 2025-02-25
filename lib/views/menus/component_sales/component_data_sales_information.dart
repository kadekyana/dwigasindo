import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/providers/provider_sales.dart';
import 'package:dwigasindo/views/menus/component_sales/component_menu_produk_master_customer.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../providers/provider_item.dart';

class ComponentDataSalesInformation extends StatefulWidget {
  ComponentDataSalesInformation({super.key, required this.title});
  String title;
  @override
  _ComponentDataSalesInformationState createState() =>
      _ComponentDataSalesInformationState();
}

class _ComponentDataSalesInformationState
    extends State<ComponentDataSalesInformation> {
  // Data untuk grafik spline
  List<_ChartData> data = [
    _ChartData('Jan', 35),
    _ChartData('Feb', 300),
    _ChartData('Mar', 600),
    _ChartData('Apr', 1000),
    _ChartData('Mei', 1000),
    _ChartData('Jun', 1000),
    _ChartData('Jul', 2000),
    _ChartData('Ags', 2000),
    _ChartData('Sep', 2000),
    _ChartData('Okt', 2000),
    _ChartData('Nov', 2200),
    _ChartData('Des', 2300),
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderItem>(context);
    final providerSal = Provider.of<ProviderSales>(context);
    final providerDis = Provider.of<ProviderDistribusi>(context);
    final dataSummary = providerSal.summarySales?.data;
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
                    height: 100.h,
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {},
                            child: Card(
                              elevation: 2,
                              child: Padding(
                                padding: EdgeInsets.all(10.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: Image.asset(
                                            "assets/images/target.png")),
                                    RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: "Target\n",
                                              style: minisubtitleTextBlack),
                                          TextSpan(
                                              text: "${dataSummary?.target}",
                                              style: subtitleTextBoldBlack),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {},
                            child: Card(
                              elevation: 2,
                              child: Padding(
                                padding: EdgeInsets.all(10.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: Image.asset(
                                            "assets/images/revenue.png")),
                                    RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: "Revenue\n",
                                              style: minisubtitleTextBlack),
                                          TextSpan(
                                              text: "${dataSummary?.revenue}",
                                              style: subtitleTextBoldBlack),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {},
                            child: Card(
                              elevation: 2,
                              child: Padding(
                                padding: EdgeInsets.all(10.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: Image.asset(
                                            "assets/images/customer.png")),
                                    RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: "Customer\n",
                                              style: minisubtitleTextBlack),
                                          TextSpan(
                                              text: "${dataSummary?.customer}",
                                              style: subtitleTextBoldBlack),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: width,
                    height: 300.h,
                    child: SfCartesianChart(
                      primaryXAxis: const CategoryAxis(
                        title: AxisTitle(text: 'Bulan'),
                        // Rotasi teks agar lebih terbaca
                        majorGridLines: MajorGridLines(
                            width: 0), // Hilangkan garis grid vertikal
                      ),
                      primaryYAxis: const NumericAxis(
                        title: AxisTitle(text: 'Jumlah Penjualan'),
                        minimum: 0,
                        maximum: 2500,
                        interval: 500,
                      ),
                      tooltipBehavior:
                          TooltipBehavior(enable: true), // Tooltip saat hover
                      series: <CartesianSeries<_ChartData, String>>[
                        SplineSeries<_ChartData, String>(
                          dataSource: data,
                          xValueMapper: (_ChartData sales, _) => sales.month,
                          yValueMapper: (_ChartData sales, _) => sales.sales,
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: true),
                          markerSettings: const MarkerSettings(
                              isVisible: true), // Tampilkan titik data
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (!mounted)
                        return
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
                          providerSal.getAllList(context),
                          providerSal.getAllKunjungan(context),
                          providerSal.getDetailLead(context, 0),
                          providerSal.getUsersPic(context),
                          providerSal.getLeads(context, 0),
                          providerSal.getDistrict(context, ''),
                          providerDis.getAllCostumer(context),
                        ]);

                        // Navigate sesuai kondisi
                        Navigator.of(context).pop(); // Tutup Dialog Loading
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ComponentMenuSalesInformationDetail(
                              title: 'Detail ${widget.title}',
                            ),
                          ),
                        );
                      } catch (e) {
                        Navigator.of(context).pop(); // Tutup Dialog Loading
                        print('Error: $e');
                        // Tambahkan pesan error jika perlu
                      }

                      // (item['title'] == "Sales Information") ? :
                    },
                    child: Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.symmetric(
                        vertical: height * 0.01,
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.05, vertical: height * 0.02),
                      height: 80.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 2,
                              offset: Offset(0, 3),
                              color: Colors.grey.shade300),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: width * 0.1,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/images/distribusi.png'),
                              ),
                            ),
                          ),
                          SizedBox(width: width * 0.03),
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  "Sales Information", // Gunakan title dari list
                                  style: titleTextBlack),
                            ),
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
  final String month;
  final double sales;
}
