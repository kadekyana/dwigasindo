import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_item.dart';
import 'package:dwigasindo/providers/provider_sales.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:group_button/group_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../../widgets/widget_form.dart';

class ComponentDetailPo extends StatefulWidget {
  const ComponentDetailPo({super.key});

  @override
  State<ComponentDetailPo> createState() => _ComponentDetailPoState();
}

class _ComponentDetailPoState extends State<ComponentDetailPo> {
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  int warehouseId = 0;
  int qtyR = 0;
  TextEditingController note = TextEditingController();
  TextEditingController qtyD = TextEditingController();

  Future<void> _pickImage(ImageSource source, StateSetter setState) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _showImageSourceDialog(StateSetter setState) {
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
                  _pickImage(ImageSource.camera, setState);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery, setState);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _resetImageFile(StateSetter setState) {
    setState(() {
      _imageFile = null;
    });
  }

// dialog return
  void showReturn(
      BuildContext context, double width, double height, Function onpressed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: SizedBox(
                width: width * 5,
                child: Center(
                  child: Text('Return Barang', style: titleTextBlack),
                ),
              ),
              content: SizedBox(
                width: width,
                height: 300.h,
                child: Column(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Qty',
                          style: titleTextBlack,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: WidgetForm(
                        typeInput: TextInputType.number,
                        alert: '(MoU)',
                        hint: '(MoU)',
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Foto Bukti',
                          style: titleTextBlack,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _showImageSourceDialog(
                          setState), // Panggil fungsi saat button diklik
                      child: Container(
                        width: 250.w,
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
                    SizedBox(
                      height: height * 0.1,
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Keterangan',
                          style: titleTextBlack,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: TextField(
                        maxLines: null,
                        expands: true,
                        decoration: const InputDecoration(
                          hintText: 'Masukkan keterangan di sini...',
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(),
                        ),
                        style: subtitleTextBlack,
                        textAlignVertical: TextAlignVertical.top,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    WidgetButtonCustom(
                      FullWidth: width,
                      FullHeight: height,
                      title: 'Kembali',
                      onpressed: () {
                        Navigator.pop(context);
                        _resetImageFile(setState);
                      },
                      bgColor: PRIMARY_COLOR,
                      color: PRIMARY_COLOR,
                    ),
                    WidgetButtonCustom(
                      FullWidth: width,
                      FullHeight: height,
                      title: 'Selesai',
                      onpressed: () {
                        onpressed();
                        Navigator.pop(context);
                        _resetImageFile(setState);
                      },
                      bgColor: PRIMARY_COLOR,
                      color: PRIMARY_COLOR,
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  void showCompletionDialog(BuildContext context, double width, double height,
      Function onpressed, int qty, int poId, int itemId, String noPO) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: SizedBox(
                width: width * 5,
                child: Center(
                  child: Text('Terima Barang', style: titleTextBlack),
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: FittedBox(
                            child: Text('Qty Pemesanan', style: titleTextBlack),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: FittedBox(
                            alignment: Alignment.center,
                            child: Text('Qty Diterima', style: titleTextBlack),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text('Qty Result', style: titleTextBlack),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.2),
                      child: Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                '$qty (MoU)',
                                style: subtitleTextBlack,
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: qtyD,
                              onChanged: (value) {
                                setState(() {
                                  // Convert entered value to integer and sum with qty
                                  int enteredValue = int.tryParse(value) ?? 0;
                                  qtyR = qty + enteredValue; // Update qtyR
                                });
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: '(MoU)',
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                '$qtyR (MoU)',
                                style: subtitleTextBlack,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.2),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Foto Bukti',
                          style: subtitleTextBlack,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _showImageSourceDialog(
                          setState), // Panggil fungsi saat button diklik
                      child: Container(
                        width: 250.w,
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
                    SizedBox(
                      height: 10.h,
                    ),
                    Consumer<ProviderItem>(
                      builder: (context, provider, child) {
                        final item = provider.warehouse?.data
                            .map((data) => {'id': data.id, 'name': data.name})
                            .toList();
                        print(item);
                        return Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.045),
                          child: CustomDropdown(
                            decoration: CustomDropdownDecoration(
                                closedBorder:
                                    Border.all(color: Colors.grey.shade400),
                                expandedBorder:
                                    Border.all(color: Colors.grey.shade400)),
                            hintText: 'Pilih Gudang',
                            items: item?.map((e) => e['name']).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                final ID = item!.firstWhere(
                                    (item) => item['name'] == value);
                                setState(() {
                                  warehouseId = int.parse(ID['id'].toString());
                                });
                              } else {
                                print(value);
                              }
                            },
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.2),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Keterangan',
                          style: subtitleTextBlack,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: TextField(
                        maxLines: null,
                        expands: true,
                        controller: note,
                        decoration: const InputDecoration(
                          hintText: 'Masukkan keterangan di sini...',
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(),
                        ),
                        style: subtitleTextBlack,
                        textAlignVertical: TextAlignVertical.top,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    WidgetButtonCustom(
                      FullWidth: width,
                      FullHeight: height,
                      title: 'Kembali',
                      onpressed: () {
                        Navigator.pop(context);
                        _resetImageFile(setState);
                      },
                      bgColor: PRIMARY_COLOR,
                      color: PRIMARY_COLOR,
                    ),
                    WidgetButtonCustom(
                      FullWidth: width,
                      FullHeight: height,
                      title: 'Selesai',
                      onpressed: () {
                        onpressed();
                        Provider.of<ProviderItem>(context, listen: false)
                            .createTerimaBarang(
                                context,
                                poId,
                                itemId,
                                int.parse(qtyD.text),
                                warehouseId,
                                note.text,
                                noPO);
                        _resetImageFile(setState);
                      },
                      bgColor: PRIMARY_COLOR,
                      color: PRIMARY_COLOR,
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

// dialog return
  void showCancel(BuildContext context, double width, double height,
      Function onpressed, int idPo, int itemId, String noPo, String uuid) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: SizedBox(
                width: width * 5,
                child: Center(
                  child: Text('Pembatalan Barang', style: titleTextBlack),
                ),
              ),
              content: SizedBox(
                width: width,
                height: height * 2.5,
                child: Column(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Keterangan',
                            style: titleTextBlack,
                          )),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        maxLines: null,
                        expands: true,
                        controller: note,
                        decoration: const InputDecoration(
                          hintText: 'Masukkan keterangan di sini...',
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(),
                        ),
                        style: subtitleTextBlack,
                        textAlignVertical: TextAlignVertical.top,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    WidgetButtonCustom(
                      FullWidth: width,
                      FullHeight: height,
                      title: 'Kembali',
                      onpressed: () {
                        Navigator.pop(context);
                        _resetImageFile(setState);
                      },
                      bgColor: PRIMARY_COLOR,
                      color: PRIMARY_COLOR,
                    ),
                    WidgetButtonCustom(
                      FullWidth: width,
                      FullHeight: height,
                      title: 'Selesai',
                      onpressed: () {
                        onpressed();
                        Provider.of<ProviderItem>(context, listen: false)
                            .updateTerimaBarang(
                                context, idPo, itemId, note.text, uuid, noPo);
                        _resetImageFile(setState);
                      },
                      bgColor: PRIMARY_COLOR,
                      color: PRIMARY_COLOR,
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderItem>(context);
    final providerSales = Provider.of<ProviderSales>(context);
    final data = provider.detailPurchase?.data;
    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Detail Purchase Order',
        center: true,
        colorTitle: Colors.black,
        colorBack: Colors.black,
        colorBG: Colors.grey.shade100,
        back: true,
        route: () {
          Navigator.pop(context);
        },
      ),
      body: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              width: double.maxFinite,
              height: height * 0.15,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Kode PO',
                                style: subtitleTextBlack,
                              ),
                            ),
                          ),
                        ),
                        Text(":"),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                data?.no ?? "-",
                                style: subtitleTextBlack,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Tanggal',
                                style: subtitleTextBlack,
                              ),
                            ),
                          ),
                        ),
                        Text(":"),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                providerSales
                                    .formatDate(data!.poDate.toString()),
                                style: subtitleTextBlack,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Nama Vendor',
                                style: subtitleTextBlack,
                              ),
                            ),
                          ),
                        ),
                        Text(":"),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: Text(
                              data.vendorName ?? "-",
                              overflow: TextOverflow.ellipsis,
                              style: subtitleTextBlack,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'No. Telp',
                                style: subtitleTextBlack,
                              ),
                            ),
                          ),
                        ),
                        Text(":"),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '-',
                                style: subtitleTextBlack,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Kategori',
                                style: subtitleTextBlack,
                              ),
                            ),
                          ),
                        ),
                        Text(":"),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '-',
                                style: subtitleTextBlack,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'No.SPB',
                                style: subtitleTextBlack,
                              ),
                            ),
                          ),
                        ),
                        Text(":"),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                data.spbNo ?? "-",
                                style: subtitleTextBlack,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Align(
              alignment: Alignment.centerLeft,
              child: GroupButton(
                  isRadio: true,
                  controller: GroupButtonController(selectedIndex: 0),
                  options: GroupButtonOptions(
                    selectedColor: PRIMARY_COLOR,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onSelected: (value, index, isSelected) {
                    print('DATA KLIK : $value - $index - $isSelected');
                  },
                  buttons: const ['List Item']),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Expanded(
              child: (data.poDetail?.length == 0)
                  ? const Center(
                      child: Text('Belum Terdapat Data'),
                    )
                  : ListView.builder(
                      itemCount: data.poDetail?.length,
                      itemBuilder: (context, index) {
                        final dataCard = data.poDetail![index];
                        return Container(
                          width: double.maxFinite,
                          height: 180.h,
                          padding: EdgeInsets.all(height * 0.01),
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
                                  child: Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: height * 0.01),
                                          height: 20,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/images/approve4.svg',
                                                      height: 20,
                                                      width: 20,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    SvgPicture.asset(
                                                      'assets/images/approve3.svg',
                                                      height: 20,
                                                      width: 20,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Expanded(
                                                  child: SizedBox.shrink()),
                                              const Expanded(
                                                  child: SizedBox.shrink()),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: FittedBox(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  fit: BoxFit.scaleDown,
                                                  child: Text(
                                                    'Nama Item',
                                                    style: subtitleTextBlack,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: FittedBox(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  fit: BoxFit.scaleDown,
                                                  child: Text(
                                                      ': ${dataCard.itemName ?? "-"}',
                                                      style: subtitleTextBlack),
                                                ),
                                              ),
                                            ),
                                            const Expanded(
                                                child: SizedBox.shrink()),
                                          ],
                                        )),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      'Qty',
                                                      style: subtitleTextBlack,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                        ': ${dataCard.itemQty ?? "-"}',
                                                        style:
                                                            subtitleTextBlack),
                                                  ),
                                                ),
                                              ),
                                              const Expanded(
                                                  child: SizedBox.shrink()),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Keterangan',
                                                  style: titleTextBlack,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  maxLines:
                                      null, // Membuat text field untuk teks panjang
                                  readOnly: true,
                                  expands:
                                      true, // Memperluas TextField agar sesuai dengan ukuran Container
                                  controller: TextEditingController(
                                      text: dataCard.itemNote),
                                  decoration: const InputDecoration(
                                    hintText: 'Masukkan keterangan di sini...',
                                    contentPadding: EdgeInsets.all(10),
                                    border: OutlineInputBorder(),
                                  ),
                                  style: subtitleTextBlack,
                                  textAlignVertical: TextAlignVertical.top,
                                ),
                              ),
                              // Expanded(
                              //   child: Row(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       Expanded(
                              //         child: WidgetButtonCustom(
                              //             FullWidth: width * 0.3,
                              //             FullHeight: 30,
                              //             title: "Batal",
                              //             onpressed: () {
                              //               showCancel(
                              //                   context,
                              //                   width * 0.3,
                              //                   height * 0.05,
                              //                   () {},
                              //                   data.id!,
                              //                   dataCard.itemId!,
                              //                   data.poNo!,
                              //                   data.idStr!);
                              //             },
                              //             bgColor: PRIMARY_COLOR,
                              //             color: Colors.transparent),
                              //       ),
                              //       SizedBox(
                              //         width: width * 0.01,
                              //       ),
                              //       Expanded(
                              //         child: WidgetButtonCustom(
                              //             FullWidth: width * 0.3,
                              //             FullHeight: 30,
                              //             title: "Return",
                              //             onpressed: () {
                              //               showReturn(context, width * 0.3,
                              //                   height * 0.05, () {});
                              //             },
                              //             bgColor: PRIMARY_COLOR,
                              //             color: Colors.transparent),
                              //       ),
                              //       SizedBox(
                              //         width: width * 0.01,
                              //       ),
                              //       Expanded(
                              //         child: WidgetButtonCustom(
                              //             FullWidth: width * 0.3,
                              //             FullHeight: 30,
                              //             title: "Terima",
                              //             onpressed: () {
                              //               showCompletionDialog(
                              //                   context,
                              //                   width * 0.3,
                              //                   height * 0.05,
                              //                   () {},
                              //                   dataCard.qty!,
                              //                   data.id!,
                              //                   dataCard.itemId!,
                              //                   data.poNo!);
                              //             },
                              //             bgColor: PRIMARY_COLOR,
                              //             color: Colors.transparent),
                              //       ),
                              //     ],
                              //   ),
                              // ),
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
