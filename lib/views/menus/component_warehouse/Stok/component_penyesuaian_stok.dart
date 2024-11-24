import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';

import '../../../../providers/provider_auth.dart';
import '../../../../providers/provider_item.dart';
import '../../../../widgets/widget_button_custom.dart';

class ComponentPenyesuaianStok extends StatefulWidget {
  ComponentPenyesuaianStok({super.key, required this.itemId});
  int itemId;

  @override
  State<ComponentPenyesuaianStok> createState() =>
      _ComponentPenyesuaianStokState();
}

class _ComponentPenyesuaianStokState extends State<ComponentPenyesuaianStok> {
  late TextEditingController pic;
  TextEditingController quantity = TextEditingController();
  TextEditingController keterangan = TextEditingController();
  GroupButtonController? operator = GroupButtonController();
  SingleSelectController<String?>? gudang =
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
    final auth = Provider.of<ProviderAuth>(context);
    final provider = Provider.of<ProviderItem>(context);
    final userId = auth.auth!.data.id;

    final warehouse = provider.warehouse?.data
        .map((data) => {'id': data.id, 'name': data.name})
        .toList();

    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Penyesuaian Stok',
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
                    'Jenis Penyesuaian*',
                    style: subtitleTextBlack,
                  ),
                  subtitle: Align(
                    alignment: Alignment.topLeft,
                    child: GroupButton(
                        isRadio: true,
                        options: GroupButtonOptions(
                          selectedColor: PRIMARY_COLOR,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        controller: operator,
                        onSelected: (value, index, isSelected) {
                          print('DATA KLIK : $value - $index - $isSelected');
                        },
                        buttons: ['Penambahan', "Pengurangan"]),
                  ),
                ),
              ),
              Container(
                width: width,
                height: height * 0.1,
                child: ListTile(
                  title: Text(
                    'Nilai Penyesuaian',
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: WidgetForm(
                      alert: 'Tidak Boleh Kosong',
                      hint: 'contoh : 100',
                      typeInput: TextInputType.number,
                      controller: quantity,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              Container(
                width: width,
                height: height * 0.1,
                child: ListTile(
                  title: Text(
                    'Gudang',
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle: CustomDropdown(
                    controller: gudang,
                    decoration: CustomDropdownDecoration(
                        closedBorder: Border.all(color: Colors.grey.shade400),
                        expandedBorder:
                            Border.all(color: Colors.grey.shade400)),
                    hintText: 'Pilih Gudang',
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
              SizedBox(height: height * 0.02),
              Container(
                width: width,
                height: height * 0.1,
                child: ListTile(
                  title: Text(
                    'Keterangan',
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: WidgetForm(
                      alert: 'Keterangan tidak boleh kosong',
                      hint: 'Keterangan ',
                      controller: keterangan,
                      typeInput: TextInputType.text,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
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
              onpressed: () async {
                String operatorSymbol;
                if (operator?.selectedIndex == 0) {
                  operatorSymbol = '+';
                } else {
                  operatorSymbol = '-';
                }
                await provider.createPenyesuaian(
                    context,
                    widget.itemId,
                    operatorSymbol,
                    int.parse(quantity.text),
                    keterangan.text,
                    userId,
                    selectWarehouse);
              },
              bgColor: PRIMARY_COLOR,
              color: PRIMARY_COLOR),
        ),
      ),
    );
  }
}
