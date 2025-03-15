import 'dart:async';
import 'dart:io';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_Order.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/providers/provider_item.dart';
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

class ComponentDetailMaintenance extends StatefulWidget {
  ComponentDetailMaintenance({super.key});

  @override
  _ComponentDetailMaintenanceState createState() =>
      _ComponentDetailMaintenanceState();
}

class _ComponentDetailMaintenanceState extends State<ComponentDetailMaintenance>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int currentIndex = 0;
  Set<int> expandedCards = {};

  final TextEditingController tare = TextEditingController();
  final TextEditingController empty = TextEditingController();

  GroupButtonController? menu = GroupButtonController(selectedIndex: 0);
  bool selectMenu = true;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this);

    _tabController.addListener(() {
      setState(() {
        currentIndex = _tabController.index;
      });
      print(currentIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<ProviderSales>(context);
    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Nama Asset',
        colorBG: Colors.grey.shade100,
        colorTitle: Colors.black,
        colorBack: Colors.black,
        back: true,
        center: true,
        route: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Container(
            width: width,
            height: 150.h,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(12)),
                ),
                SizedBox(
                  width: 10.w,
                ),
                if (currentIndex == 1)
                  Container(
                    width: 200.w,
                    height: 40.h,
                    child: WidgetButtonCustom(
                      FullWidth: width,
                      FullHeight: 40.h,
                      title: "Selesai Maintenance",
                      color: PRIMARY_COLOR,
                      bgColor: PRIMARY_COLOR,
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: "Detail"),
              Tab(text: "Maintenance"),
              Tab(text: "History"),
              Tab(text: "File"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ComponentListDetail(),
                ComponentMaintenance(),
                CompponentListHistory(),
                CardDokumentasi(width: width, height: height, id: 1),
              ],
            ),
          )
        ],
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

      final provider = Provider.of<ProviderSales>(context, listen: false);
      final filePath = await provider.uploadFile(
          context, imageFile, imageFile.path.split("/").last);
      await provider.uploadDocCustomer(context, widget.id, filePath);
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
                } else if (index == dataDoc.length) {
                  // Menampilkan tombol upload di slot terakhir
                  return _buildUploadButton(widget.id);
                }
              },
            ),
          ),

          if (provider.uploadProgress > 0)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                children: [
                  LinearProgressIndicator(
                    value: provider.uploadProgress / 100,
                    backgroundColor: Colors.grey[300],
                    color: Colors.blue,
                  ),
                  SizedBox(height: 10),
                  Text((provider.uploadProgress < 100)
                      ? "${provider.uploadProgress.toStringAsFixed(2)}% Uploading..."
                      : "Berhasil Upload"),
                ],
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

class ComponentListDetail extends StatefulWidget {
  const ComponentListDetail({
    super.key,
  });

  @override
  State<ComponentListDetail> createState() => _ComponentListDetailState();
}

class _ComponentListDetailState extends State<ComponentListDetail> {
  List<bool> check = [true, false];
  bool non = false;
  GroupButtonController? menu = GroupButtonController(selectedIndex: 0);
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderSales>(context);

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: (provider.produk!.data!.isEmpty)
                  ? const Center(
                      child: Text('Belum Terdapat Produk Trash'),
                    )
                  : Container(
                      width: double.maxFinite,
                      height: 100.h,
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 5.h),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(color: Colors.grey.shade300),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
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
                                                    'Nama Asset',
                                                    style:
                                                        subtitleTextNormalblack,
                                                  ),
                                                ),
                                              ),
                                              const Text(':'),
                                              Expanded(
                                                flex: 3,
                                                child: Text('Lorem Ipsum',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        subtitleTextNormalblack),
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
                                                    'Lokasi Aseet',
                                                    style:
                                                        subtitleTextNormalblack,
                                                  ),
                                                ),
                                              ),
                                              const Text(':'),
                                              Expanded(
                                                flex: 3,
                                                child: Text('Lorem Ipsum',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        subtitleTextNormalblack),
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
                                                    'Serial',
                                                    style:
                                                        subtitleTextNormalblack,
                                                  ),
                                                ),
                                              ),
                                              const Text(':'),
                                              Expanded(
                                                flex: 3,
                                                child: Text('Lorem Ipsum',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        subtitleTextNormalblack),
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
                                                    'Tanggal Pembelian',
                                                    style:
                                                        subtitleTextNormalblack,
                                                  ),
                                                ),
                                              ),
                                              const Text(':'),
                                              Expanded(
                                                flex: 3,
                                                child: Text('Lorem Ipsum',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        subtitleTextNormalblack),
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
                                                    'Supplier',
                                                    style:
                                                        subtitleTextNormalblack,
                                                  ),
                                                ),
                                              ),
                                              const Text(':'),
                                              Expanded(
                                                flex: 3,
                                                child: Text('Lorem Ipsum',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        subtitleTextNormalblack),
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
                                                    'Asset',
                                                    style:
                                                        subtitleTextNormalblack,
                                                  ),
                                                ),
                                              ),
                                              const Text(':'),
                                              Expanded(
                                                flex: 3,
                                                child: Text('Lorem Ipsum',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        subtitleTextNormalblack),
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
                                                    'Jenis Asset',
                                                    style:
                                                        subtitleTextNormalblack,
                                                  ),
                                                ),
                                              ),
                                              const Text(':'),
                                              Expanded(
                                                flex: 3,
                                                child: Text('Lorem Ipsum',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        subtitleTextNormalblack),
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
                                                    'Merek',
                                                    style:
                                                        subtitleTextNormalblack,
                                                  ),
                                                ),
                                              ),
                                              const Text(':'),
                                              Expanded(
                                                flex: 3,
                                                child: Text('Lorem Ipsum',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        subtitleTextNormalblack),
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
                                                    'Departement',
                                                    style:
                                                        subtitleTextNormalblack,
                                                  ),
                                                ),
                                              ),
                                              const Text(':'),
                                              Expanded(
                                                flex: 3,
                                                child: Text('Lorem Ipsum',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        subtitleTextNormalblack),
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
                                                    'Harga',
                                                    style:
                                                        subtitleTextNormalblack,
                                                  ),
                                                ),
                                              ),
                                              const Text(':'),
                                              Expanded(
                                                flex: 3,
                                                child: Text('Rp. 100.000.000',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        subtitleTextNormalblack),
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
                                                    'Garansi',
                                                    style:
                                                        subtitleTextNormalblack,
                                                  ),
                                                ),
                                              ),
                                              const Text(':'),
                                              Expanded(
                                                flex: 3,
                                                child: Text('\t2 Bulan',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        subtitleTextNormalblack),
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
                                                    'Deskripsi',
                                                    style:
                                                        subtitleTextNormalblack,
                                                  ),
                                                ),
                                              ),
                                              const Text(':'),
                                              Expanded(
                                                flex: 3,
                                                child: Text('\tLorem Ipsum',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        subtitleTextNormalblack),
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
                                                    'Dibuat Pada',
                                                    style:
                                                        subtitleTextNormalGrey,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                ':',
                                                style: subtitleTextNormalGrey,
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Text('\t12/01/2025',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        subtitleTextNormalGrey),
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
                                                    'Dibuat Oleh',
                                                    style:
                                                        subtitleTextNormalGrey,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                ':',
                                                style: subtitleTextNormalGrey,
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Text('\tUser 1',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        subtitleTextNormalGrey),
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
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class ComponentMaintenance extends StatefulWidget {
  ComponentMaintenance({
    super.key,
    this.title,
  });

  String? title;
  @override
  State<ComponentMaintenance> createState() => _CompponentLisKomponenState();
}

class _CompponentLisKomponenState extends State<ComponentMaintenance> {
  List<bool> check = [true, false];
  bool non = false;
  GroupButtonController? menu = GroupButtonController(selectedIndex: 0);
  TextEditingController search = TextEditingController();
  TextEditingController nama = TextEditingController();
  int vendorId = 0;

  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  TextEditingController? controller = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final providerSales = Provider.of<ProviderSales>(context);

    return Scaffold(
      appBar: (widget.title == 'Maintenance')
          ? WidgetAppbar(
              title: 'Maintenance',
              colorBG: Colors.grey.shade100,
              colorTitle: Colors.black,
              colorBack: Colors.black,
              back: true,
              center: true,
              route: () {
                Navigator.pop(context);
              },
            )
          : null,
      body: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            if (widget.title != null)
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
            if (widget.title != null)
              SizedBox(
                height: 10.h,
              ),
            SizedBox(
              width: width,
              height: 100.h,
              child: Center(
                child: ListTile(
                  title: Text(
                    'Vendors',
                    style: subtitleTextBlack,
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: Consumer<ProviderItem>(
                      builder: (context, provider, child) {
                        final pic = provider.supplier!.data
                            .map((data) => {'id': data.id, 'name': data.name})
                            .toList();

                        return CustomDropdown(
                          decoration: CustomDropdownDecoration(
                              closedBorder:
                                  Border.all(color: Colors.grey.shade400),
                              expandedBorder:
                                  Border.all(color: Colors.grey.shade400)),
                          hintText: 'Pilih Vendors',
                          items: pic.map((e) => e['name']).toList(),
                          onChanged: (item) {
                            print("Selected Item: $item");

                            final selected = pic.firstWhere(
                              (e) => e['name'] == item,
                            );

                            setState(() {
                              vendorId = int.parse(selected['id'].toString());
                            });

                            print("Selected ID: $vendorId");
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 150.h,
              child: ListTile(
                title: Text(
                  'Keterangan',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  height: 110.h,
                  child: TextField(
                    maxLines: null,
                    expands: true,
                    decoration: InputDecoration(
                      hintText: 'Masukkan keterangan di sini...',
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    style: subtitleTextBlack,
                    textAlignVertical: TextAlignVertical.top,
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
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
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
          ],
        ),
      ),
    );
  }
}

class CompponentListHistory extends StatefulWidget {
  const CompponentListHistory({
    super.key,
  });

  @override
  State<CompponentListHistory> createState() => _CompponentListHistoryState();
}

class _CompponentListHistoryState extends State<CompponentListHistory> {
  List<bool> check = [true, false];
  bool non = false;
  GroupButtonController? menu = GroupButtonController(selectedIndex: 0);
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderSales>(context);
    final providerDis = Provider.of<ProviderDistribusi>(context);

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: (provider.produk!.data!.isEmpty)
                  ? const Center(
                      child: Text('Belum Terdapat Produk Trash'),
                    )
                  : ListView.builder(
                      itemCount: provider.produk!.data!.length,
                      itemBuilder: (context, index) {
                        final data = provider.produk?.data![index];
                        return Container(
                          width: double.maxFinite,
                          height: 150.h,
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
                                    // Bagian hijau (OK)
                                    // Bagian biru (No. 12345)
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
                                            (data?.type == 1)
                                                ? "Asset"
                                                : "Komponen",
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
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'Tipe',
                                                        style:
                                                            subtitleTextNormalblack,
                                                      ),
                                                    ),
                                                  ),
                                                  const Text(':'),
                                                  Expanded(
                                                    child: Text('\tCheck In',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            subtitleTextNormalblack),
                                                  ),
                                                  const Text('|'),
                                                  Expanded(
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        '\tLokasi',
                                                        style:
                                                            subtitleTextNormalblack,
                                                      ),
                                                    ),
                                                  ),
                                                  const Text(':'),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                        '\tBr Dinas Budakeling , Bebandem , Karangasem',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            subtitleTextNormalblack),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'Dibuat Oleh',
                                                        style:
                                                            subtitleTextNormalGrey,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    ':',
                                                    style:
                                                        subtitleTextNormalGrey,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                        '\t${data!.createdBy}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            subtitleTextNormalGrey),
                                                  ),
                                                  Expanded(
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'Dibuat Pada',
                                                        style:
                                                            subtitleTextNormalGrey,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    ':',
                                                    style:
                                                        subtitleTextNormalGrey,
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                        '\t${provider.formatDate(data!.createdAt.toString())} | ${provider.formatTime(data.createdAt.toString())}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            subtitleTextNormalGrey),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'Tipe',
                                                        style:
                                                            subtitleTextNormalblack,
                                                      ),
                                                    ),
                                                  ),
                                                  const Text(':'),
                                                  Expanded(
                                                    child: Text('\tCheck Out',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            subtitleTextNormalblack),
                                                  ),
                                                  const Text('|'),
                                                  Expanded(
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        '\tPIC',
                                                        style:
                                                            subtitleTextNormalblack,
                                                      ),
                                                    ),
                                                  ),
                                                  const Text(':'),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                        '\tDwi Gitayana Putra',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            subtitleTextNormalblack),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'Dibuat Oleh',
                                                        style:
                                                            subtitleTextNormalGrey,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    ':',
                                                    style:
                                                        subtitleTextNormalGrey,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                        '\t${data!.createdBy}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            subtitleTextNormalGrey),
                                                  ),
                                                  Expanded(
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'Dibuat Pada',
                                                        style:
                                                            subtitleTextNormalGrey,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    ':',
                                                    style:
                                                        subtitleTextNormalGrey,
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                        '\t${provider.formatDate(data!.createdAt.toString())} | ${provider.formatTime(data.createdAt.toString())}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            subtitleTextNormalGrey),
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

class CompponetListArsip extends StatefulWidget {
  const CompponetListArsip({
    super.key,
  });

  @override
  State<CompponetListArsip> createState() => _CompponetListArsipState();
}

class _CompponetListArsipState extends State<CompponetListArsip> {
  List<bool> check = [true, false];
  bool non = false;
  GroupButtonController? menu = GroupButtonController(selectedIndex: 0);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderOrder>(context);
    final providerDis = Provider.of<ProviderDistribusi>(context);

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              width: double.maxFinite,
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
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: (provider.produkTrash!.data!.isEmpty)
                  ? const Center(
                      child: Text('Belum Terdapat Produk Trash'),
                    )
                  : ListView.builder(
                      itemCount: provider.produkTrash!.data!.length,
                      itemBuilder: (context, index) {
                        final data = provider.produkTrash?.data![index];
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
                                    // Bagian hijau (OK)

                                    // Bagian biru (No. 12345)
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
                                            (data?.type == 1) ? "Gas" : "Jasa",
                                            style: titleText),
                                      ),
                                    ),
                                    // Bagian kanan (TW: 36.8)
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        width: width * 0.35,
                                        padding: EdgeInsets.only(right: 10.w),
                                        child: FittedBox(
                                          alignment: Alignment.centerRight,
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                              "Dibuat Oleh : ${data!.createdBy}",
                                              style: minisubtitleTextGrey),
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
                                      horizontal: 10.w, vertical: 5.h),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                          color: Colors.grey.shade300),
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
                                                BorderRadius.circular(12)),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
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
                                                        'Nama Produk',
                                                        style:
                                                            subtitleTextNormalblack,
                                                      ),
                                                    ),
                                                  ),
                                                  const Text(':'),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                        '\t${data.name}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            subtitleTextNormalblack),
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
                                                        'Grade',
                                                        style:
                                                            subtitleTextNormalblack,
                                                      ),
                                                    ),
                                                  ),
                                                  const Text(':'),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                        '\t${(data.isGrade == true) ? providerDis.getGrade(data.tubeGradeId!) : "-"}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            subtitleTextNormalblack),
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
                                                        'Catatan',
                                                        style:
                                                            subtitleTextNormalblack,
                                                      ),
                                                    ),
                                                  ),
                                                  const Text(':'),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                        '\t${(data.note == "") ? "-" : data.note}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            subtitleTextNormalblack),
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
                                                        'Harga',
                                                        style:
                                                            subtitleTextNormalblack,
                                                      ),
                                                    ),
                                                  ),
                                                  const Text(':'),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                        '\t${provider.formatCurrency(data.price as num)}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            subtitleTextNormalblack),
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
                                                        'Dibuat Pada',
                                                        style:
                                                            subtitleTextNormalGrey,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    ':',
                                                    style:
                                                        subtitleTextNormalGrey,
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                        '\t${provider.formatDate(data.createdAt.toString())} | ${provider.formatTime(data.createdAt.toString())}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            subtitleTextNormalGrey),
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
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 10.w, right: 10.w, bottom: 5.h),
                                  child: WidgetButtonCustom(
                                    FullWidth: width,
                                    FullHeight: 40.h,
                                    title: "Lihat Produk",
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
      ),
    );
  }
}
