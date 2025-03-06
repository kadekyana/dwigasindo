import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/views/menus/component_distribusi/componentBPTK/component_detail_bpti.dart';
import 'package:dwigasindo/views/menus/component_distribusi/componentBPTK/component_scan_bpti.dart';
import 'package:dwigasindo/views/menus/component_distribusi/componentBPTK/component_tambah_bpti.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ComponentBPTI extends StatefulWidget {
  const ComponentBPTI({super.key});

  @override
  State<ComponentBPTI> createState() => _ComponentBPTIState();
}

class _ComponentBPTIState extends State<ComponentBPTI> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ProviderDistribusi>(context, listen: false);
      provider.getAllBPTI(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final provider = Provider.of<ProviderDistribusi>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: WidgetAppbar(
        title: 'BPTI',
        sizefont: 15,
        center: true,
        colorTitle: Colors.black,
        colorBack: Colors.black,
        colorBG: Colors.grey.shade100,
        back: true,
        route: () {
          Navigator.pop(context);
        },
      ),
      body: (provider.isLoadingTI == true)
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
                          title: 'Buat BPTI',
                          onpressed: () async {
                            if (!mounted) return;

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
                                provider.getAllCostumer(context),
                                provider.getAllBPTK(context),
                              ]);

                              // Navigate sesuai kondisi
                              Navigator.of(context)
                                  .pop(); // Tutup Dialog Loading
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ComponentBuatBPTI(),
                                ),
                              );
                            } catch (e) {
                              Navigator.of(context)
                                  .pop(); // Tutup Dialog Loading
                              print('Error: $e');
                              // Tambahkan pesan error jika perlu
                            }
                          },
                          bgColor: PRIMARY_COLOR,
                          color: PRIMARY_COLOR),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: provider.allBpti?.data!.length,
                          itemBuilder: (context, index) {
                            final data = provider.allBpti?.data![index];
                            return GestureDetector(
                              onTap: () async {
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
                                    provider.getDetailBpti(context, data.no!),
                                  ]);

                                  // Navigate sesuai kondisi
                                  Navigator.of(context)
                                      .pop(); // Tutup Dialog Loading
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ComponentDetailBpti(),
                                    ),
                                  );
                                } catch (e) {
                                  Navigator.of(context)
                                      .pop(); // Tutup Dialog Loading
                                  print('Error: $e');
                                  // Tambahkan pesan error jika perlu
                                }
                              },
                              child: Container(
                                width: double.maxFinite,
                                height: height * 0.165,
                                margin: EdgeInsets.only(bottom: height * 0.02),
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
                                      height: 40.h,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            width: width * 0.35,
                                            decoration: const BoxDecoration(
                                              color: PRIMARY_COLOR,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(8),
                                                bottomRight:
                                                    Radius.circular(40),
                                              ),
                                            ),
                                            child: Text(
                                              'Sedang Diproses',
                                              style: subtitleTextNormalwhite,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(right: 5.w),
                                            width: width * 0.35,
                                            child: Text(
                                              '23-09-2024 | 10:30:00',
                                              style: subtitleTextBlack,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                                color: Colors.grey.shade300),
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Expanded(
                                                child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                '${data!.no}',
                                                style: subtitleTextBlack,
                                              ),
                                            )),
                                            Expanded(
                                                child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    'Dibuat Oleh',
                                                    style: subtitleTextBlack,
                                                  ),
                                                ),
                                                Text(
                                                  " : ",
                                                  style: subtitleTextBlack,
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Text('Andi Muhammad',
                                                      style: subtitleTextBlack),
                                                )
                                              ],
                                            )),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5.h, horizontal: 10.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          WidgetButtonCustom(
                                              FullWidth: width * 0.25,
                                              FullHeight: 30,
                                              title: 'Scan BPTI',
                                              onpressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ComponentScanBPTI(
                                                      noBPTI: data.no!,
                                                    ),
                                                  ),
                                                );
                                              },
                                              bgColor: PRIMARY_COLOR,
                                              color: Colors.transparent),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
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
