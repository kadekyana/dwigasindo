import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_item.dart';
import 'package:dwigasindo/providers/provider_sales.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ComponentSelesaiSo extends StatefulWidget {
  ComponentSelesaiSo(
      {super.key,
      required this.id,
      required this.warehouse_id,
      required this.categori_id});
  int id;
  int warehouse_id;
  List<int> categori_id;
  @override
  State<ComponentSelesaiSo> createState() => _ComponentSelesaiSoState();
}

class _ComponentSelesaiSoState extends State<ComponentSelesaiSo> {
  TextEditingController? fisik = TextEditingController();
  TextEditingController? hasil = TextEditingController();
  int selectPicId = 0;
  int selectPicId1 = 0;
  int selectPicId2 = 0;

  bool hide_tanggal = false;

  bool hide_button = false;

  String buttonText = "Mulai SO";

  List<Map<String, dynamic>> details = [];

  void updateDetails(int index, int itemId, String fisikText, int qty) {
    int fisikValue = int.tryParse(fisikText) ?? 0;
    int hasilValue = fisikValue + qty;

    setState(() {
      details.removeWhere((item) => item['item_id'] == itemId);
      details.add({
        "item_id": itemId,
        "qty": qty,
        "real_qty": fisikValue,
        "result_qty": hasilValue,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderItem>(context);
    final data = provider.detailStock!.data;
    return Scaffold(
      appBar: WidgetAppbar(
        title: 'Buat Detail Stock Opname',
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
        child: SizedBox(
          width: width,
          height: height,
          child: Column(
            children: [
              SizedBox(
                height: height * 0.01,
              ),
              Container(
                width: width,
                height: 20.h,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Text(
                      'Kategori',
                      style: titleTextBlack,
                    ),
                    const Text(" : "),
                    Expanded(
                      child: Text(
                        data?.categories ?? "-",
                        style: titleTextBlack,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: width,
                height: 20.h,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Text(
                      'Gudang  ',
                      style: titleTextBlack,
                    ),
                    const Text(" : "),
                    Expanded(
                      child: Text(
                        data?.warehouseName ?? "-",
                        style: titleTextBlack,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Container(
                width: width,
                height: 30.h,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: FittedBox(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Hasil Data',
                    style: titleTextBlack,
                  ),
                ),
              ),
              Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('No')),
                      DataColumn(label: Text('Item')),
                      DataColumn(label: Text('Qty')),
                      DataColumn(label: Text('Fisik')),
                      DataColumn(label: Text('Hasil')),
                    ],
                    rows: List<DataRow>.generate(
                      data!.details!.length,
                      (index) {
                        final item = data.details![index];

                        return DataRow(cells: [
                          DataCell(Text((index + 1).toString())), // No
                          DataCell(Text(item.name ?? "-")), // Item
                          DataCell(Text("${item.totalQty ?? "-"}")), // Qty
                          DataCell(
                            TextField(
                              controller: fisik,
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                updateDetails(
                                    index, item.id!, value, item.totalQty!);
                              },
                            ),
                          ),
                          DataCell(
                            Text(
                                "${(fisik?.text != '') ? int.tryParse(fisik!.text)! + item.totalQty! : 0}"),
                          ),
                        ]);
                      },
                    ),
                  ),
                ),
              ),
              const Divider(),
              ListTile(
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: width,
        height: 50.h,
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: WidgetButtonCustom(
          FullWidth: width,
          FullHeight: 50.h,
          title: 'Selesai',
          onpressed: () {
            print(details);
            provider.createDetailStock(context, widget.id, widget.warehouse_id,
                widget.categori_id, details, selectPicId, selectPicId2);
          },
          bgColor: PRIMARY_COLOR,
          color: PRIMARY_COLOR,
        ),
      ),
    );
  }
}

class ApprovalVerifikasi extends StatefulWidget {
  ApprovalVerifikasi({
    super.key,
    required this.id,
    required this.type,
  });
  int id;
  int type;
  @override
  State<ApprovalVerifikasi> createState() => _ApprovalVerifikasiState();
}

class _ApprovalVerifikasiState extends State<ApprovalVerifikasi> {
  // List untuk menyimpan data soVerifikasi
  List<Map<String, dynamic>> soVerifikasi = [];
  // List controller per baris
  List<TextEditingController> fisikControllers = [];
  // List untuk menyimpan status per baris (default pending = 1)
  List<int> statusList = [];

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProviderItem>(context, listen: false);
    final data = provider.approvalVerifikasi!.data;
    if (data != null) {
      // Inisialisasi controller dan statusList sesuai jumlah data
      fisikControllers = data
          .map((item) =>
              TextEditingController(text: item.quantityReal.toString()))
          .toList();
      statusList = List<int>.generate(data.length, (index) => 1);
      // Inisialisasi soVerifikasi dengan data awal dari API
      soVerifikasi = data.map((item) {
        return {
          "id": item.id,
          "real_qty": item.quantityReal, // nilai awal
          "result_qty": item.quantityResult, // nilai awal
          "status": 1, // default pending
        };
      }).toList();
    }
  }

  @override
  void dispose() {
    for (var controller in fisikControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  // Fungsi updateDetails untuk update real_qty dan result_qty ketika nilai fisik diubah.
  // Rumus: new_result_qty = initial_result_qty + (new_fisik - initial_real_qty)
  void updateDetails(int index, int itemId, String fisikText, int initialReal,
      int initialResult) {
    int newFisik = int.tryParse(fisikText) ?? initialReal;
    int newResult = initialResult + (newFisik - initialReal);

    setState(() {
      // Update data di soVerifikasi berdasarkan item id
      int dataIndex =
          soVerifikasi.indexWhere((element) => element["id"] == itemId);
      if (dataIndex != -1) {
        soVerifikasi[dataIndex]["real_qty"] = newFisik;
        soVerifikasi[dataIndex]["result_qty"] = newResult;
      }
    });
  }

  // Fungsi toggleStatus untuk mengubah status pada tiap baris.
  // Siklus: Pending (1) -> Approved (2) -> Revisi (3) -> kembali ke Pending (1)
  void toggleStatus(int index, int itemId) {
    setState(() {
      int dataIndex =
          soVerifikasi.indexWhere((element) => element["id"] == itemId);
      if (dataIndex != -1) {
        int currentStatus = soVerifikasi[dataIndex]["status"];
        int newStatus;
        if (currentStatus == 1) {
          newStatus = 2;
        } else if (currentStatus == 2) {
          newStatus = 3;
        } else {
          newStatus = 1;
        }
        soVerifikasi[dataIndex]["status"] = newStatus;
        statusList[index] = newStatus;
      }
    });
  }

  // Fungsi approveSemua untuk mengubah status semua baris menjadi Approved (2)
  void approveSemua() {
    setState(() {
      for (int i = 0; i < soVerifikasi.length; i++) {
        soVerifikasi[i]["status"] = 2;
        statusList[i] = 2;
      }
    });
  }

  // Fungsi untuk cek apakah ada baris yang statusnya Revisi (3)
  bool hasRevisi() {
    return soVerifikasi.any((element) => element["status"] == 3);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<ProviderItem>(context);
    final data = provider.approvalVerifikasi!.data;

    return Scaffold(
      appBar: WidgetAppbar(
        title: (widget.type == 3)
            ? 'Revisi Detail Stock Opname'
            : 'Approval Detail Stock Opname',
        center: true,
        colorTitle: Colors.black,
        colorBack: Colors.black,
        colorBG: Colors.grey.shade100,
        back: true,
        route: () {
          Navigator.pop(context);
        },
      ),
      body: (data?.length == 0)
          ? Center(
              child: Text(
                  "Belum Terdapat Data Yang Akan di ${(widget.type == 3) ? 'Revisi' : 'Approve'}"),
            )
          : SingleChildScrollView(
              child: SizedBox(
                width: width,
                height: height,
                child: Column(
                  children: [
                    SizedBox(height: height * 0.01),
                    Container(
                      width: width,
                      height: 30.h,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        child: Text('Hasil Data', style: titleTextBlack),
                      ),
                    ),
                    Container(
                      width: width,
                      height: 20.h,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        child: Text('Note : Geser Kekiri Untuk Approve',
                            style: subtitleTextBlack),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: [
                          const DataColumn(label: Text('No')),
                          const DataColumn(label: Text('Item')),
                          const DataColumn(label: Text('Qty')),
                          const DataColumn(label: Text('Fisik')),
                          const DataColumn(label: Text('Hasil')),
                          if (widget.type != 3)
                            const DataColumn(label: Text('Approval')),
                        ],
                        rows: List<DataRow>.generate(
                          data!.length,
                          (index) {
                            final item = data[index];
                            final controller = fisikControllers[index];
                            int initialResult = item.quantityResult!;
                            int initialReal = item.quantityReal!;
                            final currentData = soVerifikasi.firstWhere(
                              (element) => element["id"] == item.id,
                              orElse: () => <String, int>{
                                "real_qty": initialReal,
                                "result_qty": initialResult,
                                "status": 1,
                              },
                            );
                            return DataRow(cells: [
                              DataCell(Text((index + 1).toString())),
                              DataCell(Text(item.itemName ?? "-")),
                              DataCell(Text("${item.quantity ?? "-"}")),
                              DataCell(
                                TextField(
                                  controller: controller,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    updateDetails(
                                      index,
                                      item.id!,
                                      value,
                                      initialReal,
                                      initialResult,
                                    );
                                  },
                                ),
                              ),
                              DataCell(
                                Text("${currentData["result_qty"]}"),
                              ),
                              if (widget.type != 3)
                                DataCell(
                                  Container(
                                    margin: EdgeInsets.only(top: 10.h),
                                    child: WidgetButtonCustom(
                                      FullWidth: 100.w,
                                      FullHeight: 40.h,
                                      title: (currentData["status"] == 1)
                                          ? "Pending"
                                          : (currentData["status"] == 2)
                                              ? "Approved"
                                              : "Reject",
                                      onpressed: () {
                                        toggleStatus(index, item.id!);
                                      },
                                      color: (currentData["status"] == 1)
                                          ? Colors.grey
                                          : (currentData["status"] == 2)
                                              ? PRIMARY_COLOR
                                              : SECONDARY_COLOR,
                                      bgColor: (currentData["status"] == 1)
                                          ? Colors.grey
                                          : (currentData["status"] == 2)
                                              ? PRIMARY_COLOR
                                              : SECONDARY_COLOR,
                                    ),
                                  ),
                                ),
                            ]);
                          },
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: (data?.length == 0)
          ? const SizedBox.shrink()
          : Container(
              width: width,
              height: 100.h,
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(
                children: [
                  if (widget.type != 3)
                    Expanded(
                      child: SizedBox(
                        width: width,
                        height: 50.h,
                        child: WidgetButtonCustom(
                          FullWidth: width,
                          FullHeight: 50.h,
                          title: 'Approve Semua',
                          onpressed: () {
                            approveSemua();
                          },
                          bgColor: PRIMARY_COLOR,
                          color: PRIMARY_COLOR,
                        ),
                      ),
                    ),
                  SizedBox(height: 10.h),
                  Expanded(
                    child: Row(
                      children: [
                        if (widget.type != 3)
                          Expanded(
                            child: WidgetButtonCustom(
                              FullWidth: width,
                              FullHeight: 50.h,
                              title: 'Kembali',
                              onpressed: () {
                                print(soVerifikasi);
                                Navigator.pop(context);
                              },
                              bgColor: Colors.grey,
                              color: Colors.grey,
                            ),
                          ),
                        if (widget.type != 3)
                          if (!hasRevisi()) SizedBox(width: 10.w),
                        // Tombol Submit hanya muncul apabila tidak ada data yang statusnya 3 (Revisi)
                        if (widget.type != 3)
                          if (!hasRevisi())
                            Expanded(
                              child: WidgetButtonCustom(
                                FullWidth: width,
                                FullHeight: 50.h,
                                title: 'Submit',
                                onpressed: () {
                                  print(soVerifikasi);
                                  provider.approvalDetailStock(
                                    context,
                                    widget.id,
                                    widget.type,
                                    soVerifikasi,
                                  );
                                },
                                bgColor: PRIMARY_COLOR,
                                color: PRIMARY_COLOR,
                              ),
                            ),
                        if (widget.type == 3)
                          Expanded(
                            child: WidgetButtonCustom(
                              FullWidth: width,
                              FullHeight: 50.h,
                              title: 'Submit',
                              onpressed: () {
                                print(soVerifikasi);
                                provider.approvalDetailStock(
                                  context,
                                  widget.id,
                                  widget.type,
                                  soVerifikasi,
                                );
                              },
                              bgColor: PRIMARY_COLOR,
                              color: PRIMARY_COLOR,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
