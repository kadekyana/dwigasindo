import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_sales.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  int selectPicId = 0;
  int selectPicId1 = 0;
  int selectPicId2 = 0;
  int selectItemId = 0;

  late TextEditingController pic;
  TextEditingController quantity = TextEditingController();
  TextEditingController catatan = TextEditingController();
  GroupButtonController? operator = GroupButtonController();
  SingleSelectController<String?>? divisi =
      SingleSelectController<String?>(null);

  List<Map<String, dynamic>> formList = []; // List untuk menyimpan data form
  // Fungsi untuk menambah form baru
  void _addForm() {
    setState(() {
      formList.add({"item_id": null, "qty": null, "note": null});
    });
  }

  void _removeForm(int index) {
    setState(() {
      formList.removeAt(index);
    });
  }

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
        back: true,
        route: () {
          Navigator.pop(context);
        },
        colorBack: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: width,
              height: height * 0.1,
              child: ListTile(
                title: Text(
                  'Pilih Divisi',
                  style: subtitleTextBlack,
                ),
                subtitle: CustomDropdown(
                  controller: divisi,
                  decoration: CustomDropdownDecoration(
                      closedBorder: Border.all(color: Colors.grey.shade400),
                      expandedBorder: Border.all(color: Colors.grey.shade400)),
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
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: formList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ListTile(
                        title: Text(
                          'Pilih Item',
                          style: subtitleTextBlack,
                        ),
                        subtitle: Container(
                          margin: EdgeInsets.only(top: height * 0.01),
                          child: Consumer<ProviderItem>(
                            builder: (context, provider, child) {
                              final produk = provider.allItem!.data!
                                  .map((data) => {
                                        'id': data.id,
                                        'name': data.name,
                                      })
                                  .toList();

                              return CustomDropdown(
                                hintText: 'Pilih Item',
                                items:
                                    produk.map((e) => e['name']).toList() ?? [],
                                onChanged: (item) {
                                  print("Selected Item: $item");

                                  final selected = produk.firstWhere(
                                    (e) => e['name'] == item,
                                  );

                                  setState(() {
                                    selectItemId =
                                        int.parse(selected['id'].toString());
                                    formList[index]['item_id'] = selectItemId;
                                  });

                                  print("Selected ID: $selectItemId");
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width,
                      height: 80.h,
                      child: ListTile(
                        title: Text(
                          'Qty',
                          style: subtitleTextBlack,
                        ),
                        subtitle: Container(
                          margin: EdgeInsets.only(top: height * 0.01),
                          child: WidgetForm(
                            change: (value) {
                              setState(() {
                                formList[index]['qty'] =
                                    int.tryParse(value) ?? 0;
                              });
                            },
                            alert: 'Qty',
                            hint: 'Qty',
                            typeInput: TextInputType.number,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                      width: width,
                      height: 110.h,
                      child: ListTile(
                        title: Text(
                          'Catatan',
                          style: subtitleTextBlack,
                        ),
                        subtitle: Container(
                          margin: EdgeInsets.only(top: height * 0.01),
                          height: 70.h,
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                formList[index]['note'] = value;
                              });
                            },
                            maxLines: null,
                            expands: true,
                            decoration: InputDecoration(
                              hintText: 'Masukkan catatan di sini...',
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
                      height: 20.h,
                    ),
                    SizedBox(
                      width: width,
                      height: height * 0.06,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: WidgetButtonCustom(
                            FullWidth: width * 0.9,
                            FullHeight: 40.h,
                            title: 'Hapus Form Item',
                            onpressed: () {
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
            SizedBox(
              width: width,
              height: height * 0.06,
              child: Align(
                alignment: Alignment.topCenter,
                child: WidgetButtonCustom(
                    FullWidth: width * 0.9,
                    FullHeight: 40.h,
                    title: 'Tambah Form Item',
                    onpressed: _addForm,
                    bgColor: PRIMARY_COLOR,
                    color: PRIMARY_COLOR),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              width: width,
              height: 250.h,
              child: ListTile(
                title: Text(
                  'PIC Approval',
                  style: subtitleTextBlack,
                ),
                subtitle: Column(
                  children: [
                    Consumer<ProviderSales>(
                      builder: (context, provider, child) {
                        final pic = provider.modelUsersPic!.data!
                            .map((data) => {'id': data.id, 'name': data.name})
                            .toList();

                        return CustomDropdown(
                          decoration: CustomDropdownDecoration(
                              closedBorder:
                                  Border.all(color: Colors.grey.shade400),
                              expandedBorder:
                                  Border.all(color: Colors.grey.shade400)),
                          hintText: 'Pilih PIC Verifikasi',
                          items: pic.map((e) => e['name']).toList(),
                          onChanged: (item) {
                            print("Selected Item: $item");

                            final selected = pic.firstWhere(
                              (e) => e['name'] == item,
                            );

                            setState(() {
                              selectPicId =
                                  int.parse(selected['id'].toString());
                            });

                            print("Selected ID: $selectPicId");
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
                            .map((data) => {'id': data.id, 'name': data.name})
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
                            .map((data) => {'id': data.id, 'name': data.name})
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
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: width,
        height: height * 0.06,
        child: Align(
          alignment: Alignment.topCenter,
          child: WidgetButtonCustom(
              FullWidth: width * 0.9,
              FullHeight: height * 0.05,
              title: 'Submit',
              onpressed: () async {
                print(selectWarehouse);
                print(formList);
                print(selectPicId);
                print(selectPicId1);
                print(selectPicId2);
                await provider.createPermintaanBarang(context, selectWarehouse,
                    selectPicId, selectPicId1, selectPicId2, formList);
              },
              bgColor: PRIMARY_COLOR,
              color: PRIMARY_COLOR),
        ),
      ),
    );
  }
}
