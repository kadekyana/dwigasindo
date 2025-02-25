import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_produksi.dart';
import 'package:dwigasindo/views/menus/component_produksi/produksi_c2h2/control/detail_control_high_pressure.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';

class ControlHighPressure extends StatelessWidget {
  ControlHighPressure({super.key, required this.titleMenu});
  String titleMenu;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderProduksi>(context);
    // List map untuk data
    final List<Map<String, dynamic>> items = [
      {'title': 'Stok Bahan Baku', 'subtitle': ''},
    ];

    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Control $titleMenu',
        colorBack: Colors.black,
        center: true,
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
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: items.isNotEmpty
            ? ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  final title = item['title'] ?? 'No Title';
                  final subtitle = item['subtitle'] ?? 'No Subtitle';

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
                          provider.getAllTank(context),
                        ]);

                        // Navigate sesuai kondisi
                        Navigator.of(context).pop(); // Tutup Dialog Loading
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ControlMenuHighPressure(
                                title: "$title $titleMenu"),
                          ),
                        );
                      } catch (e) {
                        Navigator.of(context).pop(); // Tutup Dialog Loading
                        print('Error: $e');
                        // Tambahkan pesan error jika perlu
                      }
                    },
                    child: Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.symmetric(
                        vertical: height * 0.01,
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.05, vertical: height * 0.02),
                      height: 70.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 2,
                              offset: Offset(0, 3),
                              color: Colors.grey.shade300),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50.w,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/images/distribusi.png'),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Text(title, style: titleTextBlack),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: Text(
                  'No Data Available',
                  style: subtitleTextNormal,
                ),
              ),
      ),
    );
  }
}

class ControlMenuHighPressure extends StatefulWidget {
  ControlMenuHighPressure({super.key, required this.title});
  String title;

  @override
  State<ControlMenuHighPressure> createState() =>
      _ControlMenuHighPressureState();
}

class _ControlMenuHighPressureState extends State<ControlMenuHighPressure> {
  final GroupButtonController _groupButtonController = GroupButtonController(
    selectedIndex: 0, // "Tanki" berada pada indeks 0
  );
  bool data = true;
  bool selectButton = true;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<ProviderProduksi>(context);
    final data = provider.allTank?.data;
    return Scaffold(
      appBar: WidgetAppbar(
        title: widget.title,
        back: true,
        route: () {
          Navigator.pop(context);
        },
        colorBack: Colors.black,
        colorTitle: Colors.black,
        sizefont: 16.w,
        center: true,
        colorBG: Colors.grey.shade100,
      ),
      body: Padding(
        padding: EdgeInsets.all(15.w),
        child: SizedBox(
          width: width,
          height: height,
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: GroupButton(
                    isRadio: true,
                    enableDeselect: true,
                    controller: _groupButtonController,
                    options: GroupButtonOptions(
                      selectedColor: PRIMARY_COLOR,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    onSelected: (value, index, isSelected) {
                      print('DATA KLIK : $value - $index - $isSelected');
                      setState(() {
                        selectButton =
                            index != 1; // False jika "BB Lainnya" dipilih
                      });
                    },
                    buttons: ['Tanki', "BB Lainnya"]),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
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
              SizedBox(
                height: 10.h,
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
                    },
                    buttons: ['Kartu Stok']),
              ),
              SizedBox(
                height: 10.h,
              ),
              (selectButton == true)
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: data?.length,
                        itemBuilder: (context, index) {
                          final dataCard = data?[index];
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(bottom: 10.h),
                            height: 200.h,
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
                                        height: height * 0.05,
                                        width: width * 0.3,
                                        decoration: const BoxDecoration(
                                          color: PRIMARY_COLOR,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(30),
                                          ),
                                        ),
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Nama BB',
                                            style: titleText,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: height * 0.05,
                                        width: width * 0.3,
                                        decoration: BoxDecoration(
                                          color: (data == true)
                                              ? COMPLEMENTARY_COLOR2
                                              : Colors.grey.shade500,
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(8),
                                            bottomLeft: Radius.circular(30),
                                          ),
                                        ),
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.center,
                                          child: Text(
                                            dataCard?.name ?? '-',
                                            style: titleText,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 120.h,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.h, horizontal: 10.w),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                          color: Colors.grey.shade300),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      // Stack untuk Tanki
                                      Stack(
                                        children: [
                                          // Bentuk tangki (kontainer luar)
                                          Container(
                                            width: width * 0.18,
                                            height: height * 0.15,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          // Bagian isi tangki (Vendor B)
                                          Positioned(
                                            bottom:
                                                10, // Dimulai dari atas isi Vendor B
                                            child: Container(
                                              width: width * 0.18,
                                              height: height * 0.06,
                                              decoration: const BoxDecoration(
                                                color: Color(
                                                    0xFFFF0000), // Warna merah (Vendor A)
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                  top: Radius.circular(8),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            child: Container(
                                              width: width * 0.18,
                                              height: height * 0.04,
                                              decoration: BoxDecoration(
                                                color: Color(
                                                    0xFF003366), // Warna biru (Vendor B)
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                          ),
                                          // Bagian isi tangki (Vendor A)
                                        ],
                                      ),
                                      SizedBox(width: 10.w),
                                      // Informasi Vendor
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("Indikator Tangki",
                                              style: titleTextBlack),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Row(
                                            children: [
                                              // Kotak warna merah untuk Vendor A
                                              Container(
                                                width: 16.w,
                                                height: 16.h,
                                                color: const Color(0xFFFF0000),
                                              ),
                                              SizedBox(width: 8.w),
                                              Text("Vendor A: (Data Stok MoU)",
                                                  style: subtitleTextBlack),
                                            ],
                                          ),
                                          SizedBox(height: 5.h),
                                          Row(
                                            children: [
                                              // Kotak warna biru untuk Vendor B
                                              Container(
                                                width: 16.w,
                                                height: 16.h,
                                                color: const Color(0xFF003366),
                                              ),
                                              SizedBox(width: 8.w),
                                              Text("Vendor B: (Data Stok MoU)",
                                                  style: subtitleTextBlack),
                                            ],
                                          ),
                                          SizedBox(height: 5.h),
                                          Text("(Jumlah Data Stok MoU)",
                                              style: subtitleTextBlack),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.w, right: 10.w),
                                    child: WidgetButtonCustom(
                                        FullWidth: width,
                                        FullHeight: 40.h,
                                        title: "Lihat Barang",
                                        onpressed: () async {
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            },
                                          );

                                          try {
                                            await Future.wait([
                                              provider.getDetailTank(
                                                  context, dataCard!.id!),
                                            ]);

                                            // Navigate sesuai kondisi
                                            Navigator.of(context)
                                                .pop(); // Tutup Dialog Loading
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailControlHighPressure(
                                                  bbLainnya: false,
                                                ),
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
                                        color: Colors.transparent),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: data?.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(bottom: 10.h),
                            height: 200.h,
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
                                        height: height * 0.05,
                                        width: width * 0.3,
                                        decoration: const BoxDecoration(
                                          color: PRIMARY_COLOR,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(30),
                                          ),
                                        ),
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.center,
                                          child: Text(
                                            'N2O',
                                            style: titleText,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: height * 0.05,
                                        width: width * 0.3,
                                        decoration: const BoxDecoration(
                                          color: PRIMARY_COLOR,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(8),
                                            bottomLeft: Radius.circular(30),
                                          ),
                                        ),
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Dijual',
                                            style: titleText,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 120.h,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.h, horizontal: 10.w),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                          color: Colors.grey.shade300),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      // Stack untuk Tanki
                                      Container(
                                        width: 80.w,
                                        height: 80.h,
                                        child: SvgPicture.asset(
                                            'assets/images/tabung.svg'),
                                      ),
                                      SizedBox(width: 10.w),
                                      // Informasi Vendor
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("Stok", style: titleTextBlack),
                                          SizedBox(
                                            width: 200.w,
                                            height: 16.h,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text('Tersedia',
                                                      style: subtitleTextBlack),
                                                ),
                                                Text(
                                                  " : ",
                                                  style: subtitleTextBlack,
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text('800 MoU',
                                                      style: subtitleTextBlack),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 5.h),
                                          SizedBox(
                                            width: 200.w,
                                            height: 16.h,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text('Keluar',
                                                      style: subtitleTextBlack),
                                                ),
                                                Text(
                                                  " : ",
                                                  style: subtitleTextBlack,
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                      '300 Mou (Bulan ini)',
                                                      style: subtitleTextBlack),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 5.h),
                                          SizedBox(
                                            width: 200.w,
                                            height: 16.h,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text('Vendor',
                                                      style: subtitleTextBlack),
                                                ),
                                                Text(
                                                  " : ",
                                                  style: subtitleTextBlack,
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                      'PT. Lorem Ipsum ABCDEFGHIJ',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: subtitleTextBlack),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.w, right: 10.w),
                                    child: WidgetButtonCustom(
                                        FullWidth: width,
                                        FullHeight: 40.h,
                                        title: "Lihat Pemakaian",
                                        onpressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailControlHighPressure(
                                                bbLainnya: true,
                                              ),
                                            ),
                                          );
                                        },
                                        bgColor: PRIMARY_COLOR,
                                        color: Colors.transparent),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
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
    );
  }
}
