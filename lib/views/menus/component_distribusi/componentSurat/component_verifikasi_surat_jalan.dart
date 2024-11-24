import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/views/menus/component_distribusi/componentBPTK/component_scan_bpti.dart';
import 'package:dwigasindo/views/menus/component_distribusi/componentSurat/component_buat_verfikasi_surat_jalan.dart';
import 'package:dwigasindo/views/menus/component_distribusi/componentSurat/component_detail_verfikasi_surat_jalan.dart';
import 'package:dwigasindo/views/menus/component_distribusi/componentSurat/component_scan_mencurigakan_verfikasi_surat_jalan.dart';
import 'package:dwigasindo/views/menus/component_distribusi/componentSurat/component_scan_verfikasi_surat_jalan.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ComponentVerifikasiSuratJalan extends StatelessWidget {
  const ComponentVerifikasiSuratJalan({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final provider = Provider.of<ProviderDistribusi>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      resizeToAvoidBottomInset: false,
      appBar: WidgetAppbar(
        title: 'Verifikasi Surat Jalan',
        sizefont: 24,
        center: true,
        colorTitle: Colors.black,
        colorBack: Colors.black,
        colorBG: Colors.grey.shade100,
        back: true,
        route: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: SizedBox(
            width: double.maxFinite,
            height: double.maxFinite,
            child: Column(
              children: [
                WidgetButtonCustom(
                    FullWidth: width,
                    FullHeight: height * 0.06,
                    title: 'Buat verifikasi Surat Jalan',
                    onpressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ComponentBuatVerifikasiSuratJalan(),
                        ),
                      );
                    },
                    titleColor: Colors.black,
                    color: PRIMARY_COLOR),
                SizedBox(
                  height: height * 0.05,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: provider.dataVerifikasiSurat.length,
                    itemBuilder: (context, index) {
                      final data = provider.dataVerifikasiSurat[index];

                      return Container(
                        width: double.maxFinite,
                        height: height * 0.2,
                        margin: EdgeInsets.only(bottom: height * 0.02),
                        decoration: BoxDecoration(
                          color: (data['warna'] == 'sedang')
                              ? Color(0xffF2B862)
                              : (data['warna'] == 'selesai')
                                  ? Color(0xff60D57D)
                                  : Colors.black,
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
                            Container(
                              width: double.maxFinite,
                              height: 40,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    width: width * 0.4,
                                    decoration: BoxDecoration(
                                      color: (data['warna'] == 'kendala')
                                          ? Colors.white
                                          : PRIMARY_COLOR,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(40),
                                      ),
                                    ),
                                    child: FittedBox(
                                      alignment: Alignment.center,
                                      child: Text(
                                        (data['warna'] == 'sedang')
                                            ? 'Sedang Diproses'
                                            : (data['warna'] == 'selesai')
                                                ? 'Selesai'
                                                : 'Selesai',
                                        style: (data['warna'] == 'kendala')
                                            ? titleTextBlack
                                            : titleText,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    width: width * 0.35,
                                    child: FittedBox(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '23-09-2024 | 10:30:00',
                                        style: (data['warna'] == 'kendala')
                                            ? titleText
                                            : titleTextBlack,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.02),
                                decoration: BoxDecoration(
                                  border: Border(
                                    top:
                                        BorderSide(color: Colors.grey.shade300),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              padding: EdgeInsets.all(3),
                                              child: FittedBox(
                                                alignment: Alignment.bottomLeft,
                                                child: Text(
                                                  'VSJ-002',
                                                  style: (data['warna'] ==
                                                          'kendala')
                                                      ? titleText
                                                      : titleTextBlack,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              padding: EdgeInsets.all(3),
                                              child: FittedBox(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Driver',
                                                  style: (data['warna'] ==
                                                          'kendala')
                                                      ? titleText
                                                      : titleTextBlack,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              padding: EdgeInsets.all(3),
                                              child: FittedBox(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  ': Andi Muhammad',
                                                  style: (data['warna'] ==
                                                          'kendala')
                                                      ? titleText
                                                      : titleTextBlack,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              padding: EdgeInsets.all(3),
                                              child: FittedBox(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Verifikasi',
                                                  style: (data['warna'] ==
                                                          'kendala')
                                                      ? titleText
                                                      : titleTextBlack,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              padding: EdgeInsets.all(3),
                                              child: FittedBox(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  ': Mako , Ozo',
                                                  style: (data['warna'] ==
                                                          'kendala')
                                                      ? titleText
                                                      : titleTextBlack,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  WidgetButtonCustom(
                                    FullWidth: width * 0.25,
                                    FullHeight: 30,
                                    title: 'Detail',
                                    onpressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ComponentScanDetailVerifikasiSuratJalan(),
                                        ),
                                      );
                                    },
                                    titleColor: (data['warna'] == 'kendala')
                                        ? Colors.white
                                        : Colors.black,
                                    bgColor: Colors.transparent,
                                    color: (data['warna'] == 'kendala')
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  SizedBox(
                                    width: width * 0.01,
                                  ),
                                  WidgetButtonCustom(
                                      FullWidth: width * 0.3,
                                      FullHeight: 30,
                                      title: 'Verifikasi',
                                      onpressed: () {
                                        if (data['warna'] == 'kendala') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ComponentScanMencurigakanVerifikasiSuratJalan(),
                                            ),
                                          );
                                        } else {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ComponentScanVerifikasiSuratJalan(),
                                            ),
                                          );
                                        }
                                      },
                                      bgColor: (data['warna'] == 'kendala')
                                          ? Colors.white
                                          : PRIMARY_COLOR,
                                      titleColor: (data['warna'] == 'kendala')
                                          ? Colors.black
                                          : Colors.white,
                                      color: Colors.transparent),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// Column(
//                           children: [
//                             Container(
//                               width: double.maxFinite,
//                               height: 40,
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(
//                                     padding: EdgeInsets.all(10),
//                                     width: width * 0.4,
//                                     decoration: const BoxDecoration(
//                                       color: PRIMARY_COLOR,
//                                       borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(8),
//                                         bottomRight: Radius.circular(40),
//                                       ),
//                                     ),
//                                     child: const FittedBox(
//                                       alignment: Alignment.center,
//                                       child: Text(
//                                         'Sedang',
//                                         style: titleText,
//                                       ),
//                                     ),
//                                   ),
//                                   Container(
//                                     padding: EdgeInsets.all(10),
//                                     width: width * 0.35,
//                                     child: const FittedBox(
//                                       alignment: Alignment.centerRight,
//                                       child: Text(
//                                         '23-09-2024 | 10:30:00',
//                                         style: titleTextBlack,
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             Expanded(
//                               child: Container(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: width * 0.025),
//                                 decoration: BoxDecoration(
//                                   border: Border(
//                                     top:
//                                         BorderSide(color: Colors.grey.shade300),
//                                   ),
//                                 ),
//                                 child: Column(
//                                   children: [
//                                     Expanded(
//                                         child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       children: [
//                                         Expanded(
//                                           flex: 1,
//                                           child: Container(
//                                             padding: EdgeInsets.all(6),
//                                             child: const FittedBox(
//                                               alignment: Alignment.centerLeft,
//                                               child: Text(
//                                                 'Driver',
//                                                 style: titleTextBlack,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Expanded(
//                                           flex: 2,
//                                           child: Container(
//                                             padding: EdgeInsets.all(6),
//                                             child: const FittedBox(
//                                               alignment: Alignment.centerLeft,
//                                               child: Text(
//                                                 ': Andi Muhammad',
//                                                 style: titleTextBlack,
//                                               ),
//                                             ),
//                                           ),
//                                         )
//                                       ],
//                                     )),
//                                     Expanded(
//                                         child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       children: [
//                                         Expanded(
//                                           flex: 1,
//                                           child: Container(
//                                             padding: EdgeInsets.all(6),
//                                             child: const FittedBox(
//                                               alignment: Alignment.centerLeft,
//                                               child: Text(
//                                                 'Admin',
//                                                 style: titleTextBlack,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Expanded(
//                                           flex: 2,
//                                           child: Container(
//                                             padding: EdgeInsets.all(6),
//                                             child: const FittedBox(
//                                               alignment: Alignment.centerLeft,
//                                               child: Text(': Udin',
//                                                   style: titleTextBlack),
//                                             ),
//                                           ),
//                                         )
//                                       ],
//                                     )),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             // Padding(
//                             //   padding: EdgeInsets.symmetric(
//                             //       vertical: 5, horizontal: 10),
//                             //   child: Row(
//                             //     mainAxisAlignment: MainAxisAlignment.end,
//                             //     children: [
//                             //       WidgetButtonCustom(
//                             //           FullWidth: width * 0.25,
//                             //           FullHeight: 30,
//                             //           title: 'Scan BPTI',
//                             //           onpressed: () {
//                             //             Navigator.push(
//                             //               context,
//                             //               MaterialPageRoute(
//                             //                 builder: (context) =>
//                             //                     ComponentScanBPTI(),
//                             //               ),
//                             //             );
//                             //           },
//                             //           bgColor: PRIMARY_COLOR,
//                             //           color: Colors.transparent),
//                             //     ],
//                             //   ),
//                             // ),
//                           ],
//                         // )