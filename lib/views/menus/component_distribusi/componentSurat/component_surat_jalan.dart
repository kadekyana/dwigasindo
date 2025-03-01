import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_surat_jalan.dart';
import 'package:dwigasindo/views/menus/component_distribusi/componentSurat/component_buat_surat_jalan.dart';
import 'package:dwigasindo/views/menus/component_distribusi/componentSurat/component_update_driver.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ComponentSuratJalan extends StatefulWidget {
  const ComponentSuratJalan({super.key});

  @override
  State<ComponentSuratJalan> createState() => _ComponentSuratJalanState();
}

class _ComponentSuratJalanState extends State<ComponentSuratJalan> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProviderSuratJalan>(context, listen: false);
    provider.getAllSuratJalan(context);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final provider = Provider.of<ProviderSuratJalan>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: WidgetAppbar(
        title: 'Surat Jalan',
        sizefont: 22,
        center: true,
        colorTitle: Colors.black,
        colorBack: Colors.black,
        colorBG: Colors.grey.shade100,
        back: true,
        route: () {
          Navigator.pop(context);
        },
      ),
      body: (provider.isLoading == true)
          ? Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: const CircularProgressIndicator(),
              ),
            )
          : SafeArea(
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
                          title: 'Buat Surat Jalan',
                          onpressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ComponentBuatSuratJalan(),
                              ),
                            );
                          },
                          bgColor: PRIMARY_COLOR,
                          color: PRIMARY_COLOR),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      (provider.suratJalan?.data == null)
                          ? Expanded(
                              child: Center(
                                child: Text(
                                  'Data Kosong',
                                  style: titleTextNormal,
                                ),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: provider.suratJalan?.data?.length,
                                itemBuilder: (context, index) {
                                  final data =
                                      provider.suratJalan!.data![index];
                                  return Container(
                                    width: double.maxFinite,
                                    height: height * 0.2,
                                    margin:
                                        EdgeInsets.only(bottom: height * 0.02),
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
                                          height: height * 0.05,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: width * 0.35,
                                                height: height * 0.05,
                                                decoration: const BoxDecoration(
                                                  color: PRIMARY_COLOR,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(8),
                                                    bottomRight:
                                                        Radius.circular(40),
                                                  ),
                                                ),
                                                child: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    data.no!,
                                                    style: titleText,
                                                  ),
                                                ),
                                              ),
                                              // kurang create at pada API
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                width: width * 0.35,
                                                height: height * 0.05,
                                                child: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    '23-09-2024 | 10:30:00',
                                                    style: titleTextNormal,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width * 0.02,
                                                vertical: height * 0.01),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                top: BorderSide(
                                                    color:
                                                        Colors.grey.shade300),
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
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            'Driver',
                                                            style:
                                                                subtitleTextBlack,
                                                          ),
                                                        ),
                                                      ),
                                                      const Text(':'),
                                                      Expanded(
                                                        flex: 2,
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            '\t${data.name}',
                                                            style:
                                                                subtitleTextBlack,
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
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            'Admin',
                                                            style:
                                                                subtitleTextBlack,
                                                          ),
                                                        ),
                                                      ),
                                                      const Text(':'),
                                                      // Kurang Admin Pada API
                                                      Expanded(
                                                        flex: 2,
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            '\tUdin',
                                                            style:
                                                                subtitleTextBlack,
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
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            'Nomor Kendaraan',
                                                            style:
                                                                subtitleTextBlack,
                                                          ),
                                                        ),
                                                      ),
                                                      const Text(':'),
                                                      Expanded(
                                                        flex: 2,
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            '\t${data.vehicleNumber}',
                                                            style:
                                                                subtitleTextBlack,
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
                                                      child: FittedBox(
                                                        fit: BoxFit.scaleDown,
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          'Type',
                                                          style:
                                                              subtitleTextBlack,
                                                        ),
                                                      ),
                                                    ),
                                                    const Text(':'),
                                                    Expanded(
                                                      flex: 1,
                                                      child: FittedBox(
                                                        fit: BoxFit.scaleDown,
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                            '\t${(data.type == 0) ? "User" : "Non User"}',
                                                            style:
                                                                subtitleTextBlack),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: IconButton(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ComponentUpdateDriver(
                                                                uuid:
                                                                    data.idStr!,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        icon: SvgPicture.asset(
                                                          'assets/images/edit.svg',
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // Padding(
                                        //   padding: EdgeInsets.symmetric(
                                        //       vertical: 5, horizontal: 10),
                                        //   child: Row(
                                        //     mainAxisAlignment: MainAxisAlignment.end,
                                        //     children: [
                                        //       WidgetButtonCustom(
                                        //           FullWidth: width * 0.25,
                                        //           FullHeight: 30,
                                        //           title: 'Scan BPTI',
                                        //           onpressed: () {
                                        //             Navigator.push(
                                        //               context,
                                        //               MaterialPageRoute(
                                        //                 builder: (context) =>
                                        //                     ComponentScanBPTI(),
                                        //               ),
                                        //             );
                                        //           },
                                        //           bgColor: PRIMARY_COLOR,
                                        //           color: Colors.transparent),
                                        //     ],
                                        //   ),
                                        // ),
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
