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

class ComponentFormAsset extends StatefulWidget {
  ComponentFormAsset({super.key, required this.title});
  String title;
  @override
  State<ComponentFormAsset> createState() => _ComponentFormAssetState();
}

class _ComponentFormAssetState extends State<ComponentFormAsset> {
  int? selectLokasi;
  int? selectPic;

  TextEditingController nama = TextEditingController();
  TextEditingController lokasi = TextEditingController();
  TextEditingController picC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<ProviderItem>(context);
    final providerSales = Provider.of<ProviderSales>(context);

    final locations = provider.location?.data
        .map((data) => {'id': data.id, 'name': data.name})
        .toList();

    final pic = providerSales.modelUsersPic!.data
        ?.map((data) => {'id': data.id, 'name': data.name})
        .toList();

    return Scaffold(
      appBar: WidgetAppbar(
        title: '${widget.title}',
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
                    'Asset',
                    style: subtitleTextBlack,
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: WidgetForm(
                      controller: nama,
                      alert: 'Otomatis Terisi',
                      hint: 'Otomatis Terisi',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              if (widget.title == 'Check In Asset')
                SizedBox(
                  width: width,
                  height: 80.h,
                  child: ListTile(
                    title: Container(
                      margin: EdgeInsets.only(bottom: 8.h),
                      child: Text(
                        'Lokasi',
                        style: subtitleTextBlack,
                      ),
                    ),
                    subtitle: CustomAutocomplete(
                      data: locations!.map((e) => e['name']).toList(),
                      displayString: (item) => item.toString(),
                      onSelected: (value) {
                        if (value != null) {
                          final ID = locations.firstWhere(
                            (item) => item['name'] == value,
                          );
                          setState(() {
                            selectLokasi = int.parse(ID['id'].toString());
                          });
                          print(selectLokasi);
                        }
                      },
                      labelText: 'Cari Barang',
                      controller: lokasi,
                    ),
                  ),
                ),
              if (widget.title == 'Check Out Asset')
                SizedBox(
                  width: width,
                  height: 80.h,
                  child: ListTile(
                    title: Container(
                      margin: EdgeInsets.only(bottom: 8.h),
                      child: Text(
                        'Pic',
                        style: subtitleTextBlack,
                      ),
                    ),
                    subtitle: CustomAutocomplete(
                      data: pic!.map((e) => e['name']).toList(),
                      displayString: (item) => item.toString(),
                      onSelected: (value) {
                        if (value != null) {
                          final ID = pic.firstWhere(
                            (item) => item['name'] == value,
                          );
                          setState(() {
                            selectPic = int.parse(ID['id'].toString());
                          });
                          print(selectPic);
                        }
                      },
                      labelText: 'Cari Barang',
                      controller: picC,
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
                    //     double.parse(harga.text),
                    //     check,
                    //     (hargaJual.text == '')
                    //         ? 0
                    //         : double.parse(hargaJual.text),
                    //     int.parse(limit.text),
                    //     selectVendor!,
                    //     1,
                    //     filepath!),
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

class ComponentFormCheckOut extends StatefulWidget {
  ComponentFormCheckOut({super.key, this.title});
  String? title;
  @override
  State<ComponentFormCheckOut> createState() => _ComponentFormCheckOutState();
}

class _ComponentFormCheckOutState extends State<ComponentFormCheckOut> {
  TextEditingController nama = TextEditingController();
  TextEditingController qty = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: WidgetAppbar(
        title: '${widget.title ?? "Check Out Komponen"}',
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
              if (widget.title == null)
                SizedBox(
                  width: width,
                  height: height * 0.1,
                  child: ListTile(
                    title: Text(
                      'Komponen',
                      style: subtitleTextBlack,
                    ),
                    subtitle: Container(
                      margin: EdgeInsets.only(top: height * 0.01),
                      child: WidgetForm(
                        controller: nama,
                        enable: false,
                        alert: 'Otomatis Terisi',
                        hint: 'Otomatis Terisi',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ),
              if (widget.title != null)
                SizedBox(
                  width: width,
                  height: height * 0.1,
                  child: ListTile(
                    title: Text(
                      'Komponen',
                      style: subtitleTextBlack,
                    ),
                    subtitle: Container(
                      margin: EdgeInsets.only(top: height * 0.01),
                      child: WidgetForm(
                        controller: nama,
                        alert: 'Masukkan Komponen',
                        hint: 'Masukkan Komponen',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ),

              SizedBox(
                width: width,
                height: height * 0.1,
                child: ListTile(
                  title: Text(
                    'Qty',
                    style: subtitleTextBlack,
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: WidgetForm(
                      controller: qty,
                      alert: 'Qty',
                      hint: 'Qty',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              // if (widget.title == null)
              //   SizedBox(
              //     width: width,
              //     height: height * 0.1,
              //     child: ListTile(
              //       title: Container(
              //         margin: EdgeInsets.only(bottom: 8.h),
              //         child: Text(
              //           'Komponen',
              //           style: subtitleTextBlack,
              //         ),
              //       ),
              //       subtitle: CustomDropdown(
              //         items: ["a", "b"],
              //         hintText: 'Komponen',
              //         onChanged: (value) {
              //           if (value != null) {}
              //         },
              //       ),
              //     ),
              //   ),

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
                  await Future.wait([]);

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

class ComponentFormCheckIn extends StatefulWidget {
  ComponentFormCheckIn({super.key, this.title});
  String? title;
  @override
  State<ComponentFormCheckIn> createState() => _ComponentFormCheckInState();
}

class _ComponentFormCheckInState extends State<ComponentFormCheckIn> {
  TextEditingController nama = TextEditingController();
  TextEditingController qty = TextEditingController();

  List<Map<String, dynamic>> formList = []; // List untuk menyimpan data form
  // Fungsi untuk menambah form baru
  void _addForm() {
    setState(() {
      formList.add({
        "compoent_id": null,
        "qty": null,
      });
    });
  }

  void _removeForm(int index) {
    setState(() {
      formList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: WidgetAppbar(
        title: '${widget.title ?? "Check Out Komponen"}',
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
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: formList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SizedBox(
                        width: width,
                        height: height * 0.1,
                        child: ListTile(
                          title: Container(
                            margin: EdgeInsets.only(bottom: 8.h),
                            child: Text(
                              'Komponen',
                              style: subtitleTextBlack,
                            ),
                          ),
                          subtitle: CustomDropdown(
                            items: ["a", "b"],
                            hintText: 'Komponen',
                            onChanged: (value) {
                              if (value != null) {}
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width,
                        height: height * 0.1,
                        child: ListTile(
                          title: Text(
                            'Qty',
                            style: subtitleTextBlack,
                          ),
                          subtitle: Container(
                            margin: EdgeInsets.only(top: height * 0.01),
                            child: WidgetForm(
                              controller: qty,
                              alert: 'Qty',
                              hint: 'Qty',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                width: width,
                height: height * 0.06,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: WidgetButtonCustom(
                      FullWidth: width * 0.9,
                      FullHeight: 40.h,
                      title: 'Tambah Form Komponen',
                      onpressed: _addForm,
                      bgColor: PRIMARY_COLOR,
                      color: PRIMARY_COLOR),
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
                  await Future.wait([]);

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
