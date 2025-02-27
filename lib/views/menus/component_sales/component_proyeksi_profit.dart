import 'dart:io';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_sales.dart';
import 'package:dwigasindo/views/menus/component_sales/component_data_master_customer.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ComponentProyeksiProfitUI extends StatefulWidget {
  const ComponentProyeksiProfitUI({
    super.key,
    required this.id,
  });
  final int id;
  @override
  State<ComponentProyeksiProfitUI> createState() =>
      _ComponentProyeksiProfitUIState();
}

class _ComponentProyeksiProfitUIState extends State<ComponentProyeksiProfitUI> {
  final GroupButtonController _groupButtonController = GroupButtonController(
    selectedIndex: 0, // "Tanki" berada pada indeks 0
  );
  bool selectButton = true;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<ProviderSales>(context);
    final data = provider.dataProyeksi?.data;
    final alokasi = provider.alokasi?.data;
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
                  buttons: const ['Proyeksi', "Alokasi"]),
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
                          title: 'Tambah Proyeksi',
                          onpressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ComponentProyeksiProfit(
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
                        (data == null)
                            ? const Expanded(
                                child: Center(
                                  child: Text('Belum Terdapat Data'),
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    final dataCard = data[index];

                                    return Container(
                                      width: double.maxFinite,
                                      height: 160.h,
                                      margin: EdgeInsets.only(
                                          bottom: height * 0.02),
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
                                          SizedBox(
                                            width: double.maxFinite,
                                            height: 40.h,
                                            child: Stack(
                                              children: [
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Container(
                                                    width: 120
                                                        .w, // 30% dari lebar layar
                                                    height: double.infinity,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color:
                                                          PRIMARY_COLOR, // Warna biru tua
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(8),
                                                        bottomRight:
                                                            Radius.circular(30),
                                                      ),
                                                    ),
                                                    alignment: Alignment.center,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10),
                                                    child: Text(
                                                        dataCard.productName ??
                                                            "No Name",
                                                        style: titleText),
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
                                                  vertical: 5.h),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  top: BorderSide(
                                                      color:
                                                          Colors.grey.shade300),
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 80.w,
                                                    height: 100.h,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12)),
                                                  ),
                                                  SizedBox(width: 10.w),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Column(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Expanded(
                                                                flex: 1,
                                                                child:
                                                                    FittedBox(
                                                                  fit: BoxFit
                                                                      .scaleDown,
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child: Text(
                                                                      'Nama',
                                                                      style:
                                                                          subtitleTextNormalblack),
                                                                ),
                                                              ),
                                                              const Text(':'),
                                                              Expanded(
                                                                flex: 3,
                                                                child: Text(
                                                                  '\t${dataCard.productName}',
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      subtitleTextNormalblack,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Expanded(
                                                                flex: 1,
                                                                child:
                                                                    FittedBox(
                                                                  fit: BoxFit
                                                                      .scaleDown,
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child: Text(
                                                                      'Dibuat Oleh',
                                                                      style:
                                                                          subtitleTextNormalblack),
                                                                ),
                                                              ),
                                                              const Text(':'),
                                                              Expanded(
                                                                flex: 3,
                                                                child: Text(
                                                                  '\t${dataCard.createdBy}',
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      subtitleTextNormalblack,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                flex: 1,
                                                                child:
                                                                    FittedBox(
                                                                  fit: BoxFit
                                                                      .scaleDown,
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child: Text(
                                                                      'Dibuat Pada',
                                                                      style:
                                                                          subtitleTextNormalblack),
                                                                ),
                                                              ),
                                                              const Text(':'),
                                                              Expanded(
                                                                flex: 3,
                                                                child: Text(
                                                                  '\t${provider.formatDate(dataCard.createdAt.toString())} | ${provider.formatTime(dataCard.createdAt.toString())}',
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      subtitleTextNormalblack,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10.w,
                                                  right: 10.w,
                                                  bottom: 5.h),
                                              child: WidgetButtonCustom(
                                                FullWidth: width,
                                                FullHeight: 40.h,
                                                title: "Ubah ",
                                                onpressed: () {},
                                                bgColor: PRIMARY_COLOR,
                                                color: Colors.transparent,
                                              ),
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
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: alokasi!.length,
                      itemBuilder: (context, index) {
                        final dataC = alokasi[index];

                        return Container(
                          width: double.maxFinite,
                          height: 160.h,
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
                              SizedBox(
                                width: double.maxFinite,
                                height: 40.h,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        width: 120.w, // 30% dari lebar layar
                                        height: double.infinity,
                                        decoration: const BoxDecoration(
                                          color:
                                              PRIMARY_COLOR, // Warna biru tua
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(30),
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                            dataC.productName ?? "No Name",
                                            style: titleText),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 5.h),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                          color: Colors.grey.shade300),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          'Sales /bulan',
                                                          style:
                                                              subtitleTextNormalblack),
                                                    ),
                                                  ),
                                                  const Text(':'),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      '\t${dataC.salesPerMonth}',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          subtitleTextNormalblack,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          'TO Tabung/Cradle',
                                                          style:
                                                              subtitleTextNormalblack),
                                                    ),
                                                  ),
                                                  const Text(':'),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      '\t${dataC.toTubeCraddle}',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          subtitleTextNormalblack,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          'Stok Tersedia',
                                                          style:
                                                              subtitleTextNormalblack),
                                                    ),
                                                  ),
                                                  const Text(':'),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      '\t${dataC.availableTube}',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          subtitleTextNormalblack,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          'Alokasi Tabung',
                                                          style:
                                                              subtitleTextNormalblack),
                                                    ),
                                                  ),
                                                  const Text(':'),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      '\t${(dataC.salesPerMonth)! / (dataC.toTubeCraddle)!}',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          subtitleTextNormalblack,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text('Penambahan',
                                                          style:
                                                              subtitleTextNormalblack),
                                                    ),
                                                  ),
                                                  const Text(':'),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      '\t${(dataC.availableTube)! / (dataC.allocationTube)!}',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          subtitleTextNormalblack,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
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
