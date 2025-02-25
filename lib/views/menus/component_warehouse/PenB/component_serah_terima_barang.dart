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
  const ComponentSerahTerimaBarang({
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
                child: const Row(
                  children: [
                    Expanded(
                      child: FittedBox(
                        child: Text(
                          'Qty Pemesanan',
                          style: titleTextBlack,
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: FittedBox(
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
                        child: Text(
                          'Qty Result',
                          style: titleTextBlack,
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
                    const Expanded(
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
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const Expanded(
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
              SizedBox(
                width: width,
                height: height * 0.1,
                child: ListTile(
                  title: const Text(
                    'Catatan',
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle: Expanded(
                    child: TextField(
                      maxLines: null,
                      expands: true,
                      decoration: InputDecoration(
                          hintText: 'Masukkan catatan di sini...',
                          contentPadding: const EdgeInsets.all(10),
                          border: const OutlineInputBorder(),
                          hintStyle: TextStyle(
                              fontFamily: 'Manrope',
                              color: Colors.grey.shade500)),
                      style: const TextStyle(fontSize: 16),
                      textAlignVertical: TextAlignVertical.top,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              Container(
                width: width,
                height: height * 0.05,
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(child: SizedBox.shrink()),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Expanded(
                      child: WidgetButtonCustom(
                          FullWidth: width * 0.3,
                          FullHeight: 30,
                          title: "Transfer Stok",
                          onpressed: () {},
                          bgColor: PRIMARY_COLOR,
                          color: Colors.transparent),
                    ),
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
              SizedBox(
                width: width,
                height: height * 0.1,
                child: ListTile(
                  title: const Text(
                    'Pilih Gudang',
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle: CustomDropdown(
                    controller: gudang,
                    decoration: CustomDropdownDecoration(
                        closedBorder: Border.all(color: Colors.grey.shade400),
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
                          selectWarehouse = int.parse(ID!['id'].toString());
                        });
                        print("Selected BPTK ID: $selectWarehouse");
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
                height: height * 0.05,
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(child: SizedBox.shrink()),
                    SizedBox(
                      width: width * 0.01,
                    ),
                    const Expanded(child: SizedBox.shrink()),
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
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: _pickImage, // Panggil fungsi saat button diklik
                  child: SizedBox(
                    width: width * 0.55,
                    height: height * 0.1,
                    child: ListTile(
                      title: const Text(
                        'Foto Bukti',
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
                            'Foto Bukti',
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
                    const Expanded(child: SizedBox.shrink()),
                    SizedBox(
                      width: width * 0.01,
                    ),
                    const Expanded(child: SizedBox.shrink()),
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
