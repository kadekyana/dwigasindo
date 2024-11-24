import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_dropdown.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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

  int? selectKategori;
  int? selectVendor;
  int? selectLokasi;
  int? selectUnit;

  TextEditingController kode = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController stok = TextEditingController();
  TextEditingController harga = TextEditingController();
  TextEditingController limit = TextEditingController();
  TextEditingController supplier = TextEditingController();

  SingleSelectController<String?> kategori =
      SingleSelectController<String?>(null);

  SingleSelectController<String?> lokasi =
      SingleSelectController<String?>(null);

  SingleSelectController<String?> mou = SingleSelectController<String?>(null);
  SingleSelectController<String?> vendor =
      SingleSelectController<String?>(null);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<ProviderItem>(context);

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
      backgroundColor: Colors.grey.shade100,
      appBar: WidgetAppbar(
        title: 'Tambah Tabung',
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: width,
                height: height * 0.1,
                child: ListTile(
                  title: Text(
                    'Kode Item',
                    style: TextStyle(color: Colors.black),
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
              Container(
                width: width,
                height: height * 0.1,
                child: ListTile(
                  title: Text(
                    'Nama Item',
                    style: TextStyle(color: Colors.black),
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
              Container(
                width: width,
                height: height * 0.1,
                child: ListTile(
                  title: Text(
                    'Kategori Item',
                    style: subtitleTextBlack,
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
              SizedBox(height: height * 0.01),
              Container(
                width: width,
                height: height * 0.1,
                child: ListTile(
                  title: Text(
                    'Lokasi',
                    style: subtitleTextBlack,
                  ),
                  subtitle: CustomDropdown(
                    items: locations!.map((e) => e['name']).toList(),
                    hintText: 'Lokasi',
                    controller: lokasi,
                    onChanged: (value) {
                      if (value != null) {
                        final ID = locations.firstWhere(
                          (item) => item['name'] == value,
                        );
                        setState(() {
                          selectLokasi = int.parse(ID['id'].toString());
                        });
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: height * 0.01),
              Container(
                width: width,
                height: height * 0.1,
                child: ListTile(
                  title: Text(
                    'Satuan (MoU)',
                    style: subtitleTextBlack,
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
              SizedBox(
                height: height * 0.01,
              ),
              Container(
                width: width,
                height: height * 0.1,
                child: ListTile(
                  title: Text(
                    'Stok Item',
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: WidgetForm(
                      controller: stok,
                      alert: 'Stok',
                      hint: 'Stok',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                width: width,
                height: height * 0.1,
                child: ListTile(
                  title: Text(
                    'Harga Stok',
                    style: TextStyle(color: Colors.black),
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
              Container(
                width: width,
                height: height * 0.1,
                child: ListTile(
                  title: Text(
                    'Limit Stok',
                    style: TextStyle(color: Colors.black),
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
              Container(
                width: width,
                height: height * 0.1,
                child: ListTile(
                  title: Text(
                    'Vendors / Supplier',
                    style: subtitleTextBlack,
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
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: _pickImage, // Panggil fungsi saat button diklik
                  child: Container(
                    width: width * 0.55,
                    height: height * 0.1,
                    child: ListTile(
                      title: Text(
                        'Upload Image',
                        style: TextStyle(color: Colors.black),
                      ),
                      subtitle: Container(
                        margin: EdgeInsets.only(top: height * 0.01),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: _imageFile != null
                              ? Image.file(
                                  _imageFile!,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                )
                              : SvgPicture.asset('assets/images/gambar.svg'),
                          title: Text(
                            'Upload Image',
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: width,
        height: height * 0.06,
        child: Align(
          alignment: Alignment.topCenter,
          child: WidgetButtonCustom(
              FullWidth: width * 0.9,
              FullHeight: height * 0.05,
              title: 'Submit',
              onpressed: () async {
                print(
                    "${kode.text}, ${nama.text}, ${kategori.value}, ${lokasi.value}, ${mou.value}, ${stok.text}, ${harga.text}, ${limit.text} ,${_imageFile?.path}");

                provider.createItem(
                    context,
                    kode.text,
                    nama.text,
                    selectKategori!,
                    selectLokasi!,
                    selectUnit!,
                    int.parse(stok.text),
                    int.parse(harga.text),
                    int.parse(limit.text),
                    selectVendor!,
                    1);
              },
              bgColor: PRIMARY_COLOR,
              color: PRIMARY_COLOR),
        ),
      ),
    );
  }
}
