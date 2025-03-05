import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dwigasindo/const/const_api.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/model/modelDetailSPB.dart';
import 'package:dwigasindo/providers/provider_auth.dart';
import 'package:dwigasindo/providers/provider_item.dart';
import 'package:dwigasindo/providers/provider_sales.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ComponentTambahPo extends StatefulWidget {
  const ComponentTambahPo({super.key});
  @override
  State<ComponentTambahPo> createState() => _ComponentTambahPoState();
}

class _ComponentTambahPoState extends State<ComponentTambahPo> {
  int selectPicId = 0;
  int selectPicId1 = 0;
  int selectPicId2 = 0;
  int? kategoriId;
  int? vendorId;
  double totalPrice = 0;
  double grandTotal = 0;

  TextEditingController tanggal = TextEditingController();
  TextEditingController ppn = TextEditingController();
  TextEditingController deadline = TextEditingController();
  SingleSelectController<Object?>? spb = SingleSelectController(null);
  GroupButtonController jenisSpb = GroupButtonController();
  GroupButtonController syarat = GroupButtonController(selectedIndex: 0);
  bool cek = false;

  ModelDetailSpb? _detailSpb;

  // Fungsi untuk memanggil API detail SPB dan mengisi formList secara otomatis
  Future<void> getDetailSPB(BuildContext context, String noSPB) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response =
        await DioServiceAPI().getRequest(url: "spbs/$noSPB", token: token);

    print(response?.data['error']);
    if (response?.data['error'] == null) {
      final data = ModelDetailSpb.fromJson(response!.data);
      setState(() {
        _detailSpb = data;
        formList = data.data!.spbDetail!.map((detail) {
          return {
            "item_id": detail.itemId,
            "item_name": detail.itemName,
            "item_price": null,
            "item_qty": null,
            "item_note": null,
            "preselected": detail.itemName,
            "isSPB": true, // Dari SPB, harga bisa diubah manual
            "controller": TextEditingController(), // Tambahkan controller baru
          };
        }).toList();
      });
    }
  }

  void _hitungTotalHarga() {
    double total = 0;
    for (var item in formList) {
      if (item['item_price'] != null && item['item_qty'] != null) {
        double harga = double.tryParse(item['item_price'].toString()) ?? 0;
        int qty = int.tryParse(item['item_qty'].toString()) ?? 0;
        total += harga * qty;
      }
    }
    setState(() {
      totalPrice = total;
    });
  }

  Future<void> _selectDate(BuildContext context, int jenis) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      if (jenis == 1) {
        setState(() {
          tanggal.text =
              "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
        });
      } else {
        setState(() {
          deadline.text =
              "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
        });
      }
    }
  }

  void _updateGrandTotal() {
    double total = 0;
    for (var form in formListB) {
      total += double.tryParse(form['total']?.toString() ?? '0') ?? 0;
    }
    setState(() {
      grandTotal = total;
    });
  }

  List<Map<String, dynamic>> formList = []; // List untuk menyimpan data form
  List<Map<String, dynamic>> formListB = []; // List untuk menyimpan data form
  // Fungsi untuk menambah form baru
  // Fungsi untuk menambah form baru (form bebas)
  void _addForm() {
    setState(() {
      formList.add({
        "item_id": null,
        "item_price": null,
        "item_qty": null,
        "item_note": null,
        "preselected": null,
        "isSPB":
            false, // item manual, harga diambil otomatis dan tidak bisa diubah
      });
    });
  }

  // Fungsi untuk menghapus form terakhir
  void _removeForm(int index) {
    setState(() {
      formList.removeAt(index);
    });
  }

  void _addFormB() {
    setState(() {
      formListB.add({"bertahap": null, "%": null, 'total': null});
    });
  }

  // Fungsi untuk menghapus form terakhir
  void _removeFormB(int index) {
    if (formListB.isNotEmpty) {
      setState(() {
        formListB.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<ProviderItem>(context);
    final providerSales = Provider.of<ProviderSales>(context);
    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Tambah PO',
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
            SizedBox(
              width: width,
              height: 80.h,
              child: Center(
                child: ListTile(
                  title: Text(
                    'Tanggal',
                    style: subtitleTextBlack,
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: GestureDetector(
                      onTap: () => _selectDate(context, 1),
                      child: AbsorbPointer(
                        child: TextField(
                          controller: tanggal,
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
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: 80.h,
              child: Center(
                child: ListTile(
                  title: Text(
                    'SPB',
                    style: subtitleTextBlack,
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    child: Consumer<ProviderItem>(
                      builder: (context, provider, child) {
                        final spbList = provider.spb!.data!
                            .map((data) => {'id': data.id, 'name': data.no})
                            .toList();

                        return CustomDropdown(
                          controller: spb,
                          decoration: CustomDropdownDecoration(
                              closedBorder:
                                  Border.all(color: Colors.grey.shade400),
                              expandedBorder:
                                  Border.all(color: Colors.grey.shade400)),
                          hintText: 'Pilih SPB',
                          items: spbList.map((e) => e['name']).toList(),
                          onChanged: (item) {
                            print("Selected SPB: $item");

                            final selected = spbList.firstWhere(
                              (e) => e['name'] == item,
                            );
                            // Misal: gunakan field 'id' sebagai noSPB (atau sesuaikan dengan API)
                            int noSPB = int.parse(selected['id'].toString());

                            // Panggil function getDetailSPB
                            getDetailSPB(context, item.toString());

                            // Bisa juga menyimpan nilai SPB yang dipilih jika dibutuhkan
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
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
                      controller: jenisSpb,
                      isRadio: true,
                      options: GroupButtonOptions(
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                      },
                      buttons: const ['Barang', "Jasa"]),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 80.h,
              child: ListTile(
                title: Text(
                  'Categori',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: Consumer<ProviderItem>(
                    builder: (context, provider, child) {
                      final pic = provider.allcategory!.data
                          .map((data) => {'id': data.id, 'name': data.name})
                          .toList();

                      return CustomDropdown(
                        decoration: CustomDropdownDecoration(
                            closedBorder:
                                Border.all(color: Colors.grey.shade400),
                            expandedBorder:
                                Border.all(color: Colors.grey.shade400)),
                        hintText: 'Pilih Categori',
                        items: pic.map((e) => e['name']).toList(),
                        onChanged: (item) {
                          print("Selected Item: $item");

                          final selected = pic.firstWhere(
                            (e) => e['name'] == item,
                          );

                          setState(() {
                            kategoriId = int.parse(selected['id'].toString());
                          });

                          print("Selected ID: $selectPicId2");
                        },
                      );
                    },
                  ),
                ),
              ),
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

                            print("Selected ID: $selectPicId2");
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: formList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    // Container(
                    //   width: width,
                    //   height: 80.h,
                    //   child: ListTile(
                    //     title: Text(
                    //       'Item Barang',
                    //       style: subtitleTextBlack,
                    //     ),
                    //     subtitle: Consumer<ProviderItem>(
                    //       builder: (context, provider, child) {
                    //         final pic = provider.allItem!.data!
                    //             .map((data) => {
                    //                   'id': data.id,
                    //                   'name': data.name,
                    //                   'price': data.price,
                    //                 })
                    //             .toList();

                    //         return CustomDropdown(
                    //           decoration: CustomDropdownDecoration(
                    //               closedBorder:
                    //                   Border.all(color: Colors.grey.shade400),
                    //               expandedBorder:
                    //                   Border.all(color: Colors.grey.shade400)),
                    //           hintText: 'Pilih Item',
                    //           items: pic.map((e) => e['name']).toList(),
                    //           onChanged: (item) {
                    //             print("Selected Item: $item");

                    //             final selected = pic.firstWhere(
                    //               (e) => e['name'] == item,
                    //             );

                    //             setState(() {
                    //               formList[index]['item_id'] =
                    //                   int.parse(selected['id'].toString());
                    //               formList[index]['item_price'] =
                    //                   selected['price'];
                    //             });

                    //             print("Selected ID: $selectPicId2");
                    //           },
                    //         );
                    //       },
                    //     ),
                    //   ),
                    // ),
                    // Di dalam ListView.builder pada form item:
                    SizedBox(
                      width: width,
                      height: 80.h,
                      child: ListTile(
                        title: Text(
                          'Item Barang',
                          style: subtitleTextBlack,
                        ),
                        subtitle: Consumer<ProviderItem>(
                          builder: (context, provider, child) {
                            final allItems = provider.allItem!.data!
                                .map((data) => {
                                      'id': data.id,
                                      'name': data.name,
                                      'price': data.price,
                                    })
                                .toList();
                            // Ambil preselected jika ada (dari data SPB) atau null
                            String? initialValue =
                                formList[index]["preselected"];
                            return CustomDropdown<String>(
                              initialItem: formList[index]["preselected"],
                              items: allItems
                                  .map((e) => e['name'] as String)
                                  .toList(),
                              hintText: 'Pilih Item',
                              decoration: CustomDropdownDecoration(
                                  closedBorder:
                                      Border.all(color: Colors.grey.shade400),
                                  expandedBorder:
                                      Border.all(color: Colors.grey.shade400)),
                              onChanged: (item) {
                                print("Selected Item: $item");
                                final selected = allItems
                                    .firstWhere((e) => e['name'] == item);
                                setState(() {
                                  formList[index]['item_id'] =
                                      int.parse(selected['id'].toString());
                                  formList[index]['item_price'] =
                                      selected['price'];
                                  // Jika user memilih secara manual, maka set isSPB menjadi false
                                  formList[index]["isSPB"] = false;
                                  // Clear preselected agar dropdown bisa diubah kemudian
                                  formList[index]["preselected"] = null;
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      width: width,
                      height: height * 0.1,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: ListTile(
                              title: Text(
                                'Harga',
                                style: subtitleTextBlack,
                              ),
                              subtitle: Container(
                                margin: EdgeInsets.only(top: height * 0.01),
                                child: WidgetForm(
                                  controller: formList[index]['controller'] ??
                                      TextEditingController(
                                        text: (formList[index]['item_price'] !=
                                                null)
                                            ? providerSales.formatCurrency(
                                                double.tryParse(formList[index]
                                                            ['item_price']
                                                        .toString()) ??
                                                    0)
                                            : "",
                                      ),
                                  change: (value) {
                                    setState(() {
                                      formList[index]['item_price'] = value;
                                    });
                                  },
                                  alert: 'Harga',
                                  hint: 'Harga',
                                  enable: formList[index][
                                      "isSPB"], // Harga bisa diisi jika bukan SPB
                                  typeInput: TextInputType.number,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(
                                'QTY',
                                style: subtitleTextBlack,
                              ),
                              subtitle: Container(
                                margin: EdgeInsets.only(top: height * 0.01),
                                child: WidgetForm(
                                  change: (value) {
                                    setState(() {
                                      formList[index]['item_qty'] = value;
                                      _hitungTotalHarga();
                                    });
                                  },
                                  alert: 'QTY',
                                  hint: 'QTY',
                                  typeInput: TextInputType.number,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      width: width,
                      height: 80.h,
                      child: ListTile(
                        title: Text(
                          'Keterangan',
                          overflow: TextOverflow.ellipsis,
                          style: subtitleTextBlack,
                        ),
                        subtitle: Container(
                          margin: EdgeInsets.only(top: height * 0.01),
                          child: WidgetForm(
                            alert: 'Keterangan',
                            hint: 'Keterangan',
                            typeInput: TextInputType.text,
                            change: (value) {
                              setState(() {
                                formList[index]['item_note'] = value;
                              });
                            },
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      width: width,
                      height: height * 0.06,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: WidgetButtonCustom(
                            FullWidth: width * 0.9,
                            FullHeight: height * 0.05,
                            title: 'Hapus Form',
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
              height: 20.h,
            ),
            SizedBox(
              width: width,
              height: height * 0.06,
              child: Align(
                alignment: Alignment.topCenter,
                child: WidgetButtonCustom(
                    FullWidth: width * 0.9,
                    FullHeight: height * 0.05,
                    title: 'Tambah Form',
                    onpressed: _addForm,
                    bgColor: PRIMARY_COLOR,
                    color: PRIMARY_COLOR),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              width: width,
              height: height * 0.1,
              child: ListTile(
                title: Text(
                  'Syarat Pembayaran',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      controller: syarat,
                      isRadio: true,
                      options: GroupButtonOptions(
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                        if (value == "Bertahap") {
                          setState(() {
                            cek = true;
                          });
                        } else {
                          setState(() {
                            cek = false;
                          });
                        }
                      },
                      buttons: const ['Tunai', "Bertahap"]),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: height * 0.1,
              child: ListTile(
                title: Text(
                  'Deadline Pembayaran',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: GestureDetector(
                    onTap: () => _selectDate(context, 2),
                    child: AbsorbPointer(
                      child: TextField(
                        controller: deadline,
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
            SizedBox(
              height: height * 0.01,
            ),
            if (cek == false)
              SizedBox(
                width: width,
                height: height * 0.1,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: ListTile(
                        title: Text(
                          'Harga Total Item',
                          style: subtitleTextBlack,
                        ),
                        subtitle: Container(
                          margin: EdgeInsets.only(top: height * 0.01),
                          child: WidgetForm(
                            controller: TextEditingController(
                                text: providerSales.formatCurrency(totalPrice)),
                            alert: 'Harga Total Item',
                            hint: 'Harga Total Item',
                            enable: false,
                            typeInput: TextInputType.number,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text(
                          'PPN',
                          style: subtitleTextBlack,
                        ),
                        subtitle: Container(
                          margin: EdgeInsets.only(top: height * 0.01),
                          child: WidgetForm(
                            controller: ppn,
                            change: (value) {
                              setState(() {
                                grandTotal = totalPrice +
                                    totalPrice * int.parse(value) / 100;
                              });
                            },
                            alert: 'PPN',
                            hint: 'PPN',
                            typeInput: TextInputType.number,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(
              height: 10.h,
            ),
            if (cek == true)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: formListB.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SizedBox(
                        width: width,
                        height: 100.h,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: ListTile(
                                title: Text(
                                  'Tahap ${index + 1}',
                                  style: superTitleTextBlack,
                                ),
                                subtitle: Container(
                                  margin: EdgeInsets.only(top: height * 0.01),
                                  child: WidgetForm(
                                    typeInput: TextInputType.number,
                                    alert: 'Tahap ${index + 1}',
                                    hint: 'Tahap ${index + 1}',
                                    change: (value) {
                                      setState(() {
                                        formListB[index]['bertahap'] = value;
                                      });
                                    },
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  '%',
                                  style: subtitleTextBlack,
                                ),
                                subtitle: Container(
                                  margin: EdgeInsets.only(top: height * 0.01),
                                  child: WidgetForm(
                                    typeInput: TextInputType.number,
                                    alert: '%',
                                    hint: '%',
                                    change: (value) {
                                      setState(() {
                                        formListB[index]['%'] = value;

                                        // Ambil total tahap sebelumnya (atau tahap 1 jika index 0)
                                        double previousTotal = index == 0
                                            ? (double.tryParse(formListB[0]
                                                        ['bertahap']
                                                    .toString()) ??
                                                0)
                                            : (double.tryParse(
                                                    formListB[index - 1]
                                                            ['total']
                                                        .toString()) ??
                                                0);

                                        double percentage =
                                            double.tryParse(value) ?? 0;

                                        // Hitung total tahap ini
                                        formListB[index]['total'] =
                                            previousTotal +
                                                (previousTotal *
                                                    percentage /
                                                    100);

                                        _updateGrandTotal();
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
                        width: width,
                        height: 80.h,
                        child: ListTile(
                          title: Text(
                            'Total',
                            style: subtitleTextBlack,
                          ),
                          subtitle: Container(
                            margin: EdgeInsets.only(top: height * 0.01),
                            child: WidgetForm(
                              alert: 'Total',
                              hint: 'Total',
                              change: (value) {
                                setState(() {
                                  formListB[index]['total'] = value;
                                });
                              },
                              controller: TextEditingController(
                                text: providerSales.formatCurrency(
                                    formListB[index]['total'] ?? 0),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Container(
                        width: width,
                        height: 40.h,
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        child: WidgetButtonCustom(
                          FullWidth: width,
                          FullHeight: 40.h,
                          title: "Hapus Form Pembayaran Tahap ${index + 1}",
                          color: SECONDARY_COLOR,
                          bgColor: SECONDARY_COLOR,
                          onpressed: () {
                            _removeFormB(index);
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              width: width,
              height: 40.h,
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: WidgetButtonCustom(
                FullWidth: width,
                FullHeight: 40.h,
                title: "Tambah Form Pembayaran Bertahap",
                color: PRIMARY_COLOR,
                bgColor: PRIMARY_COLOR,
                onpressed: _addFormB,
              ),
            ),
            SizedBox(
              width: width,
              height: 80.h,
              child: ListTile(
                title: Text(
                  'Grand Total',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: WidgetForm(
                    controller: TextEditingController(
                        text: providerSales.formatCurrency(grandTotal)),
                    alert: 'Grand Total',
                    hint: 'Grand Total',
                    enable: false,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
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
                        height: 20.h,
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
                        height: 20.h,
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
            ),
            SizedBox(
              height: height * 0.05,
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
              title: 'Buat PO',
              onpressed: () async {
                if (kategoriId == null || vendorId == null) {
                  showTopSnackBar(
                    Overlay.of(context),
                    const CustomSnackBar.error(
                        message: "Pilih kategori dan vendor terlebih dahulu!"),
                  );
                  return;
                }

                if (formList.isEmpty) {
                  showTopSnackBar(
                    Overlay.of(context),
                    const CustomSnackBar.error(
                        message: "Tambahkan minimal 1 item!"),
                  );
                  return;
                }

                final spbValue = spb?.value?.toString() ?? "";
                double ppnValue = double.tryParse(ppn.text) ?? 0;

                provider.createPO(
                    context,
                    tanggal.text,
                    spbValue,
                    jenisSpb.selectedIndex!,
                    kategoriId!,
                    vendorId!,
                    syarat.selectedIndex!,
                    deadline.text,
                    totalPrice,
                    ppnValue,
                    grandTotal,
                    formList);
              },
              bgColor: PRIMARY_COLOR,
              color: PRIMARY_COLOR),
        ),
      ),
    );
  }
}
