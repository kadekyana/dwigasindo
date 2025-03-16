import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/views/menus/component_asset/component_asset.dart';
import 'package:dwigasindo/views/menus/component_asset/component_detail_komponen.dart';
import 'package:dwigasindo/views/menus/component_asset/component_maintance_asset.dart';
import 'package:dwigasindo/views/menus/component_asset/component_pajak_asset.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_distribusi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuAssets extends StatelessWidget {
  const MenuAssets({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Asset',
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              width: width,
              height: 100.h,
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              decoration: BoxDecoration(
                color: PRIMARY_COLOR,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text: '\nJumlah\nAsset\n', style: titleText),
                          TextSpan(text: '200\n', style: titleText),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: '\nJumlah\nKomponen\n', style: titleText),
                          TextSpan(text: '1.000\n', style: titleText),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: '\nJumlah\nMaintenance\n',
                              style: titleText),
                          TextSpan(text: '100\n', style: titleText),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            WidgetButtonDistribusi(
              title: 'Asset',
              dataList: null,
              onTap: ComponentAsset(),
            ),
            WidgetButtonDistribusi(
              title: 'Komponen',
              dataList: null,
              onTap: ComponentDetailKomponen(),
            ),
            WidgetButtonDistribusi(
              title: 'Maintenance',
              dataList: null,
              onTap: ComponentMaintanceAsset(),
            ),
            WidgetButtonDistribusi(
              title: 'Pajak / KIR',
              dataList: null,
              onTap: ComponentPajakAsset(),
            ),
          ],
        ),
      ),
    );
  }
}
