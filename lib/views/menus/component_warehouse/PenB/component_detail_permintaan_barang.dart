import 'dart:io';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/views/menus/component_warehouse/PenB/component_serah_terima_barang.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:group_button/group_button.dart';
import 'package:image_picker/image_picker.dart';
import '../Stok/component_tambah_item.dart';

class ComponentDetailPermintaanBarang extends StatefulWidget {
  const ComponentDetailPermintaanBarang({super.key});

  @override
  State<ComponentDetailPermintaanBarang> createState() =>
      _ComponentDetailPermintaanBarangState();
}

class _ComponentDetailPermintaanBarangState
    extends State<ComponentDetailPermintaanBarang> {
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _resetImageFile() {
    setState(() {
      _imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: WidgetAppbar(
        title: 'Detail Permintaan Barang',
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
                  builder: (context) => ComponentTambahItem(),
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
      body: Container(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Column(
          children: [
            SizedBox(
              width: double.maxFinite,
              height: height * 0.1,
              child: const Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: FittedBox(
                              child: Text(
                                'No. PB :',
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
                                'D000000023',
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
                            padding: EdgeInsets.all(5),
                            child: FittedBox(
                              child: Text(
                                'Tanggal :',
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
                                '09-11-2024',
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
                              child: Text(
                                'Kategori :',
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
                                'Bahan Baku',
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
                            padding: EdgeInsets.all(5),
                            child: FittedBox(
                              child: Text(
                                'Dibuat oleh :',
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
                                'Jhon Doe',
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
            ),
            const Divider(),
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
                  buttons: const ['List Item']),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  print(index);
                  return WidgetCard(height: height, width: width);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WidgetCard extends StatelessWidget {
  const WidgetCard({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: height * 0.3,
      padding: EdgeInsets.all(height * 0.01),
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
          Expanded(
            flex: 3,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                  child: Row(
                    children: [
                      const Expanded(child: SizedBox.shrink()),
                      const Expanded(child: SizedBox.shrink()),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/approve4.svg',
                              height: 20,
                              width: 20,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            SvgPicture.asset(
                              'assets/images/approve3.svg',
                              height: 20,
                              width: 20,
                            ),
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
                        padding: const EdgeInsets.all(5),
                        child: const FittedBox(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Nama Item',
                            style: subtitleTextBlack,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        child: const FittedBox(
                          alignment: Alignment.centerLeft,
                          child:
                              Text(': Lorem Ipsum', style: subtitleTextBlack),
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox.shrink()),
                  ],
                )),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          child: const FittedBox(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Qty',
                              style: subtitleTextBlack,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          child: const FittedBox(
                            alignment: Alignment.centerLeft,
                            child: Text(': 100', style: subtitleTextBlack),
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox.shrink()),
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
                          padding: const EdgeInsets.all(5),
                          child: const FittedBox(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Qty diserahkan',
                              style: subtitleTextBlack,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          child: const FittedBox(
                            alignment: Alignment.centerLeft,
                            child: Text(': 100', style: subtitleTextBlack),
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox.shrink()),
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
                          padding: const EdgeInsets.all(5),
                          child: const FittedBox(
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
                          padding: const EdgeInsets.all(5),
                          child: const FittedBox(
                            alignment: Alignment.centerLeft,
                            child:
                                Text(': Bahan Baku', style: subtitleTextBlack),
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox.shrink()),
                    ],
                  ),
                ),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: FittedBox(
                        child: Text(
                          'Catatan',
                          style: titleTextBlack,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            flex: 1,
            child: TextField(
              maxLines: null, // Membuat text field untuk teks panjang
              expands:
                  true, // Memperluas TextField agar sesuai dengan ukuran Container
              decoration: InputDecoration(
                hintText: 'Masukkan catatan di sini...',
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
              ),
              style: TextStyle(fontSize: 16),
              textAlignVertical: TextAlignVertical.top,
            ),
          ),
          SizedBox(
            width: width,
            height: height * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(child: SizedBox.shrink()),
                SizedBox(
                  width: width * 0.01,
                ),
                const Expanded(child: SizedBox.shrink()),
                SizedBox(
                  width: width * 0.01,
                ),
                Expanded(
                  child: WidgetButtonCustom(
                      FullWidth: width * 0.3,
                      FullHeight: 30,
                      title: "Edit",
                      onpressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ComponentSerahTerimaBarang()));
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
  }
}
