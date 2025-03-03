import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/views/menus/component_warehouse/Pb/component_penerimaan_barang.dart';
import 'package:dwigasindo/views/menus/component_warehouse/PenB/component_permintaan_barang.dart';
import 'package:dwigasindo/views/menus/component_warehouse/Stok/component_item_stok.dart';
import 'package:dwigasindo/views/menus/component_warehouse/So/component_stok_opname.dart';
import 'package:dwigasindo/views/menus/menu_home.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_distribusi.dart';
import 'package:flutter/material.dart';

class MenuWarehouse extends StatelessWidget {
  const MenuWarehouse({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final titleSize = width * 0.04;
    final subSize = width * 0.02;
    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Warehouse',
        colorBack: Colors.black,
        back: true,
        route: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => BottomAppBar()));
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
              height: height * 0.2,
              decoration: BoxDecoration(
                color: PRIMARY_COLOR,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: 'Total Item\n', style: titleText),
                                  TextSpan(text: '1.000\n', style: titleText),
                                  TextSpan(
                                      text: 'Bulan ini',
                                      style: minisubtitleText),
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
                                      text: 'Permintaan Barang\n',
                                      style: titleText),
                                  TextSpan(text: '100\n', style: titleText),
                                  TextSpan(
                                      text: 'Bulan ini',
                                      style: minisubtitleText),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: 'Permintaan Barang\n',
                                  style: titleText),
                              TextSpan(text: '100\n', style: titleText),
                              TextSpan(
                                  text: 'Bulan ini', style: minisubtitleText),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const WidgetButtonDistribusi(
              title: 'Item Stok',
              dataList: null,
              onTap: ComponentItemStok(),
            ),
            const WidgetButtonDistribusi(
              title: 'Stok Opname',
              dataList: null,
              onTap: ComponentStokOpname(),
            ),
            const WidgetButtonDistribusi(
              title: 'Penerimaan Barang',
              dataList: null,
              onTap: ComponentPenerimaanBarang(),
            ),
            const WidgetButtonDistribusi(
              title: 'Permintaan Barang',
              dataList: null,
              onTap: ComponentPermintaanBarang(),
            ),
          ],
        ),
      ),
    );
  }
}
