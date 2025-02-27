import 'dart:io';
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

  @override
  void initState() {
    super.initState();

    // Ambil data dari provider
    final provider = Provider.of<ProviderProduksi>(context, listen: false);
    final dataIsi = provider.isiData?.data;

    if (dataIsi != null) {
      // Jika ada data, masukkan ke form
      jenis?.selectIndex((dataIsi.isRefill ?? 0) == 0
          ? 0
          : (dataIsi.isRefill ?? 0) == 1
              ? 0
              : 1);
      levelAwalController?.text = (dataIsi.levelStart ?? '').toString();
      tekananAwalController?.text = (dataIsi.pressureStart ?? '').toString();
      levelAkhirController?.text = (dataIsi.levelEnd ?? '').toString();
      tekananAkhirController?.text = (dataIsi.pressureEnd ?? '').toString();

      // Inisialisasi file gambar
      // if (dataIsi.photoLevelStart != null &&
      //     dataIsi.photoLevelStart!.isNotEmpty) {
      //   photoLevelStart = File(dataIsi.photoLevelStart!);
      // }
      // if (dataIsi.photoPressureStart != null &&
      //     dataIsi.photoPressureStart!.isNotEmpty) {
      //   photoPressureStart = File(dataIsi.photoPressureStart!);
      // }
      // if (dataIsi.photoLevelEnd != null && dataIsi.photoLevelEnd!.isNotEmpty) {
      //   photoLevelEnd = File(dataIsi.photoLevelEnd!);
      // }
      // if (dataIsi.photoPressureEnd != null &&
      //     dataIsi.photoPressureEnd!.isNotEmpty) {
      //   photoPressureEnd = File(dataIsi.photoPressureEnd!);
      // }
    } else {
      // Mode create dengan form kosong
      levelAwalController?.text = '';
      tekananAwalController?.text = '';
      levelAkhirController?.text = '';
      tekananAkhirController?.text = '';
    }
  }

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
        title: 'Isi Data Mix Gas',
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
                  buttons: const ["Filling", "Refilling"],
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
