import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_produksi.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:group_button/group_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class TambahControlCompressor extends StatefulWidget {
  TambahControlCompressor({super.key, this.uuid, required this.title});
  String? uuid;
  String title;
  @override
  State<TambahControlCompressor> createState() =>
      _TambahControlCompressorState();
}

class _TambahControlCompressorState extends State<TambahControlCompressor> {
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
                    "Check Pressure",
                    style: titleTextBlack,
                  ),
                ),
              ),
              SizedBox(
                width: width,
                height: 80.h,
                child: ListTile(
                  title: Text(
                    'Stage 1',
                    style: subtitleTextBlack,
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: WidgetForm(
                      controller: kode,
                      alert: 'Stage 1',
                      hint: 'Stage 1',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.005,
              ),
              SizedBox(
                width: width,
                height: 80.h,
                child: ListTile(
                  title: Text(
                    'Stage 2',
                    style: subtitleTextBlack,
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: WidgetForm(
                      controller: kode,
                      alert: 'Stage 2',
                      hint: 'Stage 2',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.005,
              ),
              SizedBox(
                width: width,
                height: 80.h,
                child: ListTile(
                  title: Text(
                    'Stage 3',
                    style: subtitleTextBlack,
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: WidgetForm(
                      controller: kode,
                      alert: 'Stage 3',
                      hint: 'Stage 3',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Sirkulasi Pendigin",
                    style: titleTextBlack,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GroupButton(
                      isRadio: true,
                      enableDeselect: true,
                      options: GroupButtonOptions(
                          buttonWidth: 100.w,
                          selectedColor: PRIMARY_COLOR,
                          borderRadius: BorderRadius.circular(8),
                          elevation: 0),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                      },
                      buttons: const ['OK', "NOT OK"]),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Oli Pelumas (Mas. 300 Jam)",
                    style: titleTextBlack,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GroupButton(
                      isRadio: true,
                      enableDeselect: true,
                      options: GroupButtonOptions(
                          buttonWidth: 100.w,
                          selectedColor: PRIMARY_COLOR,
                          borderRadius: BorderRadius.circular(8),
                          elevation: 0),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                      },
                      buttons: const ['OK', "NOT OK"]),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Check Drain",
                    style: titleTextBlack,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Stage 1",
                    style: titleTextBlack,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GroupButton(
                      isRadio: true,
                      enableDeselect: true,
                      options: GroupButtonOptions(
                          buttonWidth: 100.w,
                          selectedColor: PRIMARY_COLOR,
                          borderRadius: BorderRadius.circular(8),
                          elevation: 0),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                      },
                      buttons: const ['OK', "NOT OK"]),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Stage 2",
                    style: titleTextBlack,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GroupButton(
                      isRadio: true,
                      enableDeselect: true,
                      options: GroupButtonOptions(
                          buttonWidth: 100.w,
                          selectedColor: PRIMARY_COLOR,
                          borderRadius: BorderRadius.circular(8),
                          elevation: 0),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                      },
                      buttons: const ['OK', "NOT OK"]),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Stage 3",
                    style: titleTextBlack,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GroupButton(
                      isRadio: true,
                      enableDeselect: true,
                      options: GroupButtonOptions(
                          buttonWidth: 100.w,
                          selectedColor: PRIMARY_COLOR,
                          borderRadius: BorderRadius.circular(8),
                          elevation: 0),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                      },
                      buttons: const ['OK', "NOT OK"]),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Check Safety Volve",
                    style: titleTextBlack,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Stage 1",
                    style: titleTextBlack,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GroupButton(
                      isRadio: true,
                      enableDeselect: true,
                      options: GroupButtonOptions(
                          buttonWidth: 100.w,
                          selectedColor: PRIMARY_COLOR,
                          borderRadius: BorderRadius.circular(8),
                          elevation: 0),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                      },
                      buttons: const ['OK', "NOT OK"]),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Stage 2",
                    style: titleTextBlack,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GroupButton(
                      isRadio: true,
                      enableDeselect: true,
                      options: GroupButtonOptions(
                          buttonWidth: 100.w,
                          selectedColor: PRIMARY_COLOR,
                          borderRadius: BorderRadius.circular(8),
                          elevation: 0),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                      },
                      buttons: const ['OK', "NOT OK"]),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Stage 3",
                    style: titleTextBlack,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GroupButton(
                      isRadio: true,
                      enableDeselect: true,
                      options: GroupButtonOptions(
                          buttonWidth: 100.w,
                          selectedColor: PRIMARY_COLOR,
                          borderRadius: BorderRadius.circular(8),
                          elevation: 0),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                      },
                      buttons: const ['OK', "NOT OK"]),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Purity",
                    style: titleTextBlack,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GroupButton(
                      isRadio: true,
                      enableDeselect: true,
                      options: GroupButtonOptions(
                          buttonWidth: 100.w,
                          selectedColor: PRIMARY_COLOR,
                          borderRadius: BorderRadius.circular(8),
                          elevation: 0),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                      },
                      buttons: const ['HP', "UHP"]),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ComponentIsiData(
                        idStr: 'a',
                      ),
                    ),
                  );
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

class ComponentIsiData extends StatefulWidget {
  ComponentIsiData({super.key, required this.idStr});
  String idStr;
  @override
  State<ComponentIsiData> createState() => _ComponentIsiDataState();
}

class _ComponentIsiDataState extends State<ComponentIsiData> {
  GroupButtonController? jenis = GroupButtonController();
  TextEditingController? levelAwalController = TextEditingController();
  TextEditingController? tekananAwalController = TextEditingController();
  TextEditingController? levelAkhirController = TextEditingController();
  TextEditingController? tekananAkhirController = TextEditingController();
  File? photoLevelStart; // Untuk foto level awal
  File? photoPressureStart; // Untuk foto tekanan awal
  File? photoLevelEnd; // Untuk foto level awal
  File? photoPressureEnd; // Untuk foto tekanan awal

  final ImagePicker _picker = ImagePicker();

  // @override
  // void initState() {
  //   super.initState();

  //   // Ambil data dari provider
  //   final provider = Provider.of<ProviderProduksi>(context, listen: false);
  //   final dataIsi = provider.isiData?.data;

  //   if (dataIsi != null) {
  //     // Jika ada data, masukkan ke form
  //     jenis?.selectIndex((dataIsi.isRefill ?? 0) == 0
  //         ? 0
  //         : (dataIsi.isRefill ?? 0) == 1
  //             ? 0
  //             : 1);
  //     levelAwalController?.text = (dataIsi.levelStart ?? '').toString();
  //     tekananAwalController?.text = (dataIsi.pressureStart ?? '').toString();
  //     levelAkhirController?.text = (dataIsi.levelEnd ?? '').toString();
  //     tekananAkhirController?.text = (dataIsi.pressureEnd ?? '').toString();
  //   } else {
  //     // Mode create dengan form kosong
  //     levelAwalController?.text = '';
  //     tekananAwalController?.text = '';
  //     levelAkhirController?.text = '';
  //     tekananAkhirController?.text = '';
  //   }
  // }

  // Fungsi untuk memilih gambar
  Future<void> _pickImage(
      ImageSource source, bool isLevelStart, bool isStartImage) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        if (isLevelStart && isStartImage) {
          photoLevelStart = File(pickedFile.path);
        } else if (!isLevelStart && isStartImage) {
          photoPressureStart = File(pickedFile.path);
        } else if (isLevelStart && !isStartImage) {
          photoLevelEnd = File(pickedFile.path);
        } else {
          photoPressureEnd = File(pickedFile.path);
        }
      });
    }
  }

  void _showImageSourceDialog(bool isLevelStart, bool isStartImage) {
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
                  _pickImage(ImageSource.camera, isLevelStart, isStartImage);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery, isLevelStart, isStartImage);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderProduksi>(context);
    final dataIsi = provider.isiData?.data;

    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Isi Data',
        colorBG: Colors.grey.shade100,
        center: true,
        sizefont: 20,
        colorBack: Colors.black,
        colorTitle: Colors.black,
        back: true,
        route: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Pilih Jenis Pengisian
            SizedBox(
              width: width,
              child: ListTile(
                title: Text(
                  'Pilih Jenis Pengisian',
                  style: titleTextBlack,
                ),
                subtitle: GroupButton(
                  controller: jenis,
                  isRadio: true,
                  options: GroupButtonOptions(
                    selectedColor: PRIMARY_COLOR,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  buttons: const ["Massal", "Single"],
                ),
              ),
            ),
            // Foto Level Awal
            Container(
              width: width,
              height: 80.h,
              margin: EdgeInsets.only(bottom: 25.h),
              child: Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () async => _showImageSourceDialog(
                      true, true), // Panggil fungsi saat button diklik
                  child: SizedBox(
                    width: width,
                    height: height * 0.1,
                    child: ListTile(
                      title: Text(
                        'Upload Image Level Awal',
                        style: subtitleTextBlack,
                      ),
                      subtitle: Container(
                        height: 100.h,
                        margin: EdgeInsets.only(top: height * 0.01),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: photoLevelStart != null
                            ? Image.file(
                                photoLevelStart!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
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
            // Isi Level Awal
            SizedBox(
              width: width,
              child: ListTile(
                title: Text('Isi Level Awal', style: subtitleTextBlack),
                subtitle: WidgetForm(
                  controller: levelAwalController,
                  alert: 'Isi Level Awal',
                  hint: 'Masukkan Level Awal',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            // Foto Tekanan Awal
            Container(
              width: width,
              height: 80.h,
              margin: EdgeInsets.only(bottom: 25.h),
              child: Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () async => _showImageSourceDialog(
                      false, true), // Panggil fungsi saat button diklik
                  child: SizedBox(
                    width: width,
                    height: height * 0.1,
                    child: ListTile(
                      title: Text(
                        'Upload Image Tekanan Awal',
                        style: subtitleTextBlack,
                      ),
                      subtitle: Container(
                        height: 100.h,
                        margin: EdgeInsets.only(top: height * 0.01),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: photoPressureStart != null
                            ? Image.file(
                                photoPressureStart!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
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
            // Isi Tekanan Awal
            SizedBox(
              width: width,
              child: ListTile(
                title: Text('Isi Tekanan Awal', style: subtitleTextBlack),
                subtitle: WidgetForm(
                  controller: tekananAwalController,
                  alert: 'Isi Tekanan Awal',
                  hint: 'Masukkan Tekanan Awal',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            // Tombol Submit
            Container(
              width: width,
              margin: EdgeInsets.symmetric(horizontal: width * 0.06),
              child: Align(
                alignment: Alignment.centerRight,
                child: WidgetButtonCustom(
                  FullWidth: width * 0.4,
                  FullHeight: height * 0.05,
                  title: 'Submit',
                  onpressed: () async {
                    if (photoLevelStart == null || photoPressureStart == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Harap pilih semua gambar')),
                      );
                      return;
                    }

                    if (levelAwalController!.text.isEmpty ||
                        tekananAwalController!.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Harap isi semua field')),
                      );
                      return;
                    }

                    await provider.createUpdateDataMix(
                      context,
                      widget.idStr, // Ganti dengan ID yang relevan
                      jenis!.selectedIndex == 0 ? 1 : 2, // isRefill
                      int.parse(levelAwalController!.text),
                      int.parse(tekananAwalController!.text),
                      photoLevelStart!,
                      photoPressureStart!,
                    );
                  },
                  bgColor: PRIMARY_COLOR,
                  color: Colors.transparent,
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: height * 0.06,
              child: Center(
                child: Text(
                  'Isi Data',
                  style: superTitleTextBlack,
                ),
              ),
            ),
            // Foto Level Akhir
            Container(
              width: width,
              height: 80.h,
              margin: EdgeInsets.only(bottom: 25.h),
              child: Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () async => _showImageSourceDialog(
                      true, false), // Panggil fungsi saat button diklik
                  child: SizedBox(
                    width: width,
                    height: height * 0.1,
                    child: ListTile(
                      title: Text(
                        'Upload Image Level Akhir',
                        style: subtitleTextBlack,
                      ),
                      subtitle: Container(
                        height: 100.h,
                        margin: EdgeInsets.only(top: height * 0.01),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: photoLevelEnd != null
                            ? Image.file(
                                photoLevelEnd!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
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
            // Isi Level Akhir
            SizedBox(
              width: width,
              child: ListTile(
                title: Text('Isi Level Akhir', style: subtitleTextBlack),
                subtitle: WidgetForm(
                  controller: levelAkhirController,
                  alert: 'Isi Level Akhir',
                  hint: 'Masukkan Level Akhir',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            // Foto Tekanan Akhir
            Container(
              width: width,
              height: 80.h,
              margin: EdgeInsets.only(bottom: 25.h),
              child: Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () async => _showImageSourceDialog(
                      false, false), // Panggil fungsi saat button diklik
                  child: SizedBox(
                    width: width,
                    height: height * 0.1,
                    child: ListTile(
                      title: Text(
                        'Upload Image Level Awal',
                        style: subtitleTextBlack,
                      ),
                      subtitle: Container(
                        height: 100.h,
                        margin: EdgeInsets.only(top: height * 0.01),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: photoPressureEnd != null
                            ? Image.file(
                                photoPressureEnd!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
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
            // Isi Tekanan Akhir
            SizedBox(
              width: width,
              child: ListTile(
                title: Text('Isi Tekanan Akhir', style: subtitleTextBlack),
                subtitle: WidgetForm(
                  controller: tekananAkhirController,
                  alert: 'Isi Tekanan Akhir',
                  hint: 'Masukkan Tekanan Akhir',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            // Tombol Submit
            Container(
              width: width,
              margin: EdgeInsets.symmetric(horizontal: width * 0.06),
              child: Align(
                alignment: Alignment.centerRight,
                child: WidgetButtonCustom(
                  FullWidth: width * 0.4,
                  FullHeight: height * 0.05,
                  title: 'Submit',
                  onpressed: () async {
                    if (photoLevelEnd == null || photoPressureEnd == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'Harap pilih gambar level dan tekanan akhir')),
                      );
                      return;
                    }

                    await provider.createUpdateDataMix(
                      context,
                      widget.idStr, // Ganti dengan ID yang relevan
                      jenis!.selectedIndex == 0 ? 1 : 2, // isRefill
                      int.parse(levelAkhirController!.text),
                      int.parse(tekananAkhirController!.text),
                      photoLevelEnd!,
                      photoPressureEnd!,
                    );
                  },
                  bgColor: PRIMARY_COLOR,
                  color: Colors.transparent,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}
