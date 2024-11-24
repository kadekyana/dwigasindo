import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/views/menus/component_produksi/LT/component_loading_tabung.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_distribusi.dart';
import 'package:flutter/material.dart';

import 'produksi/component_produksi.dart';

class MenuProduksi extends StatelessWidget {
  const MenuProduksi({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final titleSize = width * 0.04;
    final subSize = width * 0.02;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: WidgetAppbar(
        title: 'Produksi',
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
              height: height * 0.35,
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
                                    text: 'Aktual gas yang\ndihasilkan\n',
                                    style: TextStyle(
                                      fontFamily: 'Manrope',
                                      fontSize: titleSize,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '1.233,6 Kg\n',
                                    style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: titleSize,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: 'Hari ini\n\n',
                                    style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: subSize),
                                  ),
                                  TextSpan(
                                    text: '1.233,6 Kg\n',
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
                                    text: 'Normal gas yang\ndihasilkan\n',
                                    style: TextStyle(
                                      fontFamily: 'Manrope',
                                      fontSize: titleSize,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '742 Kg\n',
                                    style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: titleSize,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: 'Hari ini\n\n',
                                    style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: subSize),
                                  ),
                                  TextSpan(
                                    text: '8.230 Kg\n',
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
                                text: 'Selisih\n',
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: titleSize,
                                ),
                              ),
                              TextSpan(
                                text: '438,6 Kg = 14.6 drum\n',
                                style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: titleSize,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: 'Hari ini\n\n',
                                style: TextStyle(
                                    fontFamily: 'Manrope', fontSize: subSize),
                              ),
                              TextSpan(
                                text: '4.857 Kg = 150,3 drum\n',
                                style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: titleSize,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: 'Bulan ini',
                                style: TextStyle(
                                    fontFamily: 'Manrope', fontSize: subSize),
                              ),
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
            WidgetButtonDistribusi(
              title: 'Loading Tabung',
              dataList: null,
              onTap: ComponentLoadingTabung(),
            ),
            WidgetButtonDistribusi(
              title: 'Produksi',
              dataList: null,
              onTap: ComponentProduksi(),
            ),
            WidgetButtonDistribusi(
              title: 'Control',
              dataList: null,
              onTap: tes(),
            ),
          ],
        ),
      ),
    );
  }
}

class tes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: WidgetAppbar(
        title: '-',
        back: true,
        route: () {
          Navigator.pop(context);
        },
      ),
      body: Center(
        child: Text('Pending'),
      ),
    );
  }
}
