import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_produksi.dart';
import 'package:dwigasindo/views/menus/component_produksi/produksi_c2h2/LT/component_loading_tabung.dart';
import 'package:dwigasindo/views/menus/component_produksi/produksi_c2h2/LT/component_loading_tabung_mix_gas.dart';
import 'package:dwigasindo/views/menus/component_produksi/produksi_c2h2/control/control_c2h2.dart';
import 'package:dwigasindo/views/menus/component_produksi/produksi_c2h2/control/control_high_pressure.dart';
import 'package:dwigasindo/views/menus/component_produksi/produksi_c2h2/purging/component_purging.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_distribusi.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';

import 'produksi/component_produksi.dart';

class MenuProduksi extends StatefulWidget {
  MenuProduksi({super.key, required this.title});
  String title;

  @override
  State<MenuProduksi> createState() => _MenuProduksiState();
}

class _MenuProduksiState extends State<MenuProduksi> {
  @override
  void initState() {
    // TODO: implement initState
    awaitData();
    super.initState();
  }

  Future<void> awaitData() async {
    final provider = Provider.of<ProviderProduksi>(context, listen: false);
    await provider.getAllProduksi(context);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final titleSize = width * 0.04;
    final subSize = width * 0.02;
    return Scaffold(
      appBar: WidgetAppbar(
        title: widget.title,
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            (widget.title == 'C2H2')
                ? WidgetCard_C2H2(
                    width: width,
                    height: height,
                    titleSize: titleSize,
                    subSize: subSize)
                : WidgetCard_HighPreasure(
                    width: width,
                    height: height,
                    titleSize: titleSize,
                    subSize: subSize),
            WidgetButtonDistribusi(
                title: 'Loading Tabung',
                dataList: null,
                onTap: (widget.title == "C2H2")
                    ? ComponentLoadingTabung(
                        title: widget.title,
                      )
                    : const ComponentLoadingTabungMixGas()),
            WidgetButtonDistribusi(
              title: 'Produksi',
              dataList: null,
              onTap: ComponentProduksi(
                title: widget.title,
              ),
            ),
            WidgetButtonDistribusi(
              title: 'Purging',
              dataList: null,
              onTap: ComponentPurging(
                title: 'Purging',
                fill: 0,
              ),
            ),
            WidgetButtonDistribusi(
              title: 'Control',
              dataList: null,
              onTap: (widget.title != "C2H2")
                  ? ControlHighPressure(titleMenu: widget.title)
                  : ControlC2h2(
                      titleMenu: widget.title,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class WidgetCard_C2H2 extends StatelessWidget {
  const WidgetCard_C2H2({
    super.key,
    required this.width,
    required this.height,
    required this.titleSize,
    required this.subSize,
  });

  final double width;
  final double height;
  final double titleSize;
  final double subSize;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                              style: titleText),
                          TextSpan(text: '1.233,6 Kg\n', style: titleText),
                          TextSpan(
                              text: 'Hari ini\n\n', style: minisubtitleText),
                          TextSpan(text: '1.233,6 Kg\n', style: titleText),
                          TextSpan(text: 'Bulan ini', style: minisubtitleText),
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
                              style: titleText),
                          TextSpan(text: '742 Kg\n', style: titleText),
                          TextSpan(
                              text: 'Hari ini\n\n', style: minisubtitleText),
                          TextSpan(text: '8.230 Kg\n', style: titleText),
                          TextSpan(text: 'Bulan ini', style: minisubtitleText),
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
                      TextSpan(text: 'Selisih\n', style: titleText),
                      TextSpan(
                          text: '438,6 Kg = 14.6 drum\n', style: titleText),
                      TextSpan(
                        text: 'Hari ini\n\n',
                        style: minisubtitleText,
                      ),
                      TextSpan(
                          text: '4.857 Kg = 150,3 drum\n', style: titleText),
                      TextSpan(
                        text: 'Bulan ini',
                        style: minisubtitleText,
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
    );
  }
}

class WidgetCard_HighPreasure extends StatelessWidget {
  const WidgetCard_HighPreasure({
    super.key,
    required this.width,
    required this.height,
    required this.titleSize,
    required this.subSize,
  });

  final double width;
  final double height;
  final double titleSize;
  final double subSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height * 0.4,
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
                              style: titleText),
                          TextSpan(text: '1.233,6 Kg\n', style: titleText),
                          TextSpan(
                              text: 'Hari ini\n\n', style: minisubtitleText),
                          TextSpan(text: '1.233,6 Kg\n', style: titleText),
                          TextSpan(text: 'Bulan ini', style: minisubtitleText),
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
                              style: titleText),
                          TextSpan(text: '742 Kg\n', style: titleText),
                          TextSpan(
                              text: 'Hari ini\n\n', style: minisubtitleText),
                          TextSpan(text: '8.230 Kg\n', style: titleText),
                          TextSpan(text: 'Bulan ini', style: minisubtitleText),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GroupButton(
              options: GroupButtonOptions(
                  unselectedBorderColor: Colors.white,
                  selectedBorderColor: Colors.white,
                  unselectedColor: Colors.transparent,
                  selectedColor: Colors.white,
                  unselectedTextStyle: subtitleText,
                  selectedTextStyle: subtitleTextBlack,
                  borderRadius: BorderRadius.circular(12),
                  buttonWidth: width * 0.3),
              isRadio: true,
              buttons: const ['Gain', 'Loss']),
          Expanded(
            child: Container(
              child: Row(
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text: 'Gain\n', style: titleText),
                          TextSpan(text: '438,6 Kg\n', style: titleText),
                          TextSpan(
                              text: 'Hari ini\n\n', style: minisubtitleText),
                          TextSpan(text: '4.857 Kg\n', style: titleText),
                          TextSpan(text: 'Bulan ini', style: minisubtitleText),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text: 'Yelid\n', style: titleText),
                          TextSpan(text: '43 %\n', style: titleText),
                          TextSpan(
                              text: 'Hari ini\n\n', style: minisubtitleText),
                          TextSpan(text: '80 %\n', style: titleText),
                          TextSpan(text: 'Bulan ini', style: minisubtitleText),
                        ],
                      ),
                      textAlign: TextAlign.center,
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

class tes extends StatelessWidget {
  const tes({super.key});

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
      body: const Center(
        child: Text('Pending'),
      ),
    );
  }
}
