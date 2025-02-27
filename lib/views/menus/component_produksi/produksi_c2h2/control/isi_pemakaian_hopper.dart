import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class IsiPemakaianHopper extends StatefulWidget {
  IsiPemakaianHopper({super.key, this.uuid, required this.title});
  String? uuid;
  String title;
  @override
  State<IsiPemakaianHopper> createState() => _IsiPemakaianHopperState();
}

class _IsiPemakaianHopperState extends State<IsiPemakaianHopper> {
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  bool cek = false;

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

  TextEditingController kode = TextEditingController();
  TextEditingController keterangan = TextEditingController();

  SingleSelectController<String?> kategori =
      SingleSelectController<String?>(null);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: WidgetAppbar(
        title: widget.title,
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
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Jam Pemakaian Calcium Carbide",
                    style: titleTextBlack,
                  ),
                ),
              ),
              SizedBox(
                width: width,
                height: height * 0.1,
                child: ListTile(
                  title: Text(
                    'Hopper 1',
                    style: subtitleTextBlack,
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: WidgetForm(
                      controller: kode,
                      alert: 'Jam Pemakaian',
                      hint: 'Jam Pemakaian',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.005,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Jumlah Pemakaian Calcium Carbide",
                    style: titleTextBlack,
                  ),
                ),
              ),
              SizedBox(
                width: width,
                height: height * 0.1,
                child: ListTile(
                  title: Text(
                    'Hopper 1',
                    style: subtitleTextBlack,
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: WidgetForm(
                      controller: kode,
                      alert: 'Jumlah Pemakaian',
                      hint: 'Jumlah Pemakaian',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ),
              if (cek == true)
                SizedBox(
                  height: 10.h,
                ),
              if (cek == true)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Terkahir Pemakaian Calcium Carbide",
                      style: titleTextBlack,
                    ),
                  ),
                ),
              if (cek == true)
                SizedBox(
                  width: width,
                  height: 60.h,
                  child: Row(
                    children: [
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: 'Hopper 1\n', style: subtitleTextBlack),
                              TextSpan(text: '09:15', style: titleTextBlack),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: 'Jumlah\n', style: subtitleTextBlack),
                              TextSpan(text: '2 Drum', style: titleTextBlack),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              if (cek == true)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Jam Pemakaian Calcium Carbide",
                      style: titleTextBlack,
                    ),
                  ),
                ),
              if (cek == true)
                SizedBox(
                  width: width,
                  height: height * 0.1,
                  child: ListTile(
                    title: Text(
                      'Hopper 2',
                      style: subtitleTextBlack,
                    ),
                    subtitle: Container(
                      margin: EdgeInsets.only(top: height * 0.01),
                      child: WidgetForm(
                        controller: kode,
                        alert: 'Jam Pemakaian',
                        hint: 'Jam Pemakaian',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ),
              if (cek == true)
                SizedBox(
                  height: height * 0.005,
                ),
              if (cek == true)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Jumlah Pemakaian Calcium Carbide",
                      style: titleTextBlack,
                    ),
                  ),
                ),
              if (cek == true)
                SizedBox(
                  width: width,
                  height: height * 0.1,
                  child: ListTile(
                    title: Text(
                      'Hopper 2',
                      style: subtitleTextBlack,
                    ),
                    subtitle: Container(
                      margin: EdgeInsets.only(top: height * 0.01),
                      child: WidgetForm(
                        controller: kode,
                        alert: 'Jumlah Pemakaian',
                        hint: 'Jumlah Pemakaian',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
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
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ComponentIsiData(
                  //       idStr: 'a',
                  //     ),
                  //   ),
                  // );
                  Navigator.pop(context);
                  if (cek == false) {
                    setState(() {
                      cek = true;
                    });
                  } else {
                    setState(() {
                      cek = false;
                    });
                  }
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

class IsiWaktuDrain extends StatefulWidget {
  IsiWaktuDrain({super.key, this.uuid, required this.title});
  String? uuid;
  String title;
  @override
  State<IsiWaktuDrain> createState() => _IsiWaktuDrainState();
}

class _IsiWaktuDrainState extends State<IsiWaktuDrain> {
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  bool cek = false;

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

  TextEditingController kode = TextEditingController();
  TextEditingController keterangan = TextEditingController();

  SingleSelectController<String?> kategori =
      SingleSelectController<String?>(null);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: WidgetAppbar(
        title: widget.title,
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
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Waktu Drain",
                    style: titleTextBlack,
                  ),
                ),
              ),
              SizedBox(
                width: width,
                height: height * 0.1,
                child: ListTile(
                  title: Text(
                    'High',
                    style: subtitleTextBlack,
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: WidgetForm(
                      controller: kode,
                      alert: 'Jam Drain',
                      hint: 'Jam Drain',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
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
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ComponentIsiData(
                  //       idStr: 'a',
                  //     ),
                  //   ),
                  // );
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
