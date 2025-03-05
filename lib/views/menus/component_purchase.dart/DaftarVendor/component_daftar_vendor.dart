import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/providers/provider_item.dart';
import 'package:dwigasindo/providers/provider_sales.dart';
import 'package:dwigasindo/views/menus/component_purchase.dart/DaftarVendor/component_detail_data_vendor.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';

class ComponentDaftarVendor extends StatefulWidget {
  const ComponentDaftarVendor({super.key});

  @override
  State<ComponentDaftarVendor> createState() => _ComponentDaftarVendorState();
}

class _ComponentDaftarVendorState extends State<ComponentDaftarVendor> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProviderItem>(context, listen: false);
    provider.getDataVendor(context);
  }

  GroupButtonController? list = GroupButtonController(selectedIndex: 0);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderDistribusi>(context);
    final providerItem = Provider.of<ProviderItem>(context);
    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Daftar Vendor',
        center: true,
        colorTitle: Colors.black,
        colorBack: Colors.black,
        colorBG: Colors.grey.shade100,
        back: true,
        route: () {
          Navigator.pop(context);
        },
        actions: [
          IconButton(
            onPressed: () async {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );

              try {
                await Future.wait([
                  providerItem.getVendorCategory(context),
                  providerItem.getCity(context),
                ]);

                // Navigate sesuai kondisi
                Navigator.of(context).pop(); // Tutup Dialog Loading
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ComponentTambahVendor()));
              } catch (e) {
                Navigator.of(context).pop(); // Tutup Dialog Loading
                print('Error: $e');
                // Tambahkan pesan error jika perlu
              }
            },
            icon: const Icon(Icons.add_circle_outline_rounded),
          )
        ],
      ),
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
            Align(
              alignment: Alignment.centerLeft,
              child: GroupButton(
                  controller: list,
                  isRadio: true,
                  options: GroupButtonOptions(
                    selectedColor: PRIMARY_COLOR,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onSelected: (value, index, isSelected) {
                    print('DATA KLIK : $value - $index - $isSelected');
                  },
                  buttons: const ['List Vendor']),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: providerItem.vendors?.data?.length,
                itemBuilder: (context, index) {
                  final data = providerItem.vendors?.data?[index];
                  return Container(
                    width: double.maxFinite,
                    height: 180.h,
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
                          height: height * 0.05,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: height * 0.1,
                                width: width * 0.4,
                                decoration: const BoxDecoration(
                                  color: PRIMARY_COLOR,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(30),
                                  ),
                                ),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.center,
                                  child: Text(
                                    data?.name ?? "-",
                                    style: titleText,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.025),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(color: Colors.grey.shade300),
                              ),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Kategori',
                                          style: subtitleTextBlack,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            ': ${data?.vendorCategoryName ?? '-'}',
                                            style: subtitleTextBlack),
                                      ),
                                    ),
                                  ],
                                )),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Alamat',
                                            style: subtitleTextBlack,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            ': ${data?.address ?? "-"}',
                                            overflow: TextOverflow.ellipsis,
                                            style: subtitleTextBlack,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Kota',
                                            style: subtitleTextBlack,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                              ': ${data?.cityName ?? "-"}',
                                              style: subtitleTextBlack),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Dibuat oleh',
                                            style: subtitleTextNormal,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.centerLeft,
                                          child: Text(': User 1',
                                              style: subtitleTextNormal),
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
                                title: "Lihat Vendor",
                                onpressed: () async {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                  );

                                  try {
                                    await Future.wait([
                                      provider.getDataVendorDetails(
                                          context, data!.idStr!),
                                    ]);

                                    // Navigate sesuai kondisi
                                    Navigator.of(context)
                                        .pop(); // Tutup Dialog Loading
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ComponentDetailDataVendor(),
                                      ),
                                    );
                                  } catch (e) {
                                    Navigator.of(context)
                                        .pop(); // Tutup Dialog Loading
                                    print('Error: $e');
                                    // Tambahkan pesan error jika perlu
                                  }
                                },
                                bgColor: PRIMARY_COLOR,
                                color: Colors.transparent),
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

class ComponentTambahVendor extends StatefulWidget {
  const ComponentTambahVendor({super.key});
  @override
  State<ComponentTambahVendor> createState() => _ComponentTambahVendorState();
}

class _ComponentTambahVendorState extends State<ComponentTambahVendor> {
  int selectPicId = 0;
  int selectPicId1 = 0;
  int selectPicId2 = 0;
  int? kategoriId;
  int? kotaId;
  int? vendorId;
  double totalPrice = 0;
  double grandTotal = 0;

  TextEditingController name = TextEditingController();
  TextEditingController note = TextEditingController();
  GroupButtonController jenis = GroupButtonController();
  bool cek = false;

  // Fungsi untuk menambah form baru
  // Fungsi untuk menambah form baru (form bebas)

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<ProviderItem>(context);
    final providerSales = Provider.of<ProviderSales>(context);
    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Tambah Vendor',
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
              child: ListTile(
                title: Text(
                  'Nama',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: WidgetForm(
                    controller: name,
                    typeInput: TextInputType.name,
                    alert: 'Contoh : PT ABCD',
                    hint: 'Contoh : PT ABCD',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: 120.h,
              child: ListTile(
                title: Text(
                  'Alamat',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  height: 80.h,
                  child: TextField(
                    controller: note,
                    onChanged: (value) {},
                    maxLines: null,
                    expands: true,
                    decoration: InputDecoration(
                      hintText: 'Masukkan alamat di sini...',
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
              child: ListTile(
                title: Text(
                  'Vendor Category',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: Consumer<ProviderItem>(
                    builder: (context, provider, child) {
                      final pic = provider.modelVendorCategory!.data
                          ?.map((data) => {'id': data.id, 'name': data.name})
                          .toList();

                      return CustomDropdown(
                        decoration: CustomDropdownDecoration(
                            closedBorder:
                                Border.all(color: Colors.grey.shade400),
                            expandedBorder:
                                Border.all(color: Colors.grey.shade400)),
                        hintText: 'Pilih Categori',
                        items: pic?.map((e) => e['name']).toList(),
                        onChanged: (item) {
                          print("Selected Item: $item");

                          final selected = pic?.firstWhere(
                            (e) => e['name'] == item,
                          );

                          setState(() {
                            kategoriId = int.parse(selected!['id'].toString());
                          });
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
                  'Kota',
                  style: subtitleTextBlack,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  child: Consumer<ProviderItem>(
                    builder: (context, provider, child) {
                      final pic = provider.modelCity!.data
                          ?.map((data) => {'id': data.id, 'name': data.name})
                          .toList();

                      return CustomDropdown(
                        decoration: CustomDropdownDecoration(
                            closedBorder:
                                Border.all(color: Colors.grey.shade400),
                            expandedBorder:
                                Border.all(color: Colors.grey.shade400)),
                        hintText: 'Pilih Kota',
                        items: pic?.map((e) => e['name']).toList(),
                        onChanged: (item) {
                          print("Selected Item: $item");

                          final selected = pic?.firstWhere(
                            (e) => e['name'] == item,
                          );

                          setState(() {
                            kotaId = int.parse(selected!['id'].toString());
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
              height: height * 0.1,
              child: ListTile(
                title: Text(
                  'Jenis ',
                  style: subtitleTextBlack,
                ),
                subtitle: Align(
                  alignment: Alignment.topLeft,
                  child: GroupButton(
                      controller: jenis,
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
              height: 10.h,
            ),
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: SizedBox(
            //     width: width,
            //     height: 250.h,
            //     child: ListTile(
            //       title: Text(
            //         'PIC Approval',
            //         style: subtitleTextBlack,
            //       ),
            //       subtitle: Column(
            //         children: [
            //           SizedBox(
            //             height: 10.h,
            //           ),
            //           Consumer<ProviderSales>(
            //             builder: (context, provider, child) {
            //               final pic = provider.modelUsersPic!.data!
            //                   .map((data) => {'id': data.id, 'name': data.name})
            //                   .toList();

            //               return CustomDropdown(
            //                 decoration: CustomDropdownDecoration(
            //                     closedBorder:
            //                         Border.all(color: Colors.grey.shade400),
            //                     expandedBorder:
            //                         Border.all(color: Colors.grey.shade400)),
            //                 hintText: 'Pilih PIC Verifikasi',
            //                 items: pic.map((e) => e['name']).toList(),
            //                 onChanged: (item) {
            //                   print("Selected Item: $item");

            //                   final selected = pic.firstWhere(
            //                     (e) => e['name'] == item,
            //                   );

            //                   setState(() {
            //                     selectPicId =
            //                         int.parse(selected['id'].toString());
            //                   });

            //                   print("Selected ID: $selectPicId");
            //                 },
            //               );
            //             },
            //           ),
            //           SizedBox(
            //             height: 20.h,
            //           ),
            //           Consumer<ProviderSales>(
            //             builder: (context, provider, child) {
            //               final pic = provider.modelUsersPic!.data!
            //                   .map((data) => {'id': data.id, 'name': data.name})
            //                   .toList();

            //               return CustomDropdown(
            //                 decoration: CustomDropdownDecoration(
            //                     closedBorder:
            //                         Border.all(color: Colors.grey.shade400),
            //                     expandedBorder:
            //                         Border.all(color: Colors.grey.shade400)),
            //                 hintText: 'Pilih PIC Mengetahui',
            //                 items: pic.map((e) => e['name']).toList(),
            //                 onChanged: (item) {
            //                   print("Selected Item: $item");

            //                   final selected = pic.firstWhere(
            //                     (e) => e['name'] == item,
            //                   );

            //                   setState(() {
            //                     selectPicId1 =
            //                         int.parse(selected['id'].toString());
            //                   });

            //                   print("Selected ID: $selectPicId1");
            //                 },
            //               );
            //             },
            //           ),
            //           SizedBox(
            //             height: 20.h,
            //           ),
            //           Consumer<ProviderSales>(
            //             builder: (context, provider, child) {
            //               final pic = provider.modelUsersPic!.data!
            //                   .map((data) => {'id': data.id, 'name': data.name})
            //                   .toList();

            //               return CustomDropdown(
            //                 decoration: CustomDropdownDecoration(
            //                     closedBorder:
            //                         Border.all(color: Colors.grey.shade400),
            //                     expandedBorder:
            //                         Border.all(color: Colors.grey.shade400)),
            //                 hintText: 'Pilih PIC Menyetujui',
            //                 items: pic.map((e) => e['name']).toList(),
            //                 onChanged: (item) {
            //                   print("Selected Item: $item");

            //                   final selected = pic.firstWhere(
            //                     (e) => e['name'] == item,
            //                   );

            //                   setState(() {
            //                     selectPicId2 =
            //                         int.parse(selected['id'].toString());
            //                   });

            //                   print("Selected ID: $selectPicId2");
            //                 },
            //               );
            //             },
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: height * 0.05,
            // ),
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
              title: 'Tambah Data Vendor',
              onpressed: () async {
                provider.createVendor(context, name.text, note.text,
                    kategoriId!, jenis.selectedIndex!, kotaId!);
              },
              bgColor: PRIMARY_COLOR,
              color: PRIMARY_COLOR),
        ),
      ),
    );
  }
}
