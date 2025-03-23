import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_sales.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:dwigasindo/widgets/wigdet_kecamatan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:group_button/group_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../providers/provider_item.dart';

class ComponentTambahItem extends StatefulWidget {
  ComponentTambahItem({super.key, this.uuid});
  String? uuid;
  @override
  State<ComponentTambahItem> createState() => _ComponentTambahItemState();
}

class _ComponentTambahItemState extends State<ComponentTambahItem> {
  TextEditingController? controller = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  String? filepath;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      final providerSales = Provider.of<ProviderSales>(context, listen: false);
      final path = await providerSales.uploadFile(
          context, _imageFile!, _imageFile!.path.split("/").last);
      setState(() {
        filepath = path;
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
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a Photo'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
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

  int? selectKategori;
  int? selectVendor;
  int? selectLokasi;
  int? selectUnit;
  int check = 1;

  TextEditingController kode = TextEditingController();
  TextEditingController nama = TextEditingController();
  // TextEditingController stok = TextEditingController();
  TextEditingController harga = TextEditingController();
  // TextEditingController lokasi = TextEditingController();
  TextEditingController limit = TextEditingController();
  TextEditingController supplier = TextEditingController();
  GroupButtonController? sell = GroupButtonController(selectedIndex: 0);
  TextEditingController hargaJual = TextEditingController();
  SingleSelectController<String?> kategori =
      SingleSelectController<String?>(null);

  SingleSelectController<String?> mou = SingleSelectController<String?>(null);
  SingleSelectController<String?> vendor =
      SingleSelectController<String?>(null);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<ProviderItem>(context);
    final providerSales = Provider.of<ProviderSales>(context);

    final categories = provider.allcategory?.data
        .map((data) => {'id': data.id, 'name': data.name})
        .toList();

    final locations = provider.location?.data
        .map((data) => {'id': data.id, 'name': data.name})
        .toList();

    final units = provider.units?.data
        .map((data) => {'id': data.id, 'name': data.name})
        .toList();

    final vendorData = provider.supplier?.data
        .map((data) => {'id': data.id, 'name': data.name})
        .toList();

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
        },
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: width,
                height: height * 0.1,
                child: ListTile(
                  title: Text(
                    'Kode Item',
                    style: subtitleTextBlack,
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: WidgetForm(
                      controller: kode,
                      alert: '2127367218',
                      hint: '2127367218',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              SizedBox(
                width: width,
                height: height * 0.1,
                child: ListTile(
                  title: Text(
                    'Nama Item',
                    style: subtitleTextBlack,
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: WidgetForm(
                      controller: nama,
                      alert: 'Nama',
                      hint: 'Nama',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              SizedBox(
                width: width,
                height: 80.h,
                child: ListTile(
                  title: Container(
                    margin: EdgeInsets.only(bottom: 8.h),
                    child: Text(
                      'Kategori Item',
                      style: subtitleTextBlack,
                    ),
                  ),
                  subtitle: CustomDropdown(
                    items: categories!.map((e) => e['name']).toList(),
                    hintText: 'Tipe',
                    controller: kategori,
                    onChanged: (value) {
                      if (value != null) {
                        final ID = categories.firstWhere(
                          (item) => item['name'] == value,
                        );
                        setState(() {
                          selectKategori = int.parse(ID['id'].toString());
                        });
                      }
                    },
                  ),
                ),
              ),
              // SizedBox(height: height * 0.01),
              // SizedBox(
              //   width: width,
              //   height: 80.h,
              //   child: ListTile(
              //     title: Container(
              //       margin: EdgeInsets.only(bottom: 8.h),
              //       child: Text(
              //         'Lokasi',
              //         style: subtitleTextBlack,
              //       ),
              //     ),
              //     subtitle: CustomAutocomplete(
              //       data: locations!.map((e) => e['name']).toList(),
              //       displayString: (item) => item.toString(),
              //       onSelected: (value) {
              //         if (value != null) {
              //           final ID = locations.firstWhere(
              //             (item) => item['name'] == value,
              //           );
              //           setState(() {
              //             selectLokasi = int.parse(ID['id'].toString());
              //           });
              //           print(selectLokasi);
              //         }
              //       },
              //       labelText: 'Cari Barang',
              //       controller: controller,
              //     ),
              //   ),
              // ),
              SizedBox(height: height * 0.01),
              SizedBox(
                width: width,
                height: 80.h,
                child: ListTile(
                  title: Container(
                    margin: EdgeInsets.only(bottom: 8.h),
                    child: Text(
                      'Satuan (MoU)',
                      style: subtitleTextBlack,
                    ),
                  ),
                  subtitle: CustomDropdown(
                    items: units!.map((e) => e['name']).toList(),
                    hintText: 'Unit',
                    controller: mou,
                    onChanged: (value) {
                      if (value != null) {
                        final ID = units.firstWhere(
                          (item) => item['name'] == value,
                        );
                        setState(() {
                          selectUnit = int.parse(ID['id'].toString());
                        });
                      }
                    },
                  ),
                ),
              ),
              // SizedBox(
              //   height: height * 0.01,
              // ),
              // SizedBox(
              //   width: width,
              //   height: height * 0.1,
              //   child: ListTile(
              //     title: Text(
              //       'Stok Item',
              //       style: subtitleTextBlack,
              //     ),
              //     subtitle: Container(
              //       margin: EdgeInsets.only(top: height * 0.01),
              //       child: WidgetForm(
              //         controller: stok,
              //         alert: 'Stok',
              //         hint: 'Stok',
              //         border: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(12)),
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: height * 0.02,
              ),
              SizedBox(
                width: width,
                height: height * 0.1,
                child: ListTile(
                  title: Text(
                    'Harga Stok',
                    style: subtitleTextBlack,
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: WidgetForm(
                      controller: harga,
                      typeInput: TextInputType.number,
                      alert: 'Harga',
                      hint: 'Harga',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              SizedBox(
                width: width,
                height: 70.h,
                child: ListTile(
                  title: Text(
                    'Apakah Item Akan Di Jual ?',
                    style: subtitleTextBlack,
                  ),
                  subtitle: Align(
                    alignment: Alignment.topLeft,
                    child: GroupButton(
                        isRadio: true,
                        controller: sell,
                        options: GroupButtonOptions(
                          mainGroupAlignment: MainGroupAlignment.start,
                          selectedColor: PRIMARY_COLOR,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        onSelected: (value, index, isSelected) {
                          print('DATA KLIK : $value - $index - $isSelected');
                          setState(() {
                            if (index == 0) {
                              check = 1;
                            } else {
                              check = 2;
                            }
                          });
                        },
                        buttons: const ["Tidak", "Iya"]),
                  ),
                ),
              ),
              if (check == 2)
                SizedBox(
                  width: width,
                  height: height * 0.1,
                  child: ListTile(
                    title: Text(
                      'Harga Jual',
                      style: subtitleTextBlack,
                    ),
                    subtitle: Container(
                      margin: EdgeInsets.only(top: height * 0.01),
                      child: WidgetForm(
                        controller: hargaJual,
                        typeInput: TextInputType.number,
                        alert: 'Harga Jual',
                        hint: 'Harga Jual',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ),
              SizedBox(height: height * 0.02),
              SizedBox(
                width: width,
                height: height * 0.1,
                child: ListTile(
                  title: Text(
                    'Limit Stok',
                    style: subtitleTextBlack,
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: WidgetForm(
                      controller: limit,
                      alert: 'Limit',
                      hint: 'Limit',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              SizedBox(
                width: width,
                height: height * 0.1,
                child: ListTile(
                  title: Container(
                    margin: EdgeInsets.only(bottom: 8.h),
                    child: Text(
                      'Vendors / Supplier',
                      style: subtitleTextBlack,
                    ),
                  ),
                  subtitle: CustomDropdown(
                    items: vendorData!.map((e) => e['name']).toList(),
                    hintText: 'Vendor / Supplier',
                    controller: vendor,
                    onChanged: (value) {
                      if (value != null) {
                        final ID = vendorData.firstWhere(
                          (item) => item['name'] == value,
                        );
                        setState(() {
                          selectVendor = int.parse(ID['id'].toString());
                        });
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              SizedBox(
                width: width,
                height: 80.h,
                child: Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap:
                        _showImageSourceDialog, // Panggil fungsi saat button diklik
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
              SizedBox(height: 30.h),
              if (providerSales.uploadProgress < 100)
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                  child: Column(
                    children: [
                      Text(
                        'Upload Progress: ${providerSales.uploadProgress.toStringAsFixed(2)}%',
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(height: 10.h),
                      LinearProgressIndicator(
                        value: providerSales.uploadProgress / 100,
                        minHeight: 10.h,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 10.h),
              if (providerSales.uploadProgress ==
                  100) // Show replace button after upload is complete
                WidgetButtonCustom(
                  title: 'Ganti File',
                  onpressed: _showImageSourceDialog,
                  bgColor: Colors.red,
                  color: Colors.white,
                  FullWidth: width,
                  FullHeight: 40.h,
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
                print(filepath);
                print(kode.text);
                print(nama.text);
                print(selectKategori);
                print(selectLokasi);
                print(selectUnit);
                // print(stok.text);
                print(harga.text);
                print(check);
                print(hargaJual.text);
                print(limit.text);
                print(selectVendor);

                try {
                  await Future.wait([
                    provider.createItem(
                        context,
                        kode.text,
                        nama.text,
                        selectKategori!,
                        selectUnit!,
                        double.parse(harga.text),
                        check,
                        (hargaJual.text == '')
                            ? 0
                            : double.parse(hargaJual.text),
                        int.parse(limit.text),
                        selectVendor!,
                        1,
                        filepath!),
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
