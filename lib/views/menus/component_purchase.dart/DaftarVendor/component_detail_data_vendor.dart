import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:group_button/group_button.dart';

class ComponentDetailDataVendor extends StatefulWidget {
  const ComponentDetailDataVendor({super.key});

  @override
  State<ComponentDetailDataVendor> createState() =>
      _ComponentDetailDataVendorState();
}

class _ComponentDetailDataVendorState extends State<ComponentDetailDataVendor>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Map<String, dynamic>> historyPOData = [
    {
      'tanggal': '27 Sep 2024',
      'nomorPO': '23032321',
      'vendor': 'Lorem Ipsum',
      'kategori': 'Bahan Baku',
      'status': 'Approve',
      'keterangan': 'Create by user 1',
      'aspekKualitas': 7,
      'aspekPengiriman': 7,
      'aspekKerjaSama': 7,
    },
    {
      'tanggal': '15 Okt 2024',
      'nomorPO': '12345678',
      'vendor': 'Dolor Sit',
      'kategori': 'Peralatan',
      'status': 'Pending',
      'keterangan': 'Create by user 2',
      'aspekKualitas': 6,
      'aspekPengiriman': 8,
      'aspekKerjaSama': 7,
    },
  ];

  // Variabel untuk menyimpan PO yang dipilih
  Map<String, dynamic>? selectedPO;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // 3 tabs
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: WidgetAppbar(
        title: 'Data Vendor',
        center: true,
        colorTitle: Colors.black,
        colorBack: Colors.black,
        colorBG: Colors.grey.shade100,
        back: true,
        route: () {
          if (selectedPO != null) {
            // Kembali ke daftar jika sedang di detail
            setState(() {
              selectedPO = null;
            });
          } else {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          }
        },
      ),
      body: Container(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            WidgetHeader(height: height),
            Container(
              width: width,
              height: height * 0.07,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: height * 0.06,
                      padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Kawasan Industri Karyadeka, Jl.Raya Gemalapik. No.1, Pasirsari, Cikarang Selatan',
                          style: TextStyle(
                              fontFamily: 'Manrope', fontSize: width * 0.03),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: height * 0.06,
                      padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              'Penilaian',
                              style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: width * 0.03),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '7',
                              style: TextStyle(
                                  fontFamily: 'Manrope', fontSize: width * 0.1),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: width,
              child: Row(
                children: [
                  Expanded(
                    child: TabBar(
                      controller: _tabController,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Colors.black,
                      tabs: const [
                        Tab(text: 'List Item'),
                        Tab(text: 'History PO'),
                        Tab(text: 'Review Vendor'),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: width * 0.01,
                  ),
                  Container(
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
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // List Item Tab
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (index, context) {
                        return Container(
                          margin: EdgeInsets.only(top: 10),
                          child: GroupButton(
                            isRadio: true,
                            options: GroupButtonOptions(
                              direction: Axis.horizontal,
                              elevation: 0,
                              groupingType: GroupingType.row,
                              selectedColor: Colors.grey.shade100,
                              selectedTextStyle:
                                  const TextStyle(color: Colors.black),
                              unselectedTextStyle: const TextStyle(
                                  color: Colors.black, fontSize: 10),
                              borderRadius: BorderRadius.circular(8),
                              spacing: 2,
                              buttonWidth: (width * 0.16),
                              buttonHeight: 40, // Tinggi tombol
                            ),
                            onSelected: (value, index, isSelected) {
                              print(
                                  'DATA KLIK : $value - $index - $isSelected');
                            },
                            buttons: [
                              'No',
                              'Nama Item',
                              'Kategori',
                              'MoU',
                              'Harga'
                            ],
                          ),
                        );
                      }),

                  // History PO Tab
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: selectedPO == null
                        ? _buildHistoryPOList(height, width)
                        : _buildPODetail(selectedPO!, width, height),
                  ),

                  // Review Vendor Tab
                  Center(
                    child: Text(
                      'Review Vendor Content',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk menampilkan daftar History PO
  Widget _buildHistoryPOList(double height, double width) {
    return Container(
      margin: EdgeInsets.only(top: height * 0.01),
      child: ListView.builder(
        itemCount: historyPOData.length,
        itemBuilder: (context, index) {
          final item = historyPOData[index];
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        width: width * 0.3,
                        decoration: const BoxDecoration(
                          color: PRIMARY_COLOR,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                        child: const FittedBox(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '27 Sep 2024',
                            style: titleText,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: width * 0.3,
                        decoration: BoxDecoration(
                          color: SECONDARY_COLOR,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(30),
                          ),
                        ),
                        child: FittedBox(
                          alignment: Alignment.center,
                          child: Text(
                            'Approve',
                            style: titleText,
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
                        top: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                          child: Row(
                            children: [
                              Expanded(child: SizedBox.shrink()),
                              Expanded(child: SizedBox.shrink()),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/approve4.svg',
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    SvgPicture.asset(
                                      'assets/images/1.svg',
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    SvgPicture.asset(
                                      'assets/images/2.svg',
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    SvgPicture.asset(
                                      'assets/images/approve3.svg',
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.all(5),
                                child: FittedBox(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Nomor PO',
                                    style: subtitleTextBlack,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.all(5),
                                child: FittedBox(
                                  alignment: Alignment.centerLeft,
                                  child: Text(': 2324253',
                                      style: subtitleTextBlack),
                                ),
                              ),
                            ),
                            Expanded(child: SizedBox.shrink()),
                          ],
                        )),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  child: FittedBox(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Vendor',
                                      style: subtitleTextBlack,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    ': Lorem Ipsum adwadawdbadhbawudbadbaubdawu',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: 'Manrope',
                                      fontSize: height * 0.015,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: SvgPicture.asset(
                                'assets/images/approve2.svg',
                                height: height * 0.5,
                              )),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  child: FittedBox(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Kategori',
                                      style: subtitleTextBlack,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  child: FittedBox(
                                    alignment: Alignment.centerLeft,
                                    child: Text(': Bahan Baku',
                                        style: subtitleTextBlack),
                                  ),
                                ),
                              ),
                              Expanded(child: SizedBox.shrink()),
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
                      Container(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Create by user 1',
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            bottom: height * 0.005, right: width * 0.01),
                        child: WidgetButtonCustom(
                            FullWidth: width * 0.3,
                            FullHeight: 25,
                            title: "Lihat Barang",
                            onpressed: () {
                              setState(() {
                                selectedPO =
                                    item; // Simpan data PO yang dipilih
                              });
                            },
                            bgColor: PRIMARY_COLOR,
                            color: Colors.transparent),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Widget untuk menampilkan detail PO
  Widget _buildPODetail(Map<String, dynamic> po, double width, double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 10),
          child: GroupButton(
            isRadio: true,
            options: GroupButtonOptions(
              direction: Axis.horizontal,
              elevation: 0,
              groupingType: GroupingType.row,
              selectedColor: Colors.grey.shade100,
              selectedTextStyle: const TextStyle(color: Colors.black),
              unselectedTextStyle:
                  const TextStyle(color: Colors.black, fontSize: 10),
              borderRadius: BorderRadius.circular(8),
              spacing: 2,
              buttonWidth: (width * 0.16),
              buttonHeight: 40, // Tinggi tombol
            ),
            onSelected: (value, index, isSelected) {
              print('DATA KLIK : $value - $index - $isSelected');
            },
            buttons: ['No', 'Nama Item', 'Kategori', 'MoU', 'Harga'],
          ),
        ),
        SizedBox(
          height: height * 0.01,
        ),
        Expanded(
          child: ListView(
            children: [
              _buildAspekItem(
                  'Aspek Kualitas', po['aspekKualitas'], width, height),
              _buildAspekItem(
                  'Aspek Pengiriman', po['aspekPengiriman'], width, height),
              _buildAspekItem(
                  'Aspek Kerja Sama', po['aspekKerjaSama'], width, height),
              Text(
                'Total Penilaian',
                style: subtitleTextBlack,
              ),
              Text(
                '28',
                style: TextStyle(fontFamily: "Manrope", fontSize: width * 0.15),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Widget untuk menampilkan aspek dengan progress bar
  Widget _buildAspekItem(String title, int score, double width, double height) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width,
            height: height * 0.03,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: titleTextBlack,
                ),
                Text(
                  score.toString(),
                  style: titleTextBlack,
                ),
              ],
            ),
          ),
          LinearProgressIndicator(
            value: score / 10,
            color: PRIMARY_COLOR,
            minHeight: height * 0.01,
            backgroundColor: SECONDARY_COLOR,
            borderRadius: BorderRadius.circular(12),
          ),
          SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              labelText: 'Isi Keterangan',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}

class WidgetHeader extends StatelessWidget {
  const WidgetHeader({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: height * 0.125,
      child: const Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Kode Vendor',
                        style: titleTextBlack,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        ': D000000023',
                        style: subtitleTextBlack,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'PIC',
                        style: TextStyle(
                            fontFamily: 'Manrope', fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        ': Jhon Doe',
                        style: subtitleTextBlack,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Nama Vendor',
                        style: titleTextBlack,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: FittedBox(
                      child: Text(
                        ': PT Lorem Ipsum',
                        overflow: TextOverflow.ellipsis,
                        style: subtitleTextBlack,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      fit: BoxFit.fitHeight,
                      child: Text(
                        'No. Telp',
                        style: titleTextBlack,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        ': 0812222222',
                        style: subtitleTextBlack,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Kategori',
                        style: titleTextBlack,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        ': Bahan Baku',
                        style: subtitleTextBlack,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Sejak',
                        style: titleTextBlack,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        ': 22-02-2023',
                        style: subtitleTextBlack,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Jenis',
                        style: titleTextBlack,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        ': Barang',
                        style: subtitleTextBlack,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Kota',
                        style: titleTextBlack,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        ': Bekasi',
                        style: subtitleTextBlack,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
