import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/model/modelCatatanCMD.dart';
import 'package:dwigasindo/providers/provider_sales.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:dwigasindo/widgets/widget_note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:timeline_list/timeline_list.dart';

class ComponentMenuCatatanMasterCustomer extends StatefulWidget {
  ComponentMenuCatatanMasterCustomer({
    super.key,
    required this.id,
  });
  final int id;
  @override
  State<ComponentMenuCatatanMasterCustomer> createState() =>
      _ComponentMenuCatatanMasterCustomerState();
}

class _ComponentMenuCatatanMasterCustomerState
    extends State<ComponentMenuCatatanMasterCustomer> {
  final GroupButtonController _groupButtonController = GroupButtonController(
    selectedIndex: 0, // "Tanki" berada pada indeks 0
  );
  bool selectButton = true;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<ProviderSales>(context);
    final data = provider.catatanCmd!.data;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: GroupButton(
                  isRadio: true,
                  controller: _groupButtonController,
                  options: GroupButtonOptions(
                      buttonWidth: 170.w,
                      selectedColor: PRIMARY_COLOR,
                      borderRadius: BorderRadius.circular(8),
                      elevation: 0),
                  onSelected: (value, index, isSelected) {
                    print('DATA KLIK : $value - $index - $isSelected');
                    setState(() {
                      selectButton =
                          index != 1; // False jika "BB Lainnya" dipilih
                    });
                  },
                  buttons: ['Catatan', "Dokumentasi"]),
            ),
            SizedBox(
              height: 10.h,
            ),
            (selectButton == true)
                ? Expanded(
                    child: Column(
                      children: [
                        WidgetButtonCustom(
                          FullWidth: width,
                          FullHeight: 40.h,
                          title: 'Tambah Catatan',
                          onpressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ComponentTambahProduk(
                                  id: widget.id,
                                ),
                              ),
                            );
                          },
                          color: PRIMARY_COLOR,
                          bgColor: PRIMARY_COLOR,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: data!.details!.length,
                            itemBuilder: (context, index) {
                              final dataC = data.details![index];
                              return CardCatatan(
                                  width: width,
                                  height: 150.h,
                                  role: dataC.role!,
                                  dataCatatan: dataC.notes);
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: Expanded(
                      child: CardDokumentasi(
                        width: width,
                        height: height,
                        id: widget.id,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class CardCatatan extends StatefulWidget {
  const CardCatatan(
      {super.key,
      required this.width,
      required this.height,
      required this.dataCatatan,
      required this.role});

  final double width;
  final double height;
  final List<Note>? dataCatatan;
  final String role;

  @override
  _CardCatatanState createState() => _CardCatatanState();
}

class _CardCatatanState extends State<CardCatatan> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 1),
            color: Colors.grey.shade400,
            blurRadius: 1,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header judul
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFF1D2340),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(
              widget.role,
              style: titleText,
              textAlign: TextAlign.center,
            ),
          ),

          // Timeline list
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Timeline.builder(
                physics: NeverScrollableScrollPhysics(),
                markerBuilder: (context, index) =>
                    _buildTimelineItem(widget.dataCatatan?[index]),
                context: context,
                markerCount: isExpanded ? widget.dataCatatan!.length : 1,
                properties: TimelineProperties(
                  markerGap: 0.h,
                  iconSize: 10.w,
                  timelinePosition: TimelinePosition.start,
                )),
          ),

          // Tombol Expand/Collapse
          Center(
            child: TextButton.icon(
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              icon: Icon(
                isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
              ),
              label: Text(isExpanded ? 'Tutup' : 'Lihat Semua'),
            ),
          ),
        ],
      ),
    );
  }

  /// Membuat item timeline untuk setiap data
  Marker _buildTimelineItem(Note? item) {
    final provider = Provider.of<ProviderSales>(context);
    return Marker(
      child: Container(
        width: 270.w,
        padding: const EdgeInsets.all(12),
        margin: EdgeInsets.only(left: 8.w, right: 8.w, bottom: 8.h, top: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${(item?.createdAt != null) ? provider.formatDate(item!.createdAt.toString()) : "-"} | ${(item?.createdAt != null) ? provider.formatTime(item!.createdAt.toString()) : "-"}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Oleh: ${(item?.createdBy != null) ? item?.createdBy : "-"}',
              style: subtitleTextNormal,
            ),
            SizedBox(height: 4.h),
            Text(
              "${(item?.note != null) ? item!.note : "-"}",
              textAlign: TextAlign.justify,
              style: subtitleTextNormalblack,
            ),
          ],
        ),
      ),
    );
  }
}

class CardDokumentasi extends StatefulWidget {
  const CardDokumentasi({
    super.key,
    required this.width,
    required this.height,
    required this.id,
  });

  final double width;
  final double height;
  final int id;

  @override
  _CardDokumentasiState createState() => _CardDokumentasiState();
}

class _CardDokumentasiState extends State<CardDokumentasi> {
  final List<File> images = []; // List untuk menyimpan gambar

  /// Fungsi untuk memilih gambar dari galeri atau kamera
  Future<void> pickImage(ImageSource source, int id) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      setState(() {
        images.add(imageFile); // Simpan gambar ke dalam list sementara
      });

      // Upload gambar ke server

      await Provider.of<ProviderSales>(context, listen: false)
          .uploadDoc(context, id, imageFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderSales>(context);
    final dataDoc = provider.documentationCMD!.data;
    return Container(
      width: widget.width,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 1),
            color: Colors.grey.shade400,
            blurRadius: 1,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFF1D2340),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: const Text(
              'Dokumentasi',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // GridView untuk menampilkan gambar
          Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: dataDoc!.length + images.length + 1,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 kolom per baris
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1, // Kotak gambar tetap proporsional
              ),
              itemBuilder: (context, index) {
                if (index < dataDoc.length) {
                  // Menampilkan gambar dari API (dataDoc)
                  return _buildImageNetwork(dataDoc[index].path!);
                } else if (index < dataDoc.length + images.length) {
                  // Menampilkan gambar yang baru di-upload
                  return _buildImageFile(images[index - dataDoc.length]);
                } else {
                  return _buildUploadButton(widget.id);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageNetwork(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        children: [
          Image.network(
            imageUrl,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Center(
                child: Icon(Icons.broken_image, size: 50, color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  /// Widget untuk menampilkan gambar yang di-upload
  Widget _buildImageFile(File imageFile) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        children: [
          Image.file(
            imageFile,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 5,
            right: 5,
            child: IconButton(
              onPressed: () {
                setState(() {
                  images.remove(imageFile); // Hapus gambar dari list
                });
              },
              icon: const Icon(Icons.cancel, color: Colors.red),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),
        ],
      ),
    );
  }

  /// Widget tombol upload gambar
  Widget _buildUploadButton(int id) {
    return GestureDetector(
      onTap: () => _showImagePickerDialog(id),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: const Center(
          child: Icon(Icons.add_a_photo, size: 40, color: Colors.grey),
        ),
      ),
    );
  }

  /// Menampilkan dialog untuk memilih sumber gambar (kamera atau galeri)
  void _showImagePickerDialog(int id) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Pilih dari Galeri'),
              onTap: () {
                Navigator.pop(context);
                pickImage(ImageSource.gallery, id);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Ambil dari Kamera'),
              onTap: () {
                Navigator.pop(context);
                pickImage(ImageSource.camera, id);
              },
            ),
          ],
        );
      },
    );
  }
}

class ComponentTambahProduk extends StatefulWidget {
  ComponentTambahProduk({super.key, required this.id});
  int id;
  @override
  State<ComponentTambahProduk> createState() => _ComponentTambahProdukState();
}

class _ComponentTambahProdukState extends State<ComponentTambahProduk> {
  quill.QuillController? controller;
  @override
  void initState() {
    super.initState();
    controller = quill.QuillController.basic(); // Inisialisasi controller
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<ProviderSales>(context);
    return Scaffold(
      appBar: WidgetAppbar(
        title: "Tambah Note",
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: width,
              height: 250.h,
              child: ListTile(
                contentPadding: EdgeInsets.only(left: 16.w, right: 20.w),
                title: Text(
                  'Catatan',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: NoteForm(controller: controller!)),
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
          ],
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
              title: 'Simpan',
              onpressed: () async {
                String note = controller!.document.toPlainText();
                await provider.createNote(context, widget.id, note);
              },
              bgColor: PRIMARY_COLOR,
              color: PRIMARY_COLOR),
        ),
      ),
    );
  }
}
