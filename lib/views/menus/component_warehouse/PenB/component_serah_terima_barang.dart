import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:group_button/group_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../providers/provider_auth.dart';
import '../../../../providers/provider_item.dart';
import '../../../../widgets/widget_button_custom.dart';

class ComponentSerahTerimaBarang extends StatefulWidget {
  ComponentSerahTerimaBarang({
    super.key,
  });

  @override
  State<ComponentSerahTerimaBarang> createState() =>
      _ComponentSerahTerimaBarangState();
}

class _ComponentSerahTerimaBarangState
    extends State<ComponentSerahTerimaBarang> {
  late TextEditingController pic;
  TextEditingController quantity = TextEditingController();
  TextEditingController catatan = TextEditingController();
  GroupButtonController? operator = GroupButtonController();
  SingleSelectController<String?>? gudang =
      SingleSelectController<String?>(null);

  late int selectWarehouse;
  bool? tfS = false;

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
                leading: Icon(Icons.camera_alt),
                title: Text('Take a Photo'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from Gallery'),
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

  void _resetImageFile() {
    setState(() {
      _imageFile = null;
    });
  }

  @override
  void initState() {
    super.initState();
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final userName = auth.auth!.data.name;
    pic = TextEditingController(text: userName);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderItem>(context);

    final warehouse = provider.warehouse?.data
        .map((data) => {'id': data.id, 'name': data.name})
        .toList();

    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Serah Terima Barang',
        colorBG: Colors.transparent,
        colorTitle: Colors.black,
        center: true,
        back: true,
        route: () {
          Navigator.pop(context);
        },
        colorBack: Colors.black,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: width,
          height: height,
          child: Column(
            children: [
              Container(
                width: width,
                height: height * 0.05,
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Row(
                  children: [
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Qty Pemesanan',
                          style: titleTextBlack,
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.center,
                        child: Text(
                          'Qty Diterima',
                          style: titleTextBlack,
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Qty Result',
                            style: titleTextBlack,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: width,
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          '100 (MoU)',
                          style: subtitleTextBlack,
                        ),
                      ),
                    ),
                    Expanded(
                      child: WidgetForm(
                        typeInput: TextInputType.number,
                        alert: '(MoU)',
                        hint: '(MoU)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          '-/+1 (MoU)',
                          style: subtitleTextBlack,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: width,
                height: height * 0.1,
                child: ListTile(
                  title: Text('Catatan', style: subtitleTextBlack),
                  subtitle: TextField(
                    maxLines: null,
                    expands: true,
                    decoration: InputDecoration(
                        hintText: 'Masukkan catatan di sini...',
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(),
                        hintStyle: subtitleTextNormal),
                    style: subtitleTextBlack,
                    textAlignVertical: TextAlignVertical.top,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              Container(
                width: width,
                height: height * 0.05,
                padding: EdgeInsets.only(right: width * 0.05),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: height * 0.016,
                          horizontal: width * 0.05,
                        ),
                        child: Row(
                          children: [
                            // Custom Checkbox
                            Transform.scale(
                              scale: 1.5,
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: (tfS == true)
                                      ? PRIMARY_COLOR // Warna hijau ketika dipilih
                                      : Colors.grey
                                          .shade200, // Warna abu ketika tidak dipilih
                                ),
                                child: Checkbox(
                                  value: tfS,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      tfS = value;
                                    });
                                  },
                                  autofocus: true,
                                  activeColor:
                                      PRIMARY_COLOR, // Warna ketika dipilih
                                  checkColor: PRIMARY_COLOR, // Warna centang
                                  shape: CircleBorder(),
                                  side: BorderSide(
                                      color:
                                          Colors.grey.shade200), // Bentuk bulat
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.25,
                              child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    'Transfer Stok',
                                    style: titleTextBlack,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.01,
                    ),
                    // Expanded(
                    //   child: WidgetButtonCustom(
                    //       FullWidth: width * 0.3,
                    //       FullHeight: 30,
                    //       title: "Submit",
                    //       onpressed: () {},
                    //       bgColor: PRIMARY_COLOR,
                    //       color: Colors.transparent),
                    // ),
                  ],
                ),
              ),
              (tfS == true)
                  ? Container(
                      width: width,
                      height: height * 0.1,
                      child: ListTile(
                        title: Text('Pilih Gudang', style: subtitleTextBlack),
                        subtitle: CustomDropdown(
                          controller: gudang,
                          decoration: CustomDropdownDecoration(
                              closedBorder:
                                  Border.all(color: Colors.grey.shade400),
                              expandedBorder:
                                  Border.all(color: Colors.grey.shade400)),
                          hintText: 'Gudang',
                          items: warehouse?.map((e) => e['name']).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              final ID = warehouse?.firstWhere(
                                (item) => item['name'] == value,
                              );
                              setState(() {
                                selectWarehouse =
                                    int.parse(ID!['id'].toString());
                              });
                              print("Selected BPTK ID: $selectWarehouse");
                            }
                          },
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
              (tfS == true)
                  ? SizedBox(
                      height: height * 0.01,
                    )
                  : SizedBox.shrink(),
              (tfS == true)
                  ? Container(
                      width: width,
                      height: height * 0.05,
                      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: SizedBox.shrink()),
                          SizedBox(
                            width: width * 0.01,
                          ),
                          Expanded(child: SizedBox.shrink()),
                          SizedBox(
                            width: width * 0.01,
                          ),
                          Expanded(
                            child: WidgetButtonCustom(
                                FullWidth: width * 0.3,
                                FullHeight: 30,
                                title: "Submit",
                                onpressed: () {},
                                bgColor: PRIMARY_COLOR,
                                color: Colors.transparent),
                          ),
                        ],
                      ),
                    )
                  : SizedBox.shrink(),
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap:
                      _showImageSourceDialog, // Panggil fungsi saat button diklik
                  child: Container(
                    width: width,
                    height: height * 0.1,
                    child: ListTile(
                      title: Text('Foto Bukti', style: subtitleTextBlack),
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
                          title: Text('Foto Bukti', style: subtitleTextNormal),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Container(
                width: width,
                height: height * 0.05,
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: SizedBox.shrink()),
                    SizedBox(
                      width: width * 0.01,
                    ),
                    Expanded(child: SizedBox.shrink()),
                    SizedBox(
                      width: width * 0.01,
                    ),
                    Expanded(
                      child: WidgetButtonCustom(
                          FullWidth: width * 0.3,
                          FullHeight: 30,
                          title: "Submit",
                          onpressed: () {},
                          bgColor: PRIMARY_COLOR,
                          color: Colors.transparent),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: Container(
      //   width: width,
      //   height: height * 0.06,
      //   child: Align(
      //     alignment: Alignment.topCenter,
      //     child: WidgetButtonCustom(
      //         FullWidth: width * 0.9,
      //         FullHeight: height * 0.05,
      //         title: 'Submit',
      //         onpressed: () async {},
      //         bgColor: PRIMARY_COLOR,
      //         color: PRIMARY_COLOR),
      //   ),
      // ),
    );
  }
}
