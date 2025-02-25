import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_item.dart';
import 'package:dwigasindo/providers/provider_sales.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ComponentTambahSpb extends StatefulWidget {
  const ComponentTambahSpb({super.key});
  @override
  State<ComponentTambahSpb> createState() => _ComponentTambahSpbState();
}

class _ComponentTambahSpbState extends State<ComponentTambahSpb> {
  TextEditingController serial = TextEditingController();
  GroupButtonController jenis = GroupButtonController();
  int selectPicId = 0;
  int selectPicId1 = 0;
  int selectPicId2 = 0;

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        serial.text =
            "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      });
    }
  }

  List<Map<String, dynamic>> formList = []; // List untuk menyimpan data form
  // Fungsi untuk menambah form baru
  void _addForm() {
    setState(() {
      formList.add({
        "item_id": null,
        "qty": null,
        "specification": null,
      });
    });
  }

  // Fungsi untuk menghapus form terakhir
  void _removeForm(int index) {
    print(index);
    if (formList.isNotEmpty) {
      setState(() {
        formList.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<ProviderItem>(context);
    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Tambah SPB',
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: width,
                height: height * 0.1,
                child: ListTile(
                  title: Text(
                    'Tanggal',
                    style: subtitleTextBlack,
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: TextField(
                          controller: serial,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                            hintText: 'Pilih Tanggal',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
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
                    'Jenis SPB',
                    style: subtitleTextBlack,
                  ),
                  subtitle: Align(
                    alignment: Alignment.topLeft,
                    child: GroupButton(
                        isRadio: true,
                        controller: jenis,
                        options: GroupButtonOptions(
                          selectedColor: PRIMARY_COLOR,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        onSelected: (value, index, isSelected) {
                          print('DATA KLIK : $value - $index - $isSelected');
                        },
                        buttons: ['Barang', "Jasa"]),
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: formList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
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
                                  style: subtitleTextBlack,
                                ),
                                subtitle: Container(
                                  margin: EdgeInsets.only(top: 10.h),
                                  child: Consumer<ProviderItem>(
                                    builder: (context, provider, child) {
                                      final pic = provider.allItem!.data!
                                          .map((data) => {
                                                'id': data.id,
                                                'name': data.name,
                                                'price': data.price,
                                              })
                                          .toList();

                                      return CustomDropdown(
                                        decoration: CustomDropdownDecoration(
                                            closedBorder: Border.all(
                                                color: Colors.grey.shade400),
                                            expandedBorder: Border.all(
                                                color: Colors.grey.shade400)),
                                        hintText: 'Pilih Item',
                                        items:
                                            pic.map((e) => e['name']).toList(),
                                        onChanged: (item) {
                                          print("Selected Item: $item");

                                          final selected = pic.firstWhere(
                                            (e) => e['name'] == item,
                                          );

                                          setState(() {
                                            formList[index]['item_id'] =
                                                int.parse(
                                                    selected['id'].toString());
                                          });

                                          print("Selected ID: $selectPicId2");
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  'Qty',
                                  style: subtitleTextBlack,
                                ),
                                subtitle: Container(
                                  margin: EdgeInsets.only(top: 10.h),
                                  child: WidgetForm(
                                    alert: 'Qty',
                                    hint: 'Qty',
                                    change: (value) {
                                      setState(() {
                                        formList[index]['qty'] = value;
                                      });
                                    },
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15.h),
                        child: WidgetForm(
                          alert: 'Isi Spesifikasi',
                          hint: 'Isi Spesifikasi',
                          change: (value) {
                            setState(() {
                              formList[index]['specification'] = value;
                            });
                          },
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Container(
                        width: width,
                        height: height * 0.06,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: WidgetButtonCustom(
                              FullWidth: width * 0.9,
                              FullHeight: height * 0.05,
                              title: 'Hapus Form',
                              onpressed: () async {
                                _removeForm(index);
                              },
                              bgColor: SECONDARY_COLOR,
                              color: SECONDARY_COLOR),
                        ),
                      ),
                    ],
                  );
                },
              ),
              Container(
                width: width,
                height: height * 0.06,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: WidgetButtonCustom(
                      FullWidth: width * 0.9,
                      FullHeight: height * 0.05,
                      title: 'Tambah Form',
                      onpressed: () async {
                        _addForm();
                      },
                      bgColor: PRIMARY_COLOR,
                      color: PRIMARY_COLOR),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: width,
                  height: 250.h,
                  child: ListTile(
                    title: Text(
                      'PIC Approval',
                      style: subtitleTextBlack,
                    ),
                    subtitle: Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Consumer<ProviderSales>(
                          builder: (context, provider, child) {
                            final pic = provider.modelUsersPic!.data!
                                .map((data) =>
                                    {'id': data.id, 'name': data.name})
                                .toList();

                            return CustomDropdown(
                              decoration: CustomDropdownDecoration(
                                  closedBorder:
                                      Border.all(color: Colors.grey.shade400),
                                  expandedBorder:
                                      Border.all(color: Colors.grey.shade400)),
                              hintText: 'Pilih PIC Mengetahui',
                              items: pic.map((e) => e['name']).toList(),
                              onChanged: (item) {
                                print("Selected Item: $item");

                                final selected = pic.firstWhere(
                                  (e) => e['name'] == item,
                                );

                                setState(() {
                                  selectPicId1 =
                                      int.parse(selected['id'].toString());
                                });

                                print("Selected ID: $selectPicId1");
                              },
                            );
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Consumer<ProviderSales>(
                          builder: (context, provider, child) {
                            final pic = provider.modelUsersPic!.data!
                                .map((data) =>
                                    {'id': data.id, 'name': data.name})
                                .toList();

                            return CustomDropdown(
                              decoration: CustomDropdownDecoration(
                                  closedBorder:
                                      Border.all(color: Colors.grey.shade400),
                                  expandedBorder:
                                      Border.all(color: Colors.grey.shade400)),
                              hintText: 'Pilih PIC Menyetujui',
                              items: pic.map((e) => e['name']).toList(),
                              onChanged: (item) {
                                print("Selected Item: $item");

                                final selected = pic.firstWhere(
                                  (e) => e['name'] == item,
                                );

                                setState(() {
                                  selectPicId2 =
                                      int.parse(selected['id'].toString());
                                });

                                print("Selected ID: $selectPicId2");
                              },
                            );
                          },
                        ),
                      ],
                    ),
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
              title: 'Simpan',
              onpressed: () async {
                print(serial.text);
                print(jenis.selectedIndex);
                print(formList);
                await provider.createSPB(
                    context, serial.text, jenis.selectedIndex!, formList);
              },
              bgColor: PRIMARY_COLOR,
              color: PRIMARY_COLOR),
        ),
      ),
    );
  }
}
