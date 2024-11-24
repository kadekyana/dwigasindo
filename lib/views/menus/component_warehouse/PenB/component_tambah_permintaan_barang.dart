import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';

import '../../../../providers/provider_auth.dart';
import '../../../../providers/provider_item.dart';
import '../../../../widgets/widget_button_custom.dart';

class ComponentTambahPermintaanBarang extends StatefulWidget {
  const ComponentTambahPermintaanBarang({
    super.key,
  });

  @override
  State<ComponentTambahPermintaanBarang> createState() =>
      _ComponentTambahPermintaanBarangState();
}

class _ComponentTambahPermintaanBarangState
    extends State<ComponentTambahPermintaanBarang> {
  late TextEditingController pic;
  TextEditingController quantity = TextEditingController();
  TextEditingController catatan = TextEditingController();
  GroupButtonController? operator = GroupButtonController();
  SingleSelectController<String?>? divisi =
      SingleSelectController<String?>(null);

  late int selectWarehouse;

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
        title: 'Tambah Permintaan Barang',
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
                height: height * 0.1,
                child: ListTile(
                  title: Text(
                    'Pilih Divisi',
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle: CustomDropdown(
                    controller: divisi,
                    decoration: CustomDropdownDecoration(
                        closedBorder: Border.all(color: Colors.grey.shade400),
                        expandedBorder:
                            Border.all(color: Colors.grey.shade400)),
                    hintText: 'Nama Divisi',
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
                height: height * 0.1,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: ListTile(
                        title: Text(
                          'Item Barang',
                          style: TextStyle(color: Colors.black),
                        ),
                        subtitle: Container(
                          margin: EdgeInsets.only(top: height * 0.01),
                          child: WidgetForm(
                            alert: 'Tidak Boleh Kosong',
                            hint: 'nama',
                            typeInput: TextInputType.number,
                            controller: quantity,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text(
                          'Qty',
                          style: TextStyle(color: Colors.black),
                        ),
                        subtitle: Container(
                          margin: EdgeInsets.only(top: height * 0.01),
                          child: WidgetForm(
                            alert: 'Tidak Boleh Kosong',
                            hint: 'qty',
                            typeInput: TextInputType.number,
                            controller: quantity,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: SizedBox.shrink()),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                width: width,
                height: height * 0.1,
                child: ListTile(
                  title: Text(
                    'Stock Tersedia',
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: WidgetForm(
                      alert: 'Tidak Boleh Kosong',
                      hint: '1000 (MoU)',
                      typeInput: TextInputType.number,
                      controller: quantity,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                width: width,
                height: height * 0.1,
                child: ListTile(
                  title: Text(
                    'Catatan',
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle: Expanded(
                    child: TextField(
                      maxLines: null,
                      expands: true,
                      decoration: InputDecoration(
                          hintText: 'Masukkan catatan di sini...',
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(),
                          hintStyle: TextStyle(
                              fontFamily: 'Manrope',
                              color: Colors.grey.shade500)),
                      style: TextStyle(fontSize: 16),
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
                height: height * 0.25,
                child: ListTile(
                  title: Text(
                    'PIC Approval',
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: height * 0.01),
                        child: CustomDropdown(
                          decoration: CustomDropdownDecoration(
                              closedBorder:
                                  Border.all(color: Colors.grey.shade400),
                              expandedBorder:
                                  Border.all(color: Colors.grey.shade400)),
                          hintText: 'Pilih PIC Verifikasi',
                          items: ['a'],
                          onChanged: (value) {},
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: height * 0.01),
                        child: CustomDropdown(
                          decoration: CustomDropdownDecoration(
                              closedBorder:
                                  Border.all(color: Colors.grey.shade400),
                              expandedBorder:
                                  Border.all(color: Colors.grey.shade400)),
                          hintText: 'Pilih PIC Mengetahui',
                          items: ['a'],
                          onChanged: (value) {},
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: height * 0.01),
                        child: CustomDropdown(
                          decoration: CustomDropdownDecoration(
                              closedBorder:
                                  Border.all(color: Colors.grey.shade400),
                              expandedBorder:
                                  Border.all(color: Colors.grey.shade400)),
                          hintText: 'Pilih PIC Menyetujui',
                          items: ['a'],
                          onChanged: (value) {},
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
      bottomNavigationBar: Container(
        width: width,
        height: height * 0.06,
        child: Align(
          alignment: Alignment.topCenter,
          child: WidgetButtonCustom(
              FullWidth: width * 0.9,
              FullHeight: height * 0.05,
              title: 'Submit',
              onpressed: () async {},
              bgColor: PRIMARY_COLOR,
              color: PRIMARY_COLOR),
        ),
      ),
    );
  }
}
