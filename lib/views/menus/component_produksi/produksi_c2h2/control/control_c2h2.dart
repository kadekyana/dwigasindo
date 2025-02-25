import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/views/menus/component_produksi/produksi_c2h2/control/detail_control_c2h2.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ControlC2h2 extends StatelessWidget {
  ControlC2h2({super.key, required this.titleMenu});
  String titleMenu;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    // List map untuk data
    final List<Map<String, dynamic>> items = [
      {'title': 'Stok Bahan Baku', 'subtitle': ''},
      {'title': 'Pemakaian CaCl2', 'subtitle': ''},
      {'title': 'Pemakaian Generator', 'subtitle': ''},
      {'title': 'Control Compressor', 'subtitle': ''},
    ];

    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Control $titleMenu',
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
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: items.isNotEmpty
            ? ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  final title = item['title'] ?? 'No Title';
                  final subtitle = item['subtitle'] ?? 'No Subtitle';

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailControlC2H2(
                            title: title,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.symmetric(
                        vertical: height * 0.01,
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.05, vertical: height * 0.02),
                      height: 70.h,
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
                            width: 50.w,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/images/distribusi.png'),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Text(title, style: titleTextBlack),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: Text(
                  'No Data Available',
                  style: subtitleTextNormal,
                ),
              ),
      ),
    );
  }
}
