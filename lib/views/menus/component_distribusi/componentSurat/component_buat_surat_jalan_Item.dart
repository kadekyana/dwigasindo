import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/providers/provider_item.dart';
import 'package:dwigasindo/providers/provider_order.dart';
import 'package:dwigasindo/providers/provider_sales.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:dwigasindo/widgets/wigdet_kecamatan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';

class ComponentBuatSuratJalanItem extends StatefulWidget {
  const ComponentBuatSuratJalanItem({
    super.key,
  });
  @override
  State<ComponentBuatSuratJalanItem> createState() =>
      _ComponentBuatSuratJalanItemState();
}

class _ComponentBuatSuratJalanItemState
    extends State<ComponentBuatSuratJalanItem> {
  TextEditingController serial = TextEditingController();
  GroupButtonController? button = GroupButtonController(selectedIndex: 0);
  GroupButtonController? buat = GroupButtonController(selectedIndex: 0);

  SingleSelectController<String?> driver =
      SingleSelectController<String?>(null);
  TextEditingController noKendaraan = TextEditingController();
  TextEditingController nama = TextEditingController();
  GroupButtonController? type = GroupButtonController();
  int typeJ = 0;

  bool cek = false;
  int jenis = 0;
  int cari = 0;
  int? selectProdukId;
  int? selectItemId;

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
            "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
      });
    }
  }

  List<Map<String, dynamic>> formListB = []; // List untuk menyimpan data form
  List<Map<String, dynamic>> formList = []; // List untuk menyimpan data form
  // Fungsi untuk menambah form baru
  void _addForm() {
    setState(() {
      formList.add({
        "id": null,
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
      formListB
          .add({"item_id": null, "order_id": null, "qty": null, "note": null});
    });
  }

  // Fungsi untuk menghapus form terakhir
  void _removeFormB(int index) {
    setState(() {
      formListB.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<ProviderDistribusi>(context);
    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Buat Order',
        center: true,
        colorTitle: Colors.black,
        colorBack: Colors.black,
        colorBG: Colors.grey.shade100,
        back: true,
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
              height: height * 0.1,
              child: ListTile(
                title: Text(
                  'Type',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      controller: type,
                      isRadio: true,
                      options: GroupButtonOptions(
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                        setState(() {
                          typeJ = index;
                        });
                      },
                      buttons: const ['User', "Non User"]),
                ),
              ),
            ),
            if (typeJ == 0)
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: width,
                  child: ListTile(
                    title: Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      child: Text(
                        'Pilih Driver',
                        style: subtitleTextBlack,
                      ),
                    ),
                    subtitle: Consumer<ProviderSales>(
                      builder: (context, provider, child) {
                        final pic = provider.modelUsersPic!.data!
                            .map((data) => {'id': data.id, 'name': data.name})
                            .toList();

                        return CustomDropdown(
                          controller: driver,
                          decoration: CustomDropdownDecoration(
                              closedBorder:
                                  Border.all(color: Colors.grey.shade400),
                              expandedBorder:
                                  Border.all(color: Colors.grey.shade400)),
                          hintText: 'Pilih Driver',
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
                  ),
                ),
              ),
            if (typeJ == 1)
              SizedBox(
                width: width,
                height: height * 0.12,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ListTile(
                    title: Text(
                      'Nama',
                      style: subtitleTextBlack,
                    ),
                    subtitle: Container(
                      margin: EdgeInsets.only(top: height * 0.01),
                      child: WidgetForm(
                        alert: 'Nama',
                        hint: 'Nama',
                        controller: nama,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ),
              ),
            SizedBox(
              height: height * 0.02,
            ),
            SizedBox(
              width: width,
              height: height * 0.1,
              child: ListTile(
                title: Text(
                  'Nomor Kendaraan',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: WidgetForm(
                    alert: 'L 1234 TR',
                    hint: 'L 1234 TR',
                    controller: noKendaraan,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            // Gas
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: formList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.only(left: 16.w, right: 10.w, top: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Order Select ${index + 1}',
                              style: titleTextBlack,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: IconButton(
                              onPressed: () => _removeForm(index),
                              icon: const Icon(Icons.delete),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ListTile(
                        title: Text(
                          'Pilih Order',
                          style: subtitleTextBlack,
                        ),
                        subtitle: Container(
                          margin: EdgeInsets.only(top: height * 0.01),
                          child: Consumer<ProviderItem>(
                            builder: (context, provider, child) {
                              final produk = provider.order!.data!
                                  .map((data) =>
                                      {'id': data.id, 'name': data.code})
                                  .toList();

                              return CustomAutocomplete(
                                data:
                                    produk.map((e) => e['name']).toList() ?? [],
                                displayString: (item) => item.toString(),
                                onSelected: (item) {
                                  print("Selected Item: $item");

                                  final selected = produk.firstWhere(
                                    (e) => e['name'] == item,
                                  );

                                  setState(() {
                                    selectProdukId =
                                        int.parse(selected!['id'].toString());
                                  });

                                  setState(() {
                                    formList[index]['id'] = selectProdukId;
                                  });

                                  print("Selected ID: $selectProdukId");
                                },
                                labelText: 'Cari Barang',
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              width: width,
              height: height * 0.06,
              child: Align(
                alignment: Alignment.topCenter,
                child: WidgetButtonCustom(
                    FullWidth: width * 0.9,
                    FullHeight: 40.h,
                    title: 'Tambah Form Order',
                    onpressed: _addForm,
                    bgColor: PRIMARY_COLOR,
                    color: PRIMARY_COLOR),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: formListB.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.only(left: 16.w, right: 10.w, top: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Item ${index + 1}',
                              style: titleTextBlack,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: IconButton(
                              onPressed: () => _removeFormB(index),
                              icon: const Icon(Icons.delete),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                              final item = provider.allItem!.data!
                                  .map((data) =>
                                      {'id': data.id, 'name': data.name})
                                  .toList();

                              return CustomAutocomplete(
                                data: item.map((e) => e['name']).toList() ?? [],
                                displayString: (item) => item.toString(),
                                onSelected: (value) {
                                  print("Selected Item: $item");

                                  final selected = item.firstWhere(
                                    (e) => e['name'] == value,
                                  );

                                  setState(() {
                                    selectItemId =
                                        int.parse(selected!['id'].toString());
                                  });

                                  setState(() {
                                    formListB[index]['item_id'] = selectItemId;
                                  });

                                  print("Selected ID: $selectItemId");
                                },
                                labelText: 'Cari Item',
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ListTile(
                        title: Text(
                          'Pilih Order',
                          style: subtitleTextBlack,
                        ),
                        subtitle: Container(
                          margin: EdgeInsets.only(top: height * 0.01),
                          child: Consumer<ProviderItem>(
                            builder: (context, provider, child) {
                              final produk = provider.order!.data!
                                  .map((data) =>
                                      {'id': data.id, 'name': data.code})
                                  .toList();

                              return CustomAutocomplete(
                                data:
                                    produk.map((e) => e['name']).toList() ?? [],
                                displayString: (item) => item.toString(),
                                onSelected: (item) {
                                  print("Selected Item: $item");

                                  final selected = produk.firstWhere(
                                    (e) => e['name'] == item,
                                  );

                                  setState(() {
                                    selectProdukId =
                                        int.parse(selected!['id'].toString());
                                  });

                                  setState(() {
                                    formListB[index]['order_id'] =
                                        selectProdukId;
                                  });

                                  print("Selected ID: $selectProdukId");
                                },
                                labelText: 'Cari Barang',
                              );
                            },
                          ),
                        ),
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
                          'Qty',
                          style: subtitleTextBlack,
                        ),
                        subtitle: Container(
                          margin: EdgeInsets.only(top: height * 0.01),
                          child: WidgetForm(
                            change: (value) {
                              setState(() {
                                formListB[index]['qty'] = value;
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
                      height: 10.h,
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
                                formListB[index]['note'] = value;
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
                    title: 'Tambah Item',
                    onpressed: _addFormB,
                    bgColor: PRIMARY_COLOR,
                    color: PRIMARY_COLOR),
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
              title: 'Simpan',
              onpressed: () async {
                provider.createSuratJalanItem(context, typeJ, selectPicId,
                    nama.text, noKendaraan.text, formList, formListB);
              },
              bgColor: PRIMARY_COLOR,
              color: PRIMARY_COLOR),
        ),
      ),
    );
  }
}

class ComponentUpdateSuratJalanItem extends StatefulWidget {
  const ComponentUpdateSuratJalanItem({
    super.key,
  });
  @override
  State<ComponentUpdateSuratJalanItem> createState() =>
      _ComponentUpdateSuratJalanItemState();
}

class _ComponentUpdateSuratJalanItemState
    extends State<ComponentUpdateSuratJalanItem> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProviderDistribusi>(context, listen: false);
    final data = provider.suratJalanItem?.data;

    noKendaraan = TextEditingController(text: data?.vehicleNumber);

    driver = SingleSelectController(data?.driverName);
    typeJ = data!.type!;
    type = GroupButtonController(selectedIndex: data.type);
    nama = TextEditingController(text: data.nonUserName);

    if (data.orders != null) {
      formList = data.orders
              ?.map((pic) => {
                    "id": pic.id ?? "",
                  })
              .toList() ??
          [];

      order.text =
          data.orders?.isNotEmpty == true ? data.orders![0].code ?? "" : "";
    }
    if (data.details != null) {
      formListB = data.details
              ?.map((pic) => {
                    "item_id": pic.itemId,
                    "order_id": pic.orderId,
                    "qty": pic.qty,
                    "note": pic.string
                  })
              .toList() ??
          [];

      String? getNameById(int id) {
        final pic = provider.suratJalanItem!.data!.orders
            ?.map((data) => {'id': data.id, 'name': data.code})
            .toList();
        // Mencari data dengan ID yang sesuai
        final selected = pic?.firstWhere(
          (e) => e['id'] == id,
        );
        return selected?['name'].toString();
      }

      noOrder.text = data.orders?.isNotEmpty == true
          ? getNameById(data.details![0].orderId!) ?? ""
          : "";
      itemController.text = data.details?.isNotEmpty == true
          ? data.details![0].itemName ?? ""
          : "";
      qty.text = data.details?.isNotEmpty == true
          ? data.details![0].qty.toString() ?? ""
          : "";
      note.text =
          data.details?.isNotEmpty == true ? data.details![0].string ?? "" : "";
    }
  }

  SingleSelectController<String?> driver =
      SingleSelectController<String?>(null);
  TextEditingController noKendaraan = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController order = TextEditingController();
  TextEditingController noOrder = TextEditingController();
  TextEditingController itemController = TextEditingController();
  TextEditingController note = TextEditingController();
  TextEditingController qty = TextEditingController();
  GroupButtonController? type = GroupButtonController();
  int typeJ = 0;

  bool cek = false;
  int jenis = 0;
  int cari = 0;
  int? selectProdukId;
  int? selectItemId;

  int selectPicId = 0;
  int selectPicId1 = 0;
  int selectPicId2 = 0;

  List<Map<String, dynamic>> formListB = []; // List untuk menyimpan data form
  List<Map<String, dynamic>> formList = []; // List untuk menyimpan data form
  // Fungsi untuk menambah form baru
  void _addForm() {
    setState(() {
      formList.add({
        "id": null,
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
      formListB
          .add({"item_id": null, "order_id": null, "qty": null, "note": null});
    });
  }

  // Fungsi untuk menghapus form terakhir
  void _removeFormB(int index) {
    setState(() {
      formListB.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<ProviderDistribusi>(context);
    final data = provider.suratJalanItem?.data;
    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Buat Order',
        center: true,
        colorTitle: Colors.black,
        colorBack: Colors.black,
        colorBG: Colors.grey.shade100,
        back: true,
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
              height: height * 0.1,
              child: ListTile(
                title: Text(
                  'Type',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      controller: type,
                      isRadio: true,
                      options: GroupButtonOptions(
                        selectedColor: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value, index, isSelected) {
                        print('DATA KLIK : $value - $index - $isSelected');
                        setState(() {
                          typeJ = index;
                        });
                      },
                      buttons: const ['User', "Non User"]),
                ),
              ),
            ),
            if (typeJ == 0)
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: width,
                  child: ListTile(
                    title: Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      child: Text(
                        'Pilih Driver',
                        style: subtitleTextBlack,
                      ),
                    ),
                    subtitle: Consumer<ProviderSales>(
                      builder: (context, provider, child) {
                        final pic = provider.modelUsersPic!.data!
                            .map((data) => {'id': data.id, 'name': data.name})
                            .toList();

                        return CustomDropdown(
                          controller: driver,
                          decoration: CustomDropdownDecoration(
                              closedBorder:
                                  Border.all(color: Colors.grey.shade400),
                              expandedBorder:
                                  Border.all(color: Colors.grey.shade400)),
                          hintText: 'Pilih Driver',
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
                  ),
                ),
              ),
            if (typeJ == 1)
              SizedBox(
                width: width,
                height: height * 0.12,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ListTile(
                    title: Text(
                      'Nama',
                      style: subtitleTextBlack,
                    ),
                    subtitle: Container(
                      margin: EdgeInsets.only(top: height * 0.01),
                      child: WidgetForm(
                        alert: 'Nama',
                        hint: 'Nama',
                        controller: nama,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ),
              ),
            SizedBox(
              height: height * 0.02,
            ),
            SizedBox(
              width: width,
              height: height * 0.1,
              child: ListTile(
                title: Text(
                  'Nomor Kendaraan',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: WidgetForm(
                    alert: 'L 1234 TR',
                    hint: 'L 1234 TR',
                    controller: noKendaraan,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            // Gas
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: formList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.only(left: 16.w, right: 10.w, top: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Order Select ${index + 1}',
                              style: titleTextBlack,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: IconButton(
                              onPressed: () => _removeForm(index),
                              icon: const Icon(Icons.delete),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ListTile(
                        title: Text(
                          'Pilih Order',
                          style: subtitleTextBlack,
                        ),
                        subtitle: Container(
                          margin: EdgeInsets.only(top: height * 0.01),
                          child: Consumer<ProviderItem>(
                            builder: (context, provider, child) {
                              final produk = provider.order!.data!
                                  .map((data) =>
                                      {'id': data.id, 'name': data.code})
                                  .toList();

                              return CustomAutocomplete(
                                controller: order,
                                data:
                                    produk.map((e) => e['name']).toList() ?? [],
                                displayString: (item) => item.toString(),
                                onSelected: (item) {
                                  print("Selected Item: $item");

                                  final selected = produk.firstWhere(
                                    (e) => e['name'] == item,
                                  );

                                  setState(() {
                                    selectProdukId =
                                        int.parse(selected!['id'].toString());
                                  });

                                  setState(() {
                                    formList[index]['id'] = selectProdukId;
                                  });

                                  print("Selected ID: $selectProdukId");
                                },
                                labelText: 'Cari Barang',
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              width: width,
              height: height * 0.06,
              child: Align(
                alignment: Alignment.topCenter,
                child: WidgetButtonCustom(
                    FullWidth: width * 0.9,
                    FullHeight: 40.h,
                    title: 'Tambah Form Order',
                    onpressed: _addForm,
                    bgColor: PRIMARY_COLOR,
                    color: PRIMARY_COLOR),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: formListB.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.only(left: 16.w, right: 10.w, top: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Item ${index + 1}',
                              style: titleTextBlack,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: IconButton(
                              onPressed: () => _removeFormB(index),
                              icon: const Icon(Icons.delete),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                              final item = provider.allItem!.data!
                                  .map((data) =>
                                      {'id': data.id, 'name': data.name})
                                  .toList();

                              return CustomAutocomplete(
                                controller: itemController,
                                data: item.map((e) => e['name']).toList() ?? [],
                                displayString: (item) => item.toString(),
                                onSelected: (value) {
                                  print("Selected Item: $item");

                                  final selected = item.firstWhere(
                                    (e) => e['name'] == value,
                                  );

                                  setState(() {
                                    selectItemId =
                                        int.parse(selected!['id'].toString());
                                  });

                                  setState(() {
                                    formListB[index]['item_id'] = selectItemId;
                                  });

                                  print("Selected ID: $selectItemId");
                                },
                                labelText: 'Cari Item',
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ListTile(
                        title: Text(
                          'Pilih Order',
                          style: subtitleTextBlack,
                        ),
                        subtitle: Container(
                          margin: EdgeInsets.only(top: height * 0.01),
                          child: Consumer<ProviderItem>(
                            builder: (context, provider, child) {
                              final produk = provider.order!.data!
                                  .map((data) =>
                                      {'id': data.id, 'name': data.code})
                                  .toList();

                              return CustomAutocomplete(
                                controller: noOrder,
                                data:
                                    produk.map((e) => e['name']).toList() ?? [],
                                displayString: (item) => item.toString(),
                                onSelected: (item) {
                                  print("Selected Item: $item");

                                  final selected = produk.firstWhere(
                                    (e) => e['name'] == item,
                                  );

                                  setState(() {
                                    selectProdukId =
                                        int.parse(selected!['id'].toString());
                                  });

                                  setState(() {
                                    formListB[index]['order_id'] =
                                        selectProdukId;
                                  });

                                  print("Selected ID: $selectProdukId");
                                },
                                labelText: 'Cari Barang',
                              );
                            },
                          ),
                        ),
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
                          'Qty',
                          style: subtitleTextBlack,
                        ),
                        subtitle: Container(
                          margin: EdgeInsets.only(top: height * 0.01),
                          child: WidgetForm(
                            controller: qty,
                            change: (value) {
                              setState(() {
                                formListB[index]['qty'] = value;
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
                      height: 10.h,
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
                            controller: note,
                            onChanged: (value) {
                              setState(() {
                                formListB[index]['note'] = value;
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
                    title: 'Tambah Item',
                    onpressed: _addFormB,
                    bgColor: PRIMARY_COLOR,
                    color: PRIMARY_COLOR),
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
              title: 'Simpan',
              onpressed: () async {
                provider.updateSuratJalanItem(
                    context,
                    data!.idStr!,
                    typeJ,
                    selectPicId,
                    nama.text,
                    noKendaraan.text,
                    formList,
                    formListB);
              },
              bgColor: PRIMARY_COLOR,
              color: PRIMARY_COLOR),
        ),
      ),
    );
  }
}
