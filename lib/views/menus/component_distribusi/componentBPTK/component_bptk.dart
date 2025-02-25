import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/views/menus/component_distribusi/componentBPTK/component_detail.dart';
import 'package:dwigasindo/views/menus/component_distribusi/componentBPTK/component_tambah_distribusi.dart';
import 'package:dwigasindo/views/menus/component_distribusi/componentTabung/component_verifikasi.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ComponentBPTK extends StatefulWidget {
  const ComponentBPTK({super.key});

  @override
  State<ComponentBPTK> createState() => _ComponentBPTKState();
}

class _ComponentBPTKState extends State<ComponentBPTK> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ProviderDistribusi>(context, listen: false);
      provider.getAllBPTK(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final provider = Provider.of<ProviderDistribusi>(context);
    final dataBPTK = provider.bptk?.data;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      resizeToAvoidBottomInset: false,
      appBar: WidgetAppbar(
        title: 'Bukti Penerimaan Tabung Kosong',
        sizefont: 15,
        center: true,
        colorTitle: Colors.black,
        colorBack: Colors.black,
        colorBG: Colors.grey.shade100,
        back: true,
        route: () {
          Navigator.pop(context);
        },
        actions: [
          IconButton(
            onPressed: () async {
              await provider.getAllCostumer(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ComponentTambah(),
                ),
              );
            },
            icon: const Icon(
              Icons.add_circle_outline_rounded,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: (provider.isLoading == true)
          ? const Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
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
                      SizedBox(
                        width: double.maxFinite,
                        height: height * 0.1,
                        child: Row(
                          children: [
                            // Search bar
                            Expanded(
                              flex: 6,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade400,
                                    ),
                                    borderRadius: BorderRadius.circular(16)),
                                child: WidgetForm(
                                  alert: 'Search',
                                  hint: 'Search',
                                  border: InputBorder.none,
                                  preicon: const Icon(
                                    Icons.search_rounded,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            // filter bar
                            Expanded(
                                child: Container(
                              decoration: BoxDecoration(
                                color: PRIMARY_COLOR,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.filter_list,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                          ],
                        ),
                      ),
                      // list data
                      SizedBox(
                        width: double.maxFinite,
                        height: height * 0.05,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: provider.dataBPTK.length,
                            itemBuilder: (context, index) {
                              final data = provider.dataBPTK[index];
                              return Container(
                                width: width * 0.25,
                                padding: EdgeInsets.all(width * 0.025),
                                margin: EdgeInsets.only(right: width * 0.01),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: const Color(0xffE5E7EB)),
                                  color: const Color(0xffF9FAFB),
                                ),
                                child: FittedBox(
                                  child: Text(
                                    data,
                                    style: titleTextBlack,
                                  ),
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: dataBPTK!.length,
                          itemBuilder: (context, index) {
                            final data = dataBPTK[index];
                            return Container(
                              width: double.maxFinite,
                              height: height * 0.28,
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
                                    height: 40,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          width: width * 0.3,
                                          decoration: const BoxDecoration(
                                            color: PRIMARY_COLOR,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              bottomRight: Radius.circular(30),
                                            ),
                                          ),
                                          child: FittedBox(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              '${data.no}',
                                              style: titleText,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          width: width * 0.3,
                                          child: FittedBox(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              ' ${(data.vehicleNumber == null) ? "-" : data.vehicleNumber}',
                                              style: titleTextBlack,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.symmetric(
                                          horizontal: BorderSide(
                                              color: Colors.grey.shade300),
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
                                                  padding:
                                                      const EdgeInsets.all(6),
                                                  child: const FittedBox(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      'Sumber TK',
                                                      style: titleTextBlack,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(6),
                                                  child: const FittedBox(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(': Client',
                                                        style: titleTextBlack),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )),
                                          Expanded(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(6),
                                                  child: const FittedBox(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      'Tanggal',
                                                      style: titleTextBlack,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(6),
                                                  child: FittedBox(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                        ': ${provider.formatDate(data.createdAt.toString())}',
                                                        style: titleTextBlack),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )),
                                          Expanded(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(6),
                                                  child: const FittedBox(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      'Jenis Gas',
                                                      style: titleTextBlack,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(6),
                                                  child: FittedBox(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                        ': ${(data.gasType == null) ? "-" : data.gasType}',
                                                        style: titleTextBlack),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )),
                                          Expanded(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(6),
                                                  child: const FittedBox(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      'Jumlah Tabung',
                                                      style: titleTextBlack,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(6),
                                                  child: FittedBox(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                        ': ${data.gasCount}',
                                                        style: titleTextBlack),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )),
                                          Expanded(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(6),
                                                  child: FittedBox(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      '${provider.formatDate(data.createdAt.toString())} | ${provider.formatTime(data.createdAt.toString())}',
                                                      style: TextStyle(
                                                        fontFamily: 'Manrope',
                                                        color: Colors
                                                            .grey.shade400,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(),
                                              )
                                            ],
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          WidgetButtonCustom(
                                              FullWidth: width * 0.25,
                                              FullHeight: 30,
                                              title: 'Detail',
                                              onpressed: () async {
                                                provider.clearCount('countT');
                                                provider.getVerifikasiBPTK(
                                                    context, data.no!);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ComponentDetail(
                                                      uuid: data.no!,
                                                    ),
                                                  ),
                                                );
                                              },
                                              bgColor: PRIMARY_COLOR,
                                              color: Colors.transparent),
                                          WidgetButtonCustom(
                                              FullWidth: width * 0.25,
                                              FullHeight: 30,
                                              title: 'Ubah',
                                              onpressed: () {},
                                              bgColor: COMPLEMENTARY_COLOR1,
                                              color: Colors.transparent),
                                          WidgetButtonCustom(
                                              FullWidth: width * 0.25,
                                              FullHeight: 30,
                                              title: 'Verifikasi',
                                              onpressed: () {
                                                provider.clearCount('countT');
                                                provider.getVerifikasiBPTK(
                                                    context, data.no!);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ComponentVerifikasi(
                                                      noBptk: data.no!,
                                                    ),
                                                  ),
                                                );
                                              },
                                              bgColor: SECONDARY_COLOR,
                                              color: Colors.transparent),
                                        ],
                                      ),
                                    ),
                                  ),
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
