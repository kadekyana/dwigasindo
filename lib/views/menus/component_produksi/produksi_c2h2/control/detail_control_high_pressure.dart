import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_bottom_bar.dart';
import 'package:dwigasindo/providers/provider_produksi.dart';
import 'package:dwigasindo/providers/provider_sales.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:group_button/group_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class DetailControlHighPressure extends StatelessWidget {
  DetailControlHighPressure({super.key, required this.bbLainnya});
  bool bbLainnya;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<ProviderProduksi>(context);
    final providerSal = Provider.of<ProviderSales>(context);
    final data = provider.tank?.data;
    return Scaffold(
      appBar: WidgetAppbar(
        title: "Nama BB",
        back: true,
        route: () {
          Navigator.pop(context);
        },
        center: true,
        colorBack: Colors.black,
        colorTitle: Colors.black,
        colorBG: Colors.grey.shade100,
      ),
      body: Container(
        width: width,
        height: height,
        padding: EdgeInsets.only(top: 10.h, left: 15.w, right: 15.w),
        child: Column(
          children: [
            SizedBox(
              width: width,
              height: 50.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: 'Stok Tersedia\n', style: subtitleTextBlack),
                        TextSpan(text: '1.0000\n', style: subtitleTextBlack),
                        TextSpan(text: 'MoU\n\n', style: minisubtitleTextBlack),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: 'Stok Keluar\n', style: subtitleTextBlack),
                        TextSpan(text: '500\n', style: subtitleTextBlack),
                        TextSpan(text: 'MoU\n\n', style: minisubtitleTextBlack),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: width,
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
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: width,
              height: 50.h,
              child: Row(
                mainAxisAlignment: (bbLainnya == true)
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.start,
                children: [
                  WidgetButtonCustom(
                    FullWidth: 165.w,
                    FullHeight: 40.h,
                    title: "Kartu Stok",
                    onpressed: () {},
                    color: PRIMARY_COLOR,
                    bgColor: PRIMARY_COLOR,
                  ),
                  if (bbLainnya == true)
                    SizedBox(
                      width: 10.w,
                    ),
                  if (bbLainnya == true)
                    WidgetButtonCustom(
                      FullWidth: 165.w,
                      FullHeight: 40.h,
                      title: "Tambah",
                      onpressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => tambahPemakaian(),
                          ),
                        );
                      },
                      color: PRIMARY_COLOR,
                      bgColor: PRIMARY_COLOR,
                    )
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            (bbLainnya == true)
                ? Expanded(
                    child: ListView.builder(
                      itemCount: data!.length,
                      itemBuilder: (context, index) {
                        final dataCardB = data[index];
                        return Container(
                          width: width,
                          height: 125.h,
                          margin: EdgeInsets.only(bottom: 10.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(0, 1),
                                  color: Colors.grey.shade400,
                                  blurRadius: 1)
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: width,
                                height: 40.h,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: width * 0.4,
                                      height: 40.h,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(20)),
                                        color: PRIMARY_COLOR,
                                      ),
                                      child: Center(
                                        child: FittedBox(
                                          alignment: Alignment.center,
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            '${providerSal.formatDate(dataCardB.createdAt.toString())} | ${providerSal.formatTime(dataCardB.createdAt.toString())}',
                                            style: subtitleText,
                                          ),
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
                                          'Produksi',
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
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          top: BorderSide(
                                              color: Colors.grey.shade300))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 210.w,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(8),
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 25.h,
                                              child: FittedBox(
                                                alignment: Alignment.centerLeft,
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                    '${dataCardB.itemName}',
                                                    style: superTitleTextBlack),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 200.w,
                                              height: 15.h,
                                              child: Text(
                                                  'PT. Dwigasindo Abadi',
                                                  style: subtitleTextBlack),
                                            ),
                                            SizedBox(
                                                width: 220.w,
                                                height: 16.h,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text('Nomor PO',
                                                          style:
                                                              subtitleTextNormalblack),
                                                    ),
                                                    Text(
                                                      " : ",
                                                      style:
                                                          subtitleTextNormalblack,
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text('T12398192',
                                                          style:
                                                              subtitleTextNormalblack),
                                                    ),
                                                  ],
                                                )),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(8),
                                          ),
                                        ),
                                        child: Container(
                                          width: 90.h,
                                          height: 70.h,
                                          decoration: BoxDecoration(
                                            color: SECONDARY_COLOR,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                            child: RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Stok Keluar\n',
                                                    style: minisubtitleText,
                                                  ),
                                                  TextSpan(
                                                      text: '500\n',
                                                      style:
                                                          superTitleTextWhite),
                                                  TextSpan(
                                                    text: 'MoU',
                                                    style: minisubtitleText,
                                                  ),
                                                ],
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
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
                    child: ListView.builder(
                      itemCount: data!.length,
                      itemBuilder: (context, index) {
                        final dataCard = data[index];
                        return Container(
                          width: width,
                          height: 140.h,
                          margin: EdgeInsets.only(bottom: 10.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(0, 1),
                                  color: Colors.grey.shade400,
                                  blurRadius: 1)
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(right: 10.w),
                                width: width,
                                height: 40.h,
                                child: Row(
                                  children: [
                                    Container(
                                      width: width * 0.4,
                                      height: 40.h,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(20)),
                                        color: PRIMARY_COLOR,
                                      ),
                                      child: Center(
                                        child: FittedBox(
                                          alignment: Alignment.center,
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            '${providerSal.formatDate(dataCard.createdAt.toString())} | ${providerSal.formatTime(dataCard.createdAt.toString())}',
                                            style: subtitleText,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: FittedBox(
                                        alignment: Alignment.centerRight,
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          'Kode Produksi : -',
                                          style: subtitleTextBlack,
                                          textAlign: TextAlign.right,
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
                                    horizontal: 10.w,
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          top: BorderSide(
                                              color: Colors.grey.shade300))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 210.w,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(8),
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                height: 25.h,
                                                child: FittedBox(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    fit: BoxFit.scaleDown,
                                                    child: Text(
                                                        '${dataCard.itemName}',
                                                        style:
                                                            superTitleTextBlack))),
                                            SizedBox(
                                              height: 15.h,
                                              child: Text(
                                                  '${dataCard.vendorName}',
                                                  style: subtitleTextBlack),
                                            ),
                                            SizedBox(
                                                width: 220.w,
                                                height: 16.h,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text('Nomor PO',
                                                          style:
                                                              subtitleTextNormalblack),
                                                    ),
                                                    Text(
                                                      " : ",
                                                      style:
                                                          subtitleTextNormalblack,
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text('T12398192',
                                                          style:
                                                              subtitleTextNormalblack),
                                                    ),
                                                  ],
                                                )),
                                            SizedBox(
                                                width: 220.w,
                                                height: 16.h,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text('Rak',
                                                          style:
                                                              subtitleTextNormalblack),
                                                    ),
                                                    Text(
                                                      " : ",
                                                      style:
                                                          subtitleTextNormalblack,
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text('2',
                                                          style:
                                                              subtitleTextNormalblack),
                                                    ),
                                                  ],
                                                )),
                                            SizedBox(
                                                width: 220.w,
                                                height: 16.h,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text('Jumlah',
                                                          style:
                                                              subtitleTextNormalblack),
                                                    ),
                                                    Text(
                                                      " : ",
                                                      style:
                                                          subtitleTextNormalblack,
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                          '${dataCard.qty}',
                                                          style:
                                                              subtitleTextNormalblack),
                                                    ),
                                                  ],
                                                )),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(8),
                                          ),
                                        ),
                                        child: Container(
                                          width: width * 0.3,
                                          height: height * 0.1,
                                          decoration: BoxDecoration(
                                            color: SECONDARY_COLOR,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                            child: RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Stok Tersedia\n',
                                                    style: minisubtitleText,
                                                  ),
                                                  TextSpan(
                                                      text: '500\n',
                                                      style:
                                                          superTitleTextWhite),
                                                  TextSpan(
                                                    text: 'MoU',
                                                    style: minisubtitleText,
                                                  ),
                                                ],
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
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
          ],
        ),
      ),
    );
  }
}

class tambahPemakaian extends StatefulWidget {
  tambahPemakaian({super.key, this.uuid});
  String? uuid;
  @override
  State<tambahPemakaian> createState() => _tambahPemakaianState();
}

class _tambahPemakaianState extends State<tambahPemakaian> {
  TextEditingController kode = TextEditingController();
  TextEditingController keterangan = TextEditingController();

  SingleSelectController<String?> kategori =
      SingleSelectController<String?>(null);

  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take a Photo'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _resetImageFile() {
    setState(() {
      _imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<ProviderBottomBar>(context);

    // final categories = provider.allcategory?.data
    //     .map((data) => {'id': data.id, 'name': data.name})
    //     .toList();

    // final locations = provider.location?.data
    //     .map((data) => {'id': data.id, 'name': data.name})
    //     .toList();

    // final units = provider.units?.data
    //     .map((data) => {'id': data.id, 'name': data.name})
    //     .toList();

    // final vendorData = provider.supplier?.data
    //     .map((data) => {'id': data.id, 'name': data.name})
    //     .toList();

    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Tambah Item',
        back: true,
        center: true,
        colorBG: Colors.grey.shade100,
        colorBack: Colors.black,
        colorTitle: Colors.black,
        route: () {
          Navigator.pop(context);
          _resetImageFile();
        },
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GroupButton(
                      isRadio: true,
                      enableDeselect: true,
                      options: GroupButtonOptions(
                          selectedColor: PRIMARY_COLOR,
                          borderRadius: BorderRadius.circular(8),
                          elevation: 0),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                      },
                      buttons: ['Masuk', "Keluar"]),
                ),
              ),
              Container(
                width: width,
                height: 80.h,
                child: ListTile(
                  title: Container(
                    margin: EdgeInsets.only(bottom: 8.h),
                    child: Text(
                      'Kategori',
                      style: subtitleTextBlack,
                    ),
                  ),
                  subtitle: CustomDropdown(
                    items: ['a', 'b'],
                    hintText: 'Unit',
                    controller: kategori,
                    onChanged: (value) {
                      print(value);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.005,
              ),
              Container(
                width: width,
                height: height * 0.1,
                child: ListTile(
                  title: Text(
                    'Kode Berita Acara',
                    style: subtitleTextBlack,
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: WidgetForm(
                      controller: kode,
                      alert: 'PCS',
                      hint: 'PCS',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: width,
                height: 80.h,
                child: Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () => _showImageSourceDialog(),
                    // Panggil fungsi saat button diklikå
                    child: SizedBox(
                      width: width,
                      height: height * 0.1,
                      child: ListTile(
                        title: Text(
                          'Upload Image',
                          style: subtitleTextBlack,
                        ),
                        subtitle: Container(
                          height: 100.h,
                          margin: EdgeInsets.only(top: height * 0.01),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: _imageFile != null
                              ? Image.file(
                                  _imageFile!,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.fitHeight,
                                )
                              : Padding(
                                  padding: EdgeInsets.all(10.h),
                                  child: SvgPicture.asset(
                                      'assets/images/gambar.svg'),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Container(
                width: width,
                height: height * 0.1,
                child: ListTile(
                  title: Text(
                    'Keterangan',
                    style: subtitleTextBlack,
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: WidgetForm(
                      controller: keterangan,
                      typeInput: TextInputType.number,
                      alert: 'Keterangan',
                      hint: 'Keterangan',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: width,
        height: height * 0.06,
        margin: EdgeInsets.only(bottom: 10.h),
        child: ListTile(
          subtitle: WidgetButtonCustom(
              FullWidth: 340.w,
              FullHeight: 40.h,
              title: 'Submit',
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
                    // provider.createItem(
                    //     context,
                    //     kode.text,
                    //     nama.text,
                    //     selectKategori!,
                    //     selectLokasi!,
                    //     selectUnit!,
                    //     int.parse(stok.text),
                    //     int.parse(harga.text),
                    //     int.parse(limit.text),
                    //     selectVendor!,
                    //     1),
                  ]);

                  // Navigate sesuai kondisi
                  Navigator.pop(context); // Tutup Dialog Loading
                  Navigator.pop(context);
                } catch (e) {
                  Navigator.of(context).pop(); // Tutup Dialog Loading
                  print('Error: $e');
                  // Tambahkan pesan error jika perlu
                }
              },
              bgColor: PRIMARY_COLOR,
              color: PRIMARY_COLOR),
        ),
      ),
    );
  }
}
