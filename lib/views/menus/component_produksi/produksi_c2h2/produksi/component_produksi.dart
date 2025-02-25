import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/providers/provider_produksi.dart';
import 'package:dwigasindo/views/menus/component_produksi/produksi_c2h2/produksi/component_detail_rak_mix_gas.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import 'component_rak_produksi.dart';
import 'component_tambah_produksi.dart';

class ComponentProduksi extends StatefulWidget {
  ComponentProduksi({super.key, required this.title});
  String title;

  @override
  State<ComponentProduksi> createState() => _ComponentProduksiState();
}

class _ComponentProduksiState extends State<ComponentProduksi> {
  List<bool> check = [true, false];
  bool non = false;
  GroupButtonController? menu = GroupButtonController(selectedIndex: 0);

  @override
  void initState() {
    // TODO: implement initState
    awaitData();
    super.initState();
  }

  Future<void> awaitData() async {
    final provider = Provider.of<ProviderProduksi>(context, listen: false);
    await provider.getAllProduksi(context);
    await provider.getAllMixGas(context);
    final providerGas = Provider.of<ProviderDistribusi>(context, listen: false);
    providerGas.getAllTubeGas(context);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.title);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderProduksi>(context);
    final providerD = Provider.of<ProviderDistribusi>(context);

    return Scaffold(
      appBar: WidgetAppbar(
        title: widget.title,
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ComponentTambahProduksi(
                    title: widget.title,
                  ),
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
          : (widget.title == 'High Pressure & Mix Gas')
              ? mix_gas_produksi(width, height, provider, providerD)
              : c2h2_produksi(width, height, provider, providerD),
    );
  }

  Container c2h2_produksi(double width, double height,
      ProviderProduksi provider, ProviderDistribusi providerD) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 20),
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
          Align(
            alignment: Alignment.centerLeft,
            child: GroupButton(
                isRadio: true,
                controller: menu,
                options: GroupButtonOptions(
                  selectedColor: PRIMARY_COLOR,
                  borderRadius: BorderRadius.circular(8),
                ),
                onSelected: (value, index, isSelected) {
                  print('DATA KLIK : $value - $index - $isSelected');
                  if (index == 1) {
                    setState(() {
                      non = true;
                    });
                  } else {
                    setState(() {
                      non = false;
                    });
                  }
                },
                buttons: ['List PO', "List Non PO", 'History']),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          (non == true)
              ? Expanded(
                  child: (provider.allProduksi?.data?.length == 0)
                      ? Center(
                          child: Text(
                            'Belum terdapat data',
                            style: titleTextBlack,
                          ),
                        )
                      : ListView.builder(
                          itemCount: provider.allProduksi?.data?.length,
                          itemBuilder: (context, index) {
                            final data = provider.allProduksi?.data?[index];
                            return (data?.type == 0)
                                ? Container(
                                    width: width,
                                    height: height * 0.6,
                                    margin:
                                        EdgeInsets.only(bottom: height * 0.02),
                                    child: Center(
                                      child: Text(
                                        'Belum terdapat data',
                                        style: titleTextBlack,
                                      ),
                                    ),
                                  )
                                : Container(
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
                                        Container(
                                          width: double.maxFinite,
                                          height: 40,
                                          child: Stack(
                                            children: [
                                              // Bagian hijau (OK)
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Container(
                                                  width: width *
                                                      0.525, // Lebar hingga setengah layar
                                                  height: double.infinity,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: width * 0.05),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color:
                                                        SECONDARY_COLOR, // Warna hijau
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(8),
                                                      bottomRight:
                                                          Radius.circular(30),
                                                    ),
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                        "${data?.isActive == 0 ? 'Non Active' : 'Active'}",
                                                        style: subtitleText),
                                                  ),
                                                ),
                                              ),

                                              // Bagian biru (No. 12345)
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Container(
                                                  width: width *
                                                      0.3, // 30% dari lebar layar
                                                  height: double.infinity,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color(
                                                        0xFF12163A), // Warna biru tua
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(8),
                                                      bottomRight:
                                                          Radius.circular(30),
                                                    ),
                                                  ),
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  child: Text(data!.name!,
                                                      style: titleText),
                                                ),
                                              ),

                                              // Bagian kanan (TW: 36.8)
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Container(
                                                  width: width * 0.35,
                                                  padding: EdgeInsets.only(
                                                      right: width * 0.02),
                                                  child: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: Text(
                                                        "${providerD.formatDate(data.createdAt.toString())} | ${providerD.formatTime(data.createdAt.toString())}",
                                                        style:
                                                            subtitleTextBlack),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
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
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Column(
                                                    children: [
                                                      Expanded(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Expanded(
                                                              flex: 2,
                                                              child: FittedBox(
                                                                fit: BoxFit
                                                                    .scaleDown,
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  'Nama Produksi',
                                                                  style:
                                                                      subtitleTextBlack,
                                                                ),
                                                              ),
                                                            ),
                                                            const Text(':'),
                                                            Expanded(
                                                              flex: 3,
                                                              child: Text(
                                                                  '\t${(data.name == '') ? '-' : data.name}',
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      subtitleTextBlack),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 2,
                                                              child: FittedBox(
                                                                fit: BoxFit
                                                                    .scaleDown,
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  'Jenis Produksi',
                                                                  style:
                                                                      subtitleTextBlack,
                                                                ),
                                                              ),
                                                            ),
                                                            Text(':'),
                                                            Expanded(
                                                              flex: 3,
                                                              child: Text(
                                                                  '\t${(data.type == 0) ? 'PO' : "Stokies"}',
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      subtitleTextBlack),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 2,
                                                              child: FittedBox(
                                                                fit: BoxFit
                                                                    .scaleDown,
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  'Shift Operatur',
                                                                  style:
                                                                      subtitleTextBlack,
                                                                ),
                                                              ),
                                                            ),
                                                            Text(':'),
                                                            Expanded(
                                                              flex: 3,
                                                              child: Text(
                                                                  '\t${data.idStr}',
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      subtitleTextBlack),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 2,
                                                              child: FittedBox(
                                                                fit: BoxFit
                                                                    .scaleDown,
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  'Create by ${(data.createdByName == '') ? '-' : data.createdByName}',
                                                                  style:
                                                                      subtitleTextBlack,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Expanded(
                                                          child:
                                                              CircularPercentIndicator(
                                                            radius: height *
                                                                0.04, // Ukuran radius lingkaran
                                                            lineWidth:
                                                                5.0, // Ketebalan garis progress
                                                            percent: data
                                                                    .tubeCompleted!
                                                                    .toDouble() /
                                                                100.0, // Nilai progress (0.0 - 1.0)
                                                            center: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                    "${data.tubeQty!.toInt() - data.tubeCompleted!}", // Angka persentase
                                                                    style:
                                                                        subtitleTextBlack),
                                                                Text(
                                                                    "Lagi", // Teks di bawah angka
                                                                    style:
                                                                        subtitleTextNormal),
                                                              ],
                                                            ),
                                                            backgroundColor: Colors
                                                                .grey
                                                                .shade300, // Warna background lingkaran
                                                            progressColor:
                                                                PRIMARY_COLOR, // Warna progress
                                                            circularStrokeCap:
                                                                CircularStrokeCap
                                                                    .round, // Gaya ujung progress
                                                          ),
                                                        ),
                                                        WidgetButtonCustom(
                                                            FullWidth:
                                                                width * 0.3,
                                                            FullHeight: 25,
                                                            title: "Lanjut",
                                                            onpressed:
                                                                () async {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          ComponentRakProduksi(
                                                                    id: data
                                                                        .id!,
                                                                    title: widget
                                                                        .title,
                                                                    idStr: data
                                                                        .idStr!,
                                                                  ),
                                                                ),
                                                              );
                                                              await provider
                                                                  .getAllRak(
                                                                      context);
                                                            },
                                                            bgColor:
                                                                PRIMARY_COLOR,
                                                            color: Colors
                                                                .transparent),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                          },
                        ),
                )
              : Expanded(
                  child: (provider.allProduksi?.data?.length == 0)
                      ? Center(
                          child: Text(
                            'Belum terdapat data',
                            style: titleTextBlack,
                          ),
                        )
                      : ListView.builder(
                          itemCount: provider.allProduksi?.data?.length,
                          itemBuilder: (context, index) {
                            final data = provider.allProduksi?.data?[index];
                            return Container(
                              width: double.maxFinite,
                              height: height * 0.20,
                              margin: EdgeInsets.only(bottom: height * 0.02),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
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
                                    child: Stack(
                                      children: [
                                        // Bagian hijau (OK)
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            width: width *
                                                0.525, // Lebar hingga setengah layar
                                            height: double.infinity,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width * 0.05),
                                            decoration: BoxDecoration(
                                              color:
                                                  SECONDARY_COLOR, // Warna hijau
                                              borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(30),
                                                topLeft: Radius.circular(8),
                                              ),
                                            ),
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                  "${data?.isActive == 0 ? 'Non Active' : 'Active'}",
                                                  style: subtitleText),
                                            ),
                                          ),
                                        ),

                                        // Bagian biru (No. 12345)
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            width: width *
                                                0.3, // 30% dari lebar layar
                                            height: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Color(
                                                  0xFF12163A), // Warna biru tua
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(8),
                                                bottomRight:
                                                    Radius.circular(30),
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              '${data!.name}',
                                              style: titleText,
                                            ),
                                          ),
                                        ),

                                        // Bagian kanan (TW: 36.8)
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            width: width * 0.25,
                                            padding: EdgeInsets.only(
                                                right: width * 0.02),
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                  '${providerD.formatDate(data.createdAt.toString())} | ${providerD.formatTime(data.createdAt.toString())}',
                                                  style: subtitleTextNormal),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.02,
                                          vertical: height * 0.01),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                              color: Colors.grey.shade300),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            'Nama Produksi',
                                                            style:
                                                                subtitleTextBlack,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(':'),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                            '\t${data.name}',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                subtitleTextBlack),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                          'Nomor PO',
                                                          style:
                                                              subtitleTextBlack,
                                                        ),
                                                      ),
                                                      Text(':'),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                            '\t${data.poNum}',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                subtitleTextBlack),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            'Nama Client',
                                                            style:
                                                                subtitleTextBlack,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(':'),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                            '\t${data.customerName}',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                subtitleTextBlack),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            'Jumlah',
                                                            style:
                                                                subtitleTextBlack,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(':'),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                            '\t${data.tubeQty}',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                subtitleTextBlack),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child:
                                                        CircularPercentIndicator(
                                                      radius: height *
                                                          0.04, // Ukuran radius lingkaran
                                                      lineWidth:
                                                          5.0, // Ketebalan garis progress
                                                      percent: data
                                                              .tubeCompleted!
                                                              .toDouble() /
                                                          100.0, // Nilai progress (0.0 - 1.0)
                                                      center: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                              "${data.tubeQty!.toInt() - data.tubeCompleted!}", // Angka persentase
                                                              style:
                                                                  subtitleTextBlack),
                                                          Text(
                                                              "Lagi", // Teks di bawah angka
                                                              style:
                                                                  subtitleTextNormal),
                                                        ],
                                                      ),
                                                      backgroundColor: Colors
                                                          .grey
                                                          .shade300, // Warna background lingkaran
                                                      progressColor:
                                                          PRIMARY_COLOR, // Warna progress
                                                      circularStrokeCap:
                                                          CircularStrokeCap
                                                              .round, // Gaya ujung progress
                                                    ),
                                                  ),
                                                  WidgetButtonCustom(
                                                      FullWidth: width * 0.3,
                                                      FullHeight: 25,
                                                      title: "Lanjut",
                                                      onpressed: () async {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                ComponentRakProduksi(
                                                                    id: data
                                                                        .id!,
                                                                    title: widget
                                                                        .title,
                                                                    idStr: data
                                                                        .idStr!),
                                                          ),
                                                        );
                                                        await provider
                                                            .getAllRak(context);
                                                      },
                                                      bgColor: PRIMARY_COLOR,
                                                      color:
                                                          Colors.transparent),
                                                ],
                                              ),
                                            ),
                                          ),
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
    );
  }

  Container mix_gas_produksi(double width, double height,
      ProviderProduksi provider, ProviderDistribusi providerD) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 20),
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
                      preicon: Icon(
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
                    icon: Icon(
                      Icons.filter_list,
                      color: Colors.white,
                    ),
                  ),
                )),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: GroupButton(
                isRadio: true,
                controller: menu,
                options: GroupButtonOptions(
                  selectedColor: PRIMARY_COLOR,
                  borderRadius: BorderRadius.circular(8),
                ),
                onSelected: (value, index, isSelected) {
                  print('DATA KLIK : $value - $index - $isSelected');
                  if (index == 1) {
                    setState(() {
                      non = true;
                    });
                  } else {
                    setState(() {
                      non = false;
                    });
                  }
                },
                buttons: ['List PO', "List Non PO", 'History']),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          (non == true)
              ? Expanded(
                  child: (provider.allMixGas?.data?.length == null)
                      ? Center(
                          child: Text(
                            'Belum terdapat data',
                            style: titleTextBlack,
                          ),
                        )
                      : ListView.builder(
                          itemCount: provider.allProduksi?.data?.length,
                          itemBuilder: (context, index) {
                            final data = provider.allProduksi?.data?[index];
                            return (data?.type == 0)
                                ? Container(
                                    width: width,
                                    height: height * 0.6,
                                    margin:
                                        EdgeInsets.only(bottom: height * 0.02),
                                    child: Center(
                                      child: Text(
                                        'Belum terdapat data',
                                        style: titleTextBlack,
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: double.maxFinite,
                                    height: height * 0.2,
                                    margin:
                                        EdgeInsets.only(bottom: height * 0.02),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
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
                                          child: Stack(
                                            children: [
                                              // Bagian hijau (OK)
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Container(
                                                  width: width *
                                                      0.525, // Lebar hingga setengah layar
                                                  height: double.infinity,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: width * 0.05),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        SECONDARY_COLOR, // Warna hijau
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(8),
                                                      bottomRight:
                                                          Radius.circular(30),
                                                    ),
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                        "${data?.isActive == 0 ? 'Non Active' : 'Active'}",
                                                        style: subtitleText),
                                                  ),
                                                ),
                                              ),

                                              // Bagian biru (No. 12345)
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Container(
                                                  width: width *
                                                      0.3, // 30% dari lebar layar
                                                  height: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: Color(
                                                        0xFF12163A), // Warna biru tua
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(8),
                                                      bottomRight:
                                                          Radius.circular(30),
                                                    ),
                                                  ),
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  child: Text(data!.name!,
                                                      style: titleText),
                                                ),
                                              ),

                                              // Bagian kanan (TW: 36.8)
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Container(
                                                  width: width * 0.35,
                                                  padding: EdgeInsets.only(
                                                      right: width * 0.02),
                                                  child: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: Text(
                                                        "${providerD.formatDate(data.createdAt.toString())} | ${providerD.formatTime(data.createdAt.toString())}",
                                                        style:
                                                            subtitleTextBlack),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
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
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Column(
                                                    children: [
                                                      Expanded(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Expanded(
                                                              flex: 2,
                                                              child: FittedBox(
                                                                fit: BoxFit
                                                                    .scaleDown,
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  'Nama Produksi',
                                                                  style:
                                                                      subtitleTextBlack,
                                                                ),
                                                              ),
                                                            ),
                                                            Text(':'),
                                                            Expanded(
                                                              flex: 3,
                                                              child: Text(
                                                                  '\t${(data.name == '') ? '-' : data.name}',
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      subtitleTextBlack),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 2,
                                                              child: FittedBox(
                                                                fit: BoxFit
                                                                    .scaleDown,
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  'Jenis Produksi',
                                                                  style:
                                                                      subtitleTextBlack,
                                                                ),
                                                              ),
                                                            ),
                                                            Text(':'),
                                                            Expanded(
                                                              flex: 3,
                                                              child: Text(
                                                                  '\t${(data.type == 0) ? 'PO' : "Stokies"}',
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      subtitleTextBlack),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 2,
                                                              child: FittedBox(
                                                                fit: BoxFit
                                                                    .scaleDown,
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  'Shift Operatur',
                                                                  style:
                                                                      subtitleTextBlack,
                                                                ),
                                                              ),
                                                            ),
                                                            Text(':'),
                                                            Expanded(
                                                              flex: 3,
                                                              child: Text(
                                                                  '\t${data.idStr}',
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      subtitleTextBlack),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 2,
                                                              child: FittedBox(
                                                                fit: BoxFit
                                                                    .scaleDown,
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  'Create by ${(data.createdByName == '') ? '-' : data.createdByName}',
                                                                  style:
                                                                      subtitleTextBlack,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Expanded(
                                                          child:
                                                              CircularPercentIndicator(
                                                            radius: height *
                                                                0.04, // Ukuran radius lingkaran
                                                            lineWidth:
                                                                5.0, // Ketebalan garis progress
                                                            percent: data
                                                                    .tubeCompleted!
                                                                    .toDouble() /
                                                                100.0, // Nilai progress (0.0 - 1.0)
                                                            center: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                    "${data.tubeQty!.toInt() - data.tubeCompleted!}", // Angka persentase
                                                                    style:
                                                                        subtitleTextBlack),
                                                                Text(
                                                                    "Lagi", // Teks di bawah angka
                                                                    style:
                                                                        subtitleTextNormal),
                                                              ],
                                                            ),
                                                            backgroundColor: Colors
                                                                .grey
                                                                .shade300, // Warna background lingkaran
                                                            progressColor:
                                                                PRIMARY_COLOR, // Warna progress
                                                            circularStrokeCap:
                                                                CircularStrokeCap
                                                                    .round, // Gaya ujung progress
                                                          ),
                                                        ),
                                                        WidgetButtonCustom(
                                                          FullWidth:
                                                              width * 0.3,
                                                          FullHeight: 25,
                                                          title: "Lanjut",
                                                          onpressed: () async {
                                                            if (!mounted)
                                                              return;

                                                            // Tampilkan Dialog Loading
                                                            showDialog(
                                                              context: context,
                                                              barrierDismissible:
                                                                  false,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return Center(
                                                                  child:
                                                                      CircularProgressIndicator(),
                                                                );
                                                              },
                                                            );

                                                            try {
                                                              final id = await provider
                                                                  .checkRakMixGas(
                                                                      context,
                                                                      data.idStr!);
                                                              print(id);
                                                              await Future
                                                                  .wait([
                                                                provider
                                                                    .getAllItem(
                                                                        context),
                                                                provider
                                                                    .getAllMixGroupRak(
                                                                        context),
                                                                provider
                                                                    .getAllMixRak(
                                                                        context),
                                                                provider
                                                                    .getAllTank(
                                                                        context),
                                                                provider
                                                                    .getAllVendor(
                                                                        context),
                                                                provider
                                                                    .getAllTubeGas(
                                                                        context),
                                                              ]);
                                                              // Navigate sesuai kondisi
                                                              if (id == 0) {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(); // Tutup Dialog Loading
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            ComponentRakProduksi(
                                                                      id: data
                                                                          .id!,
                                                                      title: widget
                                                                          .title,
                                                                      idStr: data
                                                                          .idStr!,
                                                                    ),
                                                                  ),
                                                                );
                                                              } else {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(); // Tutup Dialog Loading
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            ComponentDetailRakMixGas(
                                                                      title: widget
                                                                          .title,
                                                                      idStr: data
                                                                          .idStr,
                                                                      idRak: id,
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                            } catch (e) {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(); // Tutup Dialog Loading
                                                              print(
                                                                  'Error: $e');
                                                              // Tambahkan pesan error jika perlu
                                                            }
                                                          },
                                                          bgColor:
                                                              PRIMARY_COLOR,
                                                          color: Colors
                                                              .transparent,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                          },
                        ),
                )
              : Expanded(
                  child: (provider.allMixGas?.data?.length == null)
                      ? Center(
                          child: Text(
                            'Belum terdapat data',
                            style: titleTextBlack,
                          ),
                        )
                      : ListView.builder(
                          itemCount: provider.allMixGas?.data?.length,
                          itemBuilder: (context, index) {
                            final data = provider.allMixGas?.data?[index];
                            return Container(
                              width: double.maxFinite,
                              height: height * 0.20,
                              margin: EdgeInsets.only(bottom: height * 0.02),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
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
                                    child: Stack(
                                      children: [
                                        // Bagian hijau (OK)
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            width: width *
                                                0.525, // Lebar hingga setengah layar
                                            height: double.infinity,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width * 0.05),
                                            decoration: BoxDecoration(
                                              color:
                                                  SECONDARY_COLOR, // Warna hijau
                                              borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(30),
                                                topLeft: Radius.circular(8),
                                              ),
                                            ),
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                  "${data?.isActive == 0 ? 'Non Active' : 'Active'}",
                                                  style: subtitleText),
                                            ),
                                          ),
                                        ),

                                        // Bagian biru (No. 12345)
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            width: width *
                                                0.3, // 30% dari lebar layar
                                            height: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Color(
                                                  0xFF12163A), // Warna biru tua
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(8),
                                                bottomRight:
                                                    Radius.circular(30),
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              '${data!.name}',
                                              style: titleText,
                                            ),
                                          ),
                                        ),

                                        // Bagian kanan (TW: 36.8)
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            width: width * 0.25,
                                            padding: EdgeInsets.only(
                                                right: width * 0.02),
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                  '${providerD.formatDate(data.createdAt.toString())} | ${providerD.formatTime(data.createdAt.toString())}',
                                                  style: subtitleTextNormal),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.02,
                                          vertical: height * 0.01),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                              color: Colors.grey.shade300),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            'Nama Produksi',
                                                            style:
                                                                subtitleTextBlack,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(':'),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                            '\t${data.name}',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                subtitleTextBlack),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                          'Nomor PO',
                                                          style:
                                                              subtitleTextBlack,
                                                        ),
                                                      ),
                                                      Text(':'),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                            '\t${data.poNum}',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                subtitleTextBlack),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            'Nama Client',
                                                            style:
                                                                subtitleTextBlack,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(':'),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                            '\t${data.customerName}',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                subtitleTextBlack),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            'Jumlah',
                                                            style:
                                                                subtitleTextBlack,
                                                          ),
                                                        ),
                                                      ),
                                                      const Text(':'),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                            '\t${data.tubeQty}',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                subtitleTextBlack),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child:
                                                        CircularPercentIndicator(
                                                      radius: height *
                                                          0.04, // Ukuran radius lingkaran
                                                      lineWidth:
                                                          5.0, // Ketebalan garis progress
                                                      percent: data
                                                              .tubeCompleted!
                                                              .toDouble() /
                                                          100.0, // Nilai progress (0.0 - 1.0)
                                                      center: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                              "${data.tubeQty!.toInt() - data.tubeCompleted!}", // Angka persentase
                                                              style:
                                                                  subtitleTextBlack),
                                                          Text(
                                                              "Lagi", // Teks di bawah angka
                                                              style:
                                                                  subtitleTextNormal),
                                                        ],
                                                      ),
                                                      backgroundColor: Colors
                                                          .grey
                                                          .shade300, // Warna background lingkaran
                                                      progressColor:
                                                          PRIMARY_COLOR, // Warna progress
                                                      circularStrokeCap:
                                                          CircularStrokeCap
                                                              .round, // Gaya ujung progress
                                                    ),
                                                  ),
                                                  WidgetButtonCustom(
                                                    FullWidth: width * 0.3,
                                                    FullHeight: 25,
                                                    title: "Lanjut",
                                                    onpressed: () async {
                                                      if (!mounted) return;

                                                      // Tampilkan Dialog Loading
                                                      showDialog(
                                                        context: context,
                                                        barrierDismissible:
                                                            false,
                                                        builder: (BuildContext
                                                            context) {
                                                          return Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          );
                                                        },
                                                      );

                                                      try {
                                                        final id = await provider
                                                            .checkRakMixGas(
                                                                context,
                                                                data.idStr!);
                                                        await Future.wait([
                                                          provider.getAllItem(
                                                              context),
                                                          provider
                                                              .getAllMixGroupRak(
                                                                  context),
                                                          provider.getAllMixRak(
                                                              context),
                                                          provider.getAllTank(
                                                              context),
                                                          provider.getAllVendor(
                                                              context),
                                                          provider
                                                              .getAllTubeGas(
                                                                  context),
                                                        ]);

                                                        // Navigate sesuai kondisi
                                                        if (id == 0) {
                                                          Navigator.of(context)
                                                              .pop(); // Tutup Dialog Loading
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ComponentRakProduksi(
                                                                id: data.id!,
                                                                title: widget
                                                                    .title,
                                                                idStr:
                                                                    data.idStr!,
                                                              ),
                                                            ),
                                                          );
                                                        } else {
                                                          Navigator.of(context)
                                                              .pop(); // Tutup Dialog Loading
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ComponentDetailRakMixGas(
                                                                title: widget
                                                                    .title,
                                                                idStr:
                                                                    data.idStr,
                                                                idRak: id,
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      } catch (e) {
                                                        Navigator.of(context)
                                                            .pop(); // Tutup Dialog Loading
                                                        print('Error: $e');
                                                        // Tambahkan pesan error jika perlu
                                                      }
                                                    },
                                                    bgColor: PRIMARY_COLOR,
                                                    color: Colors.transparent,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
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
    );
  }
}
