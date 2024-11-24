import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'component_rak_produksi.dart';
import 'component_tambah_produksi.dart';

class ComponentProduksi extends StatefulWidget {
  ComponentProduksi({super.key});

  @override
  State<ComponentProduksi> createState() => _ComponentProduksiState();
}

class _ComponentProduksiState extends State<ComponentProduksi> {
  List<bool> check = [true, false];
  bool non = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: WidgetAppbar(
        title: 'C2H2',
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
                  builder: (context) => ComponentTambahProduksi(),
                ),
              );
            },
            icon: Icon(
              Icons.add_circle_outline_rounded,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Container(
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
                    child: ListView.builder(
                      itemCount: check.length,
                      itemBuilder: (context, index) {
                        final data = check[index];
                        return Container(
                          width: double.maxFinite,
                          height: height * 0.2,
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
                                            0.55, // Lebar hingga setengah layar
                                        height: double.infinity,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.05),
                                        decoration: const BoxDecoration(
                                          color: SECONDARY_COLOR, // Warna hijau
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(30),
                                          ),
                                        ),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            "Non Active",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Bagian biru (No. 12345)
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        width:
                                            width * 0.3, // 30% dari lebar layar
                                        height: double.infinity,
                                        decoration: const BoxDecoration(
                                          color: Color(
                                              0xFF12163A), // Warna biru tua
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(30),
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          'ACETYLENE',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Bagian kanan (TW: 36.8)
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        width: width * 0.3,
                                        padding: EdgeInsets.only(
                                            right: width * 0.02),
                                        child: FittedBox(
                                          child: Text(
                                            '12 Agustus 2024 | 10.30.00',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
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
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(3),
                                                      child: FittedBox(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          'Nama Produksi',
                                                          style:
                                                              subtitleTextBlack,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5),
                                                      child: Text(
                                                          ': Lorem Ipsum Siamet',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              subtitleTextBlack),
                                                    ),
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
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(3),
                                                      child: FittedBox(
                                                        child: Text(
                                                          'Jenis Produksi',
                                                          style:
                                                              subtitleTextBlack,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5),
                                                      child: Text(': Stokies',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              subtitleTextBlack),
                                                    ),
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
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(3),
                                                      child: FittedBox(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          'Shift Operatur',
                                                          style:
                                                              subtitleTextBlack,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5),
                                                      child: Text(': Shift 1',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              subtitleTextBlack),
                                                    ),
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
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      child: FittedBox(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          'Create by user 1',
                                                          style:
                                                              subtitleTextBlack,
                                                        ),
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
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    bottom: height * 0.005,
                                                    right: width * 0.01),
                                                child: CircularPercentIndicator(
                                                  radius: height *
                                                      0.04, // Ukuran radius lingkaran
                                                  lineWidth:
                                                      5.0, // Ketebalan garis progress
                                                  percent:
                                                      0.5, // Nilai progress (0.0 - 1.0)
                                                  center: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "50", // Angka persentase
                                                        style: TextStyle(
                                                          fontSize:
                                                              width * 0.04,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        "Lagi", // Teks di bawah angka
                                                        style: TextStyle(
                                                          fontSize:
                                                              width * 0.025,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  backgroundColor: Colors.grey
                                                      .shade300, // Warna background lingkaran
                                                  progressColor:
                                                      PRIMARY_COLOR, // Warna progress
                                                  circularStrokeCap:
                                                      CircularStrokeCap
                                                          .round, // Gaya ujung progress
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  bottom: height * 0.005,
                                                  right: width * 0.01),
                                              child: WidgetButtonCustom(
                                                  FullWidth: width * 0.3,
                                                  FullHeight: 25,
                                                  title: "Lanjut Produksi",
                                                  onpressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ComponentRakProduksi(),
                                                      ),
                                                    );
                                                  },
                                                  bgColor: PRIMARY_COLOR,
                                                  color: Colors.transparent),
                                            ),
                                          ],
                                        ),
                                      ))
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
                    child: ListView.builder(
                      itemCount: check.length,
                      itemBuilder: (context, index) {
                        final data = check[index];
                        return Container(
                          width: double.maxFinite,
                          height: height * 0.20,
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
                                            0.55, // Lebar hingga setengah layar
                                        height: double.infinity,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.05),
                                        decoration: const BoxDecoration(
                                          color: SECONDARY_COLOR, // Warna hijau
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(30),
                                          ),
                                        ),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            "Non Active",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Bagian biru (No. 12345)
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        width:
                                            width * 0.3, // 30% dari lebar layar
                                        height: double.infinity,
                                        decoration: const BoxDecoration(
                                          color: Color(
                                              0xFF12163A), // Warna biru tua
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(30),
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          'ACETYLENE',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Bagian kanan (TW: 36.8)
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        width: width * 0.3,
                                        padding: EdgeInsets.only(
                                            right: width * 0.02),
                                        child: FittedBox(
                                          child: Text(
                                            '12 Agustus 2024 | 10.30.00',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
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
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      child: FittedBox(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          'Nama Produksi',
                                                          style:
                                                              subtitleTextBlack,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      child: Text(
                                                          ': Lorem Ipsum Siamet',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              subtitleTextBlack),
                                                    ),
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
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      child: Text(
                                                        'Nomor PO',
                                                        style:
                                                            subtitleTextBlack,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      child: Text(': 0012',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              subtitleTextBlack),
                                                    ),
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
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      child: FittedBox(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          'Nama Client',
                                                          style:
                                                              subtitleTextBlack,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      child: Text(
                                                          ': PT Lorem Ipsum Siamet',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              subtitleTextBlack),
                                                    ),
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
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      child: FittedBox(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          'Jumlah Tabung',
                                                          style:
                                                              subtitleTextBlack,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      child: Text(': 100',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              subtitleTextBlack),
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
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    bottom: height * 0.005,
                                                    right: width * 0.01),
                                                child: CircularPercentIndicator(
                                                  radius: height *
                                                      0.04, // Ukuran radius lingkaran
                                                  lineWidth:
                                                      5.0, // Ketebalan garis progress
                                                  percent:
                                                      0.5, // Nilai progress (0.0 - 1.0)
                                                  center: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "50", // Angka persentase
                                                        style: TextStyle(
                                                          fontSize:
                                                              width * 0.04,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        "Lagi", // Teks di bawah angka
                                                        style: TextStyle(
                                                          fontSize:
                                                              width * 0.025,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  backgroundColor: Colors.grey
                                                      .shade300, // Warna background lingkaran
                                                  progressColor:
                                                      PRIMARY_COLOR, // Warna progress
                                                  circularStrokeCap:
                                                      CircularStrokeCap
                                                          .round, // Gaya ujung progress
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  bottom: height * 0.005,
                                                  right: width * 0.01),
                                              child: WidgetButtonCustom(
                                                  FullWidth: width * 0.3,
                                                  FullHeight: 25,
                                                  title: "Lanjut Produksi",
                                                  onpressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ComponentRakProduksi(),
                                                      ),
                                                    );
                                                  },
                                                  bgColor: PRIMARY_COLOR,
                                                  color: Colors.transparent),
                                            ),
                                          ],
                                        ),
                                      ))
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
    );
  }
}
