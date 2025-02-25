import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_dropdown.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

import 'component_selesai_so.dart';

class ComponentMulaiSo extends StatefulWidget {
  const ComponentMulaiSo({super.key});

  @override
  State<ComponentMulaiSo> createState() => _ComponentMulaiSoState();
}

class _ComponentMulaiSoState extends State<ComponentMulaiSo> {
  // Fungsi untuk menampilkan modal dialog
  void showCompletionDialog(
      BuildContext context, double width, double height, Function onpressed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Apakah Anda Sudah Selesaikan SO ?',
            style: titleTextBlack,
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
      body: SizedBox(
        width: width,
        height: height,
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              height: height * 0.1,
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
            SizedBox(
              width: width,
              height: height * 0.1,
              child: ListTile(
                title: const Text(
                  'Pilih Kategori',
                  style: subtitleTextBlack,
                ),
                subtitle: WidgetDropdown(
                  items: const ["a", "b"],
                  hintText: 'Kategori',
                  onChanged: (value) {},
                  controller: null,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            SizedBox(
              width: width,
              height: height * 0.1,
              child: ListTile(
                title: const Text(
                  'Pilih Gudang',
                  style: subtitleTextBlack,
                ),
                subtitle: WidgetDropdown(
                  items: const ["a", "b"],
                  hintText: 'Gudang',
                  onChanged: (value) {},
                  controller: null,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.bottomRight,
                child: GroupButton(
                    isRadio: true,
                    options: GroupButtonOptions(
                      selectedColor: PRIMARY_COLOR,
                      unselectedColor: PRIMARY_COLOR,
                      unselectedTextStyle: const TextStyle(color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    onSelected: (value, index, isSelected) {
                      print('DATA KLIK : $value - $index - $isSelected');
                    },
                    buttons: const ['Lihat Data']),
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('No')),
                    DataColumn(
                        label: Text(
                      'Item',
                      overflow: TextOverflow.ellipsis,
                    )),
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.bottomRight,
                child: GroupButton(
                    isRadio: true,
                    options: GroupButtonOptions(
                      selectedColor: PRIMARY_COLOR,
                      unselectedColor: PRIMARY_COLOR,
                      unselectedTextStyle: const TextStyle(color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    onSelected: (value, index, isSelected) {
                      print('DATA KLIK : $value - $index - $isSelected');
                      if (value == 'Selesai') {
                        showCompletionDialog(
                            context, width * 0.3, height * 0.05, () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ComponentSelesaiSo()),
                          );
                        });
                      }
                    },
                    buttons: const ['Selesai']),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
