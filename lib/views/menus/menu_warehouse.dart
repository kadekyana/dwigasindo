import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/views/menus/component_warehouse/Pb/component_penerimaan_barang.dart';
import 'package:dwigasindo/views/menus/component_warehouse/PenB/component_permintaan_barang.dart';
import 'package:dwigasindo/views/menus/component_warehouse/Stok/component_item_stok.dart';
import 'package:dwigasindo/views/menus/component_warehouse/So/component_stok_opname.dart';
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
      backgroundColor: Colors.grey.shade100,
      appBar: WidgetAppbar(
        title: 'Warehouse',
        colorBack: Colors.black,
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
        padding: EdgeInsets.symmetric(horizontal: 20),
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
                                    text: 'Total Item\n',
                                    style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: titleSize,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: '1.000\n',
                                    style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: titleSize,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: 'Bulan ini',
                                    style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: subSize),
                                  ),
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
                                    style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: titleSize,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: '100\n',
                                    style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: titleSize,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                      text: 'Bulan ini',
                                      style: TextStyle(
                                          fontFamily: 'Manrope', fontSize: 10)),
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
                                style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: titleSize,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: '100\n',
                                style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: titleSize,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                  text: 'Bulan ini',
                                  style: TextStyle(
                                      fontFamily: 'Manrope', fontSize: 10)),
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
            WidgetButtonDistribusi(
              title: 'Stok Opname',
              dataList: null,
              onTap: ComponentStokOpname(),
            ),
            WidgetButtonDistribusi(
              title: 'Penerimaan Barang',
              dataList: null,
              onTap: ComponentPenerimaanBarang(),
            ),
            WidgetButtonDistribusi(
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
