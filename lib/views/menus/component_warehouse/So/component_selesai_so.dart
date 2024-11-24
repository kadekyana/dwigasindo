import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

class ComponentSelesaiSo extends StatefulWidget {
  ComponentSelesaiSo({super.key});

  @override
  State<ComponentSelesaiSo> createState() => _ComponentSelesaiSoState();
}

class _ComponentSelesaiSoState extends State<ComponentSelesaiSo> {
  // Fungsi untuk menampilkan modal dialog
  void showCompletionDialog(
      BuildContext context, double width, double height, Function onpressed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            width: width * 5,
            child: Center(
              child: Text(
                'Berita Acara Stok Opname',
                style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: height * 0.5,
                    color: Colors.black),
              ),
            ),
          ),
          content: Container(
            width: width,
            height: height * 8,
            child: Column(
              children: [
                FittedBox(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'No. Berita Acara : 001/SO/DGA/ACC/24',
                    style: subtitleTextBlack,
                  ),
                ),
                Row(
                  children: [
                    const Expanded(
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Nilai Plus :',
                          style: subtitleTextBlack,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '100.000.000',
                          style: TextStyle(
                              color: Colors.green, fontFamily: 'Manrope'),
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Text("|"),
                    ),
                    const Expanded(
                      child: FittedBox(
                          alignment: Alignment.centerLeft,
                          child: Text('Nilai Minus :')),
                    ),
                    const Expanded(
                      child: FittedBox(
                        child: Text(
                          '50.000.000',
                          style: TextStyle(
                              color: Colors.red, fontFamily: 'Manrope'),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Container(
                  width: width,
                  height: height * 0.6,
                  child: FittedBox(
                    child: Text(
                      'Total Nilai SO',
                      style: titleTextBlack,
                    ),
                  ),
                ),
                Container(
                  width: width,
                  height: height * 0.6,
                  child: FittedBox(
                    child: Text(
                      '50.000.000',
                      style: titleTextBlack,
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    'PIC Approval',
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: height * 0.01),
                        child: CustomDropdown(
                          decoration: CustomDropdownDecoration(
                              closedBorder:
                                  Border.all(color: Colors.grey.shade400),
                              expandedBorder:
                                  Border.all(color: Colors.grey.shade400)),
                          hintText: 'Pilih PIC Verifikasi',
                          items: ['a'],
                          onChanged: (value) {},
                        ),
                      ),
                      SizedBox(
                        height: height * 0.1,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: height * 0.01),
                        child: CustomDropdown(
                          decoration: CustomDropdownDecoration(
                              closedBorder:
                                  Border.all(color: Colors.grey.shade400),
                              expandedBorder:
                                  Border.all(color: Colors.grey.shade400)),
                          hintText: 'Pilih PIC Mengetahui',
                          items: ['a'],
                          onChanged: (value) {},
                        ),
                      ),
                      SizedBox(
                        height: height * 0.1,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: height * 0.01),
                        child: CustomDropdown(
                          decoration: CustomDropdownDecoration(
                              closedBorder:
                                  Border.all(color: Colors.grey.shade400),
                              expandedBorder:
                                  Border.all(color: Colors.grey.shade400)),
                          hintText: 'Pilih PIC Menyetujui',
                          items: ['a'],
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Tombol "Cek Lagi" di kiri
                WidgetButtonCustom(
                    FullWidth: width,
                    FullHeight: height,
                    title: 'Cek Lagi',
                    onpressed: () {
                      Navigator.pop(context);
                    },
                    bgColor: PRIMARY_COLOR,
                    color: PRIMARY_COLOR),

                // Tombol "Ya, Selesai" di kanan
                WidgetButtonCustom(
                    FullWidth: width,
                    FullHeight: height,
                    title: 'Selesai',
                    onpressed: onpressed,
                    bgColor: PRIMARY_COLOR,
                    color: PRIMARY_COLOR),
              ],
            ),
          ],
        );
      },
    );
  }

  bool hide_tanggal = false;

  bool hide_button = false;

  String buttonText = "Mulai SO";

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: WidgetAppbar(
        title: 'Stok Opname',
        center: true,
        colorTitle: Colors.black,
        colorBack: Colors.black,
        colorBG: Colors.grey.shade100,
        back: true,
        route: () {
          Navigator.pop(context);
        },
        // actions: [
        //   IconButton(
        //     onPressed: () async {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => ComponentTambahItem(),
        //         ),
        //       );
        //     },
        //     icon: Icon(
        //       Icons.add_circle_outline_rounded,
        //       color: Colors.black,
        //     ),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: width,
          height: height,
          child: Column(
            children: [
              Container(
                width: width,
                height: 50,
                child: const Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          'Kode SO : D0000023',
                          style: subtitleTextBlack,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Tanggal : 01-08-2024',
                          style: subtitleTextBlack,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: width,
                height: height * 0.15,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const Expanded(
                      child: FittedBox(
                        child: Text(
                          'Keterangan :',
                          style: titleTextBlack,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.01,
                    ),
                    const Expanded(
                      flex: 4,
                      child: TextField(
                        maxLines: null, // Membuat text field untuk teks panjang
                        expands:
                            true, // Memperluas TextField agar sesuai dengan ukuran Container
                        decoration: InputDecoration(
                          hintText: 'Masukkan keterangan di sini...',
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(),
                        ),
                        style: TextStyle(fontSize: 16),
                        textAlignVertical: TextAlignVertical.top,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Container(
                width: width,
                height: 50,
                child: const Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          'Nilai Plus : 100.000.000',
                          style: subtitleTextBlack,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Nilai Minus : 50.000.000',
                          style: subtitleTextBlack,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.maxFinite,
                height: height * 0.1,
                padding: EdgeInsets.symmetric(horizontal: 20),
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
              Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('No')),
                      DataColumn(label: Text('Item')),
                      DataColumn(label: Text('Qty')),
                      DataColumn(label: Text('Fisik')),
                      DataColumn(label: Text('Hasil')),
                    ],
                    rows: List<DataRow>.generate(
                      5,
                      (index) => DataRow(
                        cells: [
                          DataCell(Text((index + 1).toString())), // No
                          DataCell(Text('Item ${index + 1}')), // Item
                          DataCell(Text((100).toString())), // Qty
                          DataCell(Text((100 + index).toString())), // Fisik
                          DataCell(Text((0 + index).toString())), // Hasil
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: GroupButton(
                      isRadio: true,
                      options: GroupButtonOptions(
                        selectedColor: PRIMARY_COLOR,
                        unselectedColor: PRIMARY_COLOR,
                        unselectedTextStyle: TextStyle(color: Colors.white),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                        if (value == 'Save') {
                          showCompletionDialog(
                              context, width * 0.3, height * 0.05, () {});
                        }
                      },
                      buttons: ['Save']),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
