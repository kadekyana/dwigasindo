import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:group_button/group_button.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../widgets/widget_form.dart';
import '../Stok/component_tambah_item.dart';

class ComponentDetailPenerimaanBarang extends StatefulWidget {
  const ComponentDetailPenerimaanBarang({super.key});

  @override
  State<ComponentDetailPenerimaanBarang> createState() =>
      _ComponentDetailPenerimaanBarangState();
}

class _ComponentDetailPenerimaanBarangState
    extends State<ComponentDetailPenerimaanBarang> {
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

  void showCompletionDialog(
      BuildContext context, double width, double height, Function onpressed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: SizedBox(
                width: width * 5,
                child: const Center(
                  child: Text(
                    'Terima Barang',
                    style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
              content: SizedBox(
                width: width,
                height: height * 7,
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Expanded(
                          child: FittedBox(
                            child: Text(
                              'Qty Pemesanan',
                              style: titleTextBlack,
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: FittedBox(
                            alignment: Alignment.center,
                            child: Text(
                              'Qty Diterima',
                              style: titleTextBlack,
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Center(
                            child: Text(
                              'Qty Result',
                              style: titleTextBlack,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.2),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Center(
                              child: Text(
                                '100 (MoU)',
                                style: subtitleTextBlack,
                              ),
                            ),
                          ),
                          Expanded(
                            child: WidgetForm(
                              typeInput: TextInputType.number,
                              alert: '(MoU)',
                              hint: '(MoU)',
                              border: const OutlineInputBorder(),
                            ),
                          ),
                          const Expanded(
                            child: Center(
                              child: Text(
                                '-/+1 (MoU)',
                                style: subtitleTextBlack,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.2),
                      child: const Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Foto Bukti',
                              style: subtitleTextBlack,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Gudang',
                              style: subtitleTextBlack,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.2),
                      child: Row(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: () async {
                                  await _pickImage();
                                  setState(() {});
                                },
                                child: _imageFile != null
                                    ? Image.file(
                                        _imageFile!,
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      )
                                    : SvgPicture.asset(
                                        'assets/images/gambar.svg'),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: CustomDropdown(
                              items: const ['a', 'b'],
                              hintText: 'Tipe',
                              onChanged: (value) {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: TextField(
                        maxLines: null,
                        expands: true,
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
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    WidgetButtonCustom(
                      FullWidth: width,
                      FullHeight: height,
                      title: 'Kembali',
                      onpressed: () {
                        Navigator.pop(context);
                        _resetImageFile();
                      },
                      bgColor: PRIMARY_COLOR,
                      color: PRIMARY_COLOR,
                    ),
                    WidgetButtonCustom(
                      FullWidth: width,
                      FullHeight: height,
                      title: 'Selesai',
                      onpressed: () {
                        onpressed();
                        Navigator.pop(context);
                        _resetImageFile();
                      },
                      bgColor: PRIMARY_COLOR,
                      color: PRIMARY_COLOR,
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

// dialog return
  void showReturn(
      BuildContext context, double width, double height, Function onpressed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: SizedBox(
                width: width * 5,
                child: const Center(
                  child: Text(
                    'Return Barang',
                    style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
              content: SizedBox(
                width: width,
                height: height * 4,
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Qty',
                            style: titleTextBlack,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Foto Bukti',
                            style: titleTextBlack,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.2),
                      child: Row(
                        children: [
                          Expanded(
                            child: WidgetForm(
                              typeInput: TextInputType.number,
                              alert: '(MoU)',
                              hint: '(MoU)',
                              border: const OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: () async {
                                  await _pickImage();
                                  setState(() {});
                                },
                                child: _imageFile != null
                                    ? Image.file(
                                        _imageFile!,
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      )
                                    : SvgPicture.asset(
                                        'assets/images/gambar.svg'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: TextField(
                        maxLines: null,
                        expands: true,
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
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    WidgetButtonCustom(
                      FullWidth: width,
                      FullHeight: height,
                      title: 'Kembali',
                      onpressed: () {
                        Navigator.pop(context);
                        _resetImageFile();
                      },
                      bgColor: PRIMARY_COLOR,
                      color: PRIMARY_COLOR,
                    ),
                    WidgetButtonCustom(
                      FullWidth: width,
                      FullHeight: height,
                      title: 'Selesai',
                      onpressed: () {
                        onpressed();
                        Navigator.pop(context);
                        _resetImageFile();
                      },
                      bgColor: PRIMARY_COLOR,
                      color: PRIMARY_COLOR,
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

// dialog return
  void showCancel(
      BuildContext context, double width, double height, Function onpressed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: SizedBox(
                width: width * 5,
                child: const Center(
                  child: Text(
                    'Pembatalan Barang',
                    style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
              content: SizedBox(
                width: width,
                height: height * 2.5,
                child: const Column(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Keterangan',
                            style: titleTextBlack,
                          )),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        maxLines: null,
                        expands: true,
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
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    WidgetButtonCustom(
                      FullWidth: width,
                      FullHeight: height,
                      title: 'Kembali',
                      onpressed: () {
                        Navigator.pop(context);
                        _resetImageFile();
                      },
                      bgColor: PRIMARY_COLOR,
                      color: PRIMARY_COLOR,
                    ),
                    WidgetButtonCustom(
                      FullWidth: width,
                      FullHeight: height,
                      title: 'Selesai',
                      onpressed: () {
                        onpressed();
                        Navigator.pop(context);
                        _resetImageFile();
                      },
                      bgColor: PRIMARY_COLOR,
                      color: PRIMARY_COLOR,
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: WidgetAppbar(
        title: 'Penerimaan Barang',
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              width: double.maxFinite,
              height: height * 0.15,
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
                                'Kode SO :',
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
                                'Nama Vendor :',
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
                                'PT Lorem Ipsum',
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
                                'No. Telp :',
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
                                '0812222222',
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
                                'No.SPB :',
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
                                '24339104',
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
                  return Container(
                    width: double.maxFinite,
                    height: height * 0.35,
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
                          child: Container(
                            child: Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                    child: Row(
                                      children: [
                                        const Expanded(
                                            child: SizedBox.shrink()),
                                        const Expanded(
                                            child: SizedBox.shrink()),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                            child: Text(': Lorem Ipsum',
                                                style: subtitleTextBlack),
                                          ),
                                        ),
                                      ),
                                      const Expanded(child: SizedBox.shrink()),
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
                                              child: Text(': 100',
                                                  style: subtitleTextBlack),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                            child: SizedBox.shrink()),
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
                                              child: Text(': Bahan Baku',
                                                  style: subtitleTextBlack),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                            child: SizedBox.shrink()),
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
                                            'Keterangan',
                                            style: titleTextBlack,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Expanded(
                          child: TextField(
                            maxLines:
                                null, // Membuat text field untuk teks panjang
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
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: WidgetButtonCustom(
                                    FullWidth: width * 0.3,
                                    FullHeight: 30,
                                    title: "Batal",
                                    onpressed: () {
                                      showCancel(context, width * 0.3,
                                          height * 0.05, () {});
                                    },
                                    bgColor: PRIMARY_COLOR,
                                    color: Colors.transparent),
                              ),
                              SizedBox(
                                width: width * 0.01,
                              ),
                              Expanded(
                                child: WidgetButtonCustom(
                                    FullWidth: width * 0.3,
                                    FullHeight: 30,
                                    title: "Return Barang",
                                    onpressed: () {
                                      showReturn(context, width * 0.3,
                                          height * 0.05, () {});
                                    },
                                    bgColor: PRIMARY_COLOR,
                                    color: Colors.transparent),
                              ),
                              SizedBox(
                                width: width * 0.01,
                              ),
                              Expanded(
                                child: WidgetButtonCustom(
                                    FullWidth: width * 0.3,
                                    FullHeight: 30,
                                    title: "Terima Barang",
                                    onpressed: () {
                                      showCompletionDialog(context, width * 0.3,
                                          height * 0.05, () {});
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
            ),
          ],
        ),
      ),
    );
  }
}
