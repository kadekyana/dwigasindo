import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/providers/provider_scan.dart';
import 'package:dwigasindo/views/menus/component_distribusi/componentTabung/component_tambah_tabung.dart';
import 'package:dwigasindo/widgets/widget_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetCardNewTube extends StatelessWidget {
  const WidgetCardNewTube({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderDistribusi>(context);
    final dataVer = provider.verifikasiBptk?.data;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      width: double.maxFinite,
      height: height * 0.25,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            blurRadius: 1,
            color: Color(0xffE4E4E4),
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  width: width * 0.3,
                  decoration: const BoxDecoration(
                    color: COMPLEMENTARY_COLOR3,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  child: const FittedBox(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Tabung Baru',
                      style: titleText,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: height * 0.01, horizontal: width * 0.05),
                  child: WidgetButton(
                      FullWidth: width * 0.1,
                      FullHeight: height,
                      title: 'Tabung Baru',
                      onpressed: () {},
                      bgColor: COMPLEMENTARY_COLOR3,
                      color: COMPLEMENTARY_COLOR3),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
                border: Border(
                  top: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: PRIMARY_COLOR),
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.all(6),
                                child: const FittedBox(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Produk',
                                    style: titleTextBlack,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.all(6),
                                child: const FittedBox(
                                  alignment: Alignment.centerLeft,
                                  child: Text(': -', style: titleTextBlack),
                                ),
                              ),
                            ),
                          ],
                        )),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.all(6),
                                child: const FittedBox(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Type',
                                    style: titleTextBlack,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.all(6),
                                child: const FittedBox(
                                  alignment: Alignment.centerLeft,
                                  child: Text(': -', style: titleTextBlack),
                                ),
                              ),
                            ),
                          ],
                        )),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.all(6),
                                child: const FittedBox(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Grade',
                                    style: titleTextBlack,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.all(6),
                                child: const FittedBox(
                                  alignment: Alignment.centerLeft,
                                  child: Text(': -', style: titleTextBlack),
                                ),
                              ),
                            )
                          ],
                        )),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.all(6),
                                child: const FittedBox(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Milik',
                                    style: titleTextBlack,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.all(6),
                                child: const FittedBox(
                                  alignment: Alignment.centerLeft,
                                  child: Text(': -', style: titleTextBlack),
                                ),
                              ),
                            )
                          ],
                        )),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.all(6),
                                child: const FittedBox(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Keterangan',
                                    style: titleTextBlack,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.all(6),
                                child: const FittedBox(
                                  alignment: Alignment.centerLeft,
                                  child: Text(': -', style: titleTextBlack),
                                ),
                              ),
                            ),
                          ],
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.all(13),
                  child: FittedBox(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '-',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final providerS =
                      Provider.of<ProviderScan>(context, listen: false);
                  providerS.clearResults();
                  providerS.clearScannedCount();
                  final provider =
                      Provider.of<ProviderDistribusi>(context, listen: false);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ComponentTambahTabung(
                        uuid: dataVer?.idStr,
                      ),
                    ),
                  );
                  provider.getAllSupplier(context);
                  provider.getAllTubeGrade(context);
                  provider.getAllTubeType(context);
                  provider.getAllTubeGas(context);
                  provider.getAllCostumer(context);
                },
                child: Container(
                  width: width * 0.3,
                  height: height * 0.1,
                  margin: EdgeInsets.only(
                      right: width * 0.02, bottom: height * 0.01),
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  decoration: BoxDecoration(
                    color: SECONDARY_COLOR,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: FittedBox(
                    child: Text(
                      'Lengkapi Data',
                      style: subtitleText,
                    ),
                  ),
                ),
              )
            ],
          )),
        ],
      ),
    );
  }
}
