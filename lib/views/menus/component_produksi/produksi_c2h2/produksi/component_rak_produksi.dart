import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_produksi.dart';
import 'package:dwigasindo/views/menus/component_produksi/produksi_c2h2/produksi/component_detail_rak.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_dropdown.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';

class ComponentRakProduksi extends StatelessWidget {
  ComponentRakProduksi(
      {super.key, required this.title, required this.idStr, required this.id});
  String title;
  String idStr;
  int id;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final provider = Provider.of<ProviderProduksi>(context);

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: WidgetAppbar(
          title: 'Rak Produksi',
          back: true,
          route: () {
            Navigator.pop(context);
          },
          center: true,
          colorBG: Colors.grey.shade100,
          colorBack: Colors.black,
          colorTitle: Colors.black,
        ),
        body: SingleChildScrollView(
          child: (provider.isLoading == true)
              ? SizedBox(
                  width: width,
                  height: height,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : (title == 'C2H2')
                  ? widgetC2H2(
                      width: width,
                      height: height,
                      provider: provider,
                      title: title,
                      idStr: idStr,
                    )
                  : widgetHighPreasure(
                      width: width,
                      height: height,
                      provider: provider,
                      title: title,
                      idStr: idStr,
                      id: id,
                    ),
        ));
  }
}

class widgetC2H2 extends StatefulWidget {
  const widgetC2H2({
    super.key,
    required this.width,
    required this.height,
    required this.provider,
    required this.title,
    required this.idStr,
  });

  final double width;
  final double height;
  final String title;
  final String idStr;
  final ProviderProduksi provider;

  @override
  State<widgetC2H2> createState() => _widgetC2H2State();
}

class _widgetC2H2State extends State<widgetC2H2> {
  int? selectedRakId;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Column(
        children: [
          SizedBox(
            height: widget.height * 0.05,
          ),
          GroupButton(
              isRadio: true,
              options: GroupButtonOptions(
                selectedColor: PRIMARY_COLOR,
                unselectedBorderColor: PRIMARY_COLOR,
                borderRadius: BorderRadius.circular(8),
              ),
              onSelected: (value, index, isSelected) {
                final selectedRak = widget.provider.allRak!.data!.firstWhere(
                  (rak) => rak.name == value, // Cocokkan berdasarkan nama
                );

                setState(() {
                  selectedRakId = selectedRak.id; // Simpan rak.id yang sesuai
                });

                print('DATA KLIK : $value - $index - $isSelected');
                print('ID RAK TERPILIH: $selectedRakId');
              },
              buttons: widget.provider.allRak!.data!
                  .map((rak) => rak.name ?? '')
                  .toList()),
          SizedBox(
            height: widget.height * 0.02,
          ),
          WidgetButtonCustom(
              FullWidth: widget.width * 0.9,
              FullHeight: widget.height * 0.06,
              title: 'Submit',
              onpressed: () async {
                // widget.provider.isLoading = true;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ComponentDetailRak(
                      title: widget.title,
                      idRak: selectedRakId,
                      idStr: widget.idStr,
                    ),
                  ),
                );
                await widget.provider.getIsiRak(context, selectedRakId, [0]);
              },
              bgColor: PRIMARY_COLOR,
              color: PRIMARY_COLOR),
        ],
      ),
    );
  }
}

class widgetHighPreasure extends StatefulWidget {
  const widgetHighPreasure({
    super.key,
    required this.width,
    required this.height,
    required this.provider,
    required this.title,
    required this.idStr,
    required this.id,
  });

  final double width;
  final double height;
  final String title;
  final String idStr;
  final ProviderProduksi provider;
  final int id;

  @override
  State<widgetHighPreasure> createState() => _widgetHighPreasureState();
}

class _widgetHighPreasureState extends State<widgetHighPreasure> {
  List<Map<String, dynamic>> formList = [];
  List<Map<String, dynamic>>? allItem;
  List<Map<String, dynamic>>? jenisGas;
  List<Map<String, dynamic>>? tangki;
  List<Map<String, dynamic>>? vendor;
  List<Map<String, dynamic>>? groupRak;
  List<Map<String, dynamic>>? mixRak;

  GroupButtonController? pengisian = GroupButtonController();
  int? selectGroupRak;
  int? selectTypeGas;
  int? selectItem;
  int? selectTank;
  int? selectVendor;
  int? selectMixRak;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProviderProduksi>(context, listen: false);
    allItem = provider.allItem?.data
        ?.map((data) => {'id': data.id, 'name': data.name})
        .toList();
    jenisGas = provider.allTubeGas?.data
        .map((data) => {'id': data.id, 'name': data.name})
        .toList();
    tangki = provider.allTank?.data
        ?.map((data) => {'id': data.id, 'name': data.name})
        .toList();
    vendor = provider.allVendor?.data
        ?.map((data) => {'id': data.id, 'name': data.name})
        .toList();
    groupRak = provider.groupRakMix?.data
        ?.map((data) => {'id': data.id, 'name': data.name})
        .toList();
    mixRak = provider.mixRak?.data
        ?.map((data) => {'id': data.id, 'name': data.name})
        .toList();
  }

  // List untuk menyimpan data form
  void _addForm() {
    if (selectTank == null || selectVendor == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Pilih tangki dan vendor terlebih dahulu')),
      );
      return;
    }
    setState(() {
      formList.add({
        "komposisi": null,
        "qty": null,
        "tank": selectTank,
        "vendor": selectVendor,
      });
    });
  }

  // Fungsi untuk menghapus form terakhir
  void _removeForm(int index) {
    if (formList.isNotEmpty) {
      setState(() {
        formList.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: widget.width,
          height: widget.height * 0.17,
          child: ListTile(
            title: Text(
              'Pilih Jenis Pengisian*',
              style: titleTextBlack,
            ),
            subtitle: Align(
              alignment: Alignment.topLeft,
              child: GroupButton(
                  isRadio: true,
                  controller: pengisian,
                  options: GroupButtonOptions(
                      spacing: widget.width * 0.05,
                      selectedColor: PRIMARY_COLOR,
                      borderRadius: BorderRadius.circular(8),
                      mainGroupAlignment: MainGroupAlignment.start),
                  onSelected: (value, index, isSelected) {
                    print('DATA KLIK : $value - $index - $isSelected');
                  },
                  buttons: const ['CO2', "GAS", "VGL/DEWAR", "Mix Gas"]),
            ),
          ),
        ),
        SizedBox(
          width: widget.width,
          height: widget.height * 0.12,
          child: ListTile(
            title: Text(
              'Pilih Group Rak*',
              style: titleTextBlack,
            ),
            subtitle: Align(
              alignment: Alignment.topLeft,
              child: GroupButton(
                  isRadio: true,
                  options: GroupButtonOptions(
                    spacing: widget.width * 0.05,
                    selectedColor: PRIMARY_COLOR,
                    mainGroupAlignment: MainGroupAlignment.start,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onSelected: (value, index, isSelected) {
                    print('DATA KLIK : $value - $index - $isSelected');
                    final selected =
                        groupRak!.firstWhere((item) => item['name'] == value);
                    setState(() {
                      selectGroupRak = selected['id'];
                    });
                    print(selectGroupRak);
                  },
                  buttons: groupRak!
                      .map((data) => data['name'].toString())
                      .toList()),
            ),
          ),
        ),
        SizedBox(
          height: widget.height * 0.01,
        ),
        SizedBox(
          width: widget.width,
          height: widget.height * 0.1,
          child: ListTile(
            title: Text(
              'Pilih Nomor Rak*',
              style: titleTextBlack,
            ),
            subtitle: Align(
              alignment: Alignment.topLeft,
              child: GroupButton(
                  isRadio: true,
                  options: GroupButtonOptions(
                    selectedColor: PRIMARY_COLOR,
                    mainGroupAlignment: MainGroupAlignment.start,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onSelected: (value, index, isSelected) {
                    print('DATA KLIK : $value - $index - $isSelected');
                    final selected =
                        mixRak!.firstWhere((item) => item['name'] == value);
                    setState(() {
                      selectMixRak = selected['id'];
                    });
                    print(selectMixRak);
                  },
                  buttons:
                      mixRak!.map((data) => data['name'].toString()).toList()),
            ),
          ),
        ),
        SizedBox(
          width: widget.width,
          height: widget.height * 0.1,
          child: ListTile(
            title: Text(
              'Pilih Jenis Gas',
              style: subtitleTextBlack,
            ),
            subtitle: WidgetDropdown(
              items: jenisGas!.map((data) => data['name'].toString()).toList(),
              hintText: 'Item Barang',
              onChanged: (value) {
                final selected =
                    jenisGas!.firstWhere((item) => item['name'] == value);
                setState(() {
                  selectTypeGas = selected['id'];
                });
                print(selectTypeGas);
              },
              controller: null,
            ),
          ),
        ),
        SizedBox(
          height: widget.height * 0.02,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: formList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                SizedBox(
                  width: widget.width,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: ListTile(
                          title: Text(
                            'Komposisi',
                            style: subtitleTextBlack,
                          ),
                          subtitle: WidgetDropdown(
                            items: allItem!
                                .map((data) => data['name'].toString())
                                .toList(),
                            hintText: 'Item Barang',
                            onChanged: (value) {
                              final selected = allItem!
                                  .firstWhere((item) => item['name'] == value);
                              setState(() {
                                formList[index]['komposisi'] = selected['id'];
                              });
                              print(formList[index]['komposisi']);
                            },
                            controller: null,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(
                            'Qty',
                            style: subtitleTextBlack,
                          ),
                          subtitle: WidgetForm(
                            alert: 'Qty',
                            hint: 'Qty',
                            change: (value) {
                              setState(() {
                                formList[index]['qty'] = value;
                              });
                              print(formList[index]['qty']);
                            },
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: widget.width * 0.15,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                              onPressed: () {
                                _removeForm(index);
                              },
                              icon: const Icon(Icons.delete)),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: widget.height * 0.01,
                ),
              ],
            );
          },
        ),
        Container(
          width: widget.width,
          height: 30,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: [
              IconButton(
                  onPressed: _addForm, icon: const Icon(Icons.add_circle)),
            ],
          ),
        ),
        SizedBox(
          height: widget.height * 0.01,
        ),
        SizedBox(
          width: widget.width,
          height: widget.height * 0.1,
          child: ListTile(
            title: Text(
              'Pilih Tangki',
              style: subtitleTextBlack,
            ),
            subtitle: WidgetDropdown(
              items: tangki!.map((data) => data['name'].toString()).toList(),
              hintText: 'Pilih Tangki',
              onChanged: (value) {
                final selected =
                    tangki!.firstWhere((item) => item['name'] == value);
                setState(() {
                  selectTank = selected['id'];
                });
                print(selectTank);
              },
              controller: null,
            ),
          ),
        ),
        SizedBox(
          height: widget.height * 0.01,
        ),
        SizedBox(
          width: widget.width,
          height: widget.height * 0.1,
          child: ListTile(
            title: Text(
              'Pilih Supplier',
              style: subtitleTextBlack,
            ),
            subtitle: WidgetDropdown(
              items: vendor!.map((data) => data['name'].toString()).toList(),
              hintText: 'Piih Supplier',
              onChanged: (value) {
                final selectedC =
                    vendor!.firstWhere((item) => item['name'] == value);
                setState(() {
                  selectVendor = selectedC['id'];
                });
                print(selectVendor);
              },
              controller: null,
            ),
          ),
        ),
        SizedBox(
          height: widget.height * 0.02,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Stack untuk Tanki
                  Stack(
                    children: [
                      // Bentuk tangki (kontainer luar)
                      Container(
                        width: widget.width * 0.2,
                        height: widget.height * 0.15,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      // Bagian isi tangki (Vendor B)
                      Positioned(
                        bottom: 40, // Dimulai dari atas isi Vendor B
                        child: Container(
                          width: widget.width * 0.2,
                          height: widget.height * 0.05,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFF0000), // Warna merah (Vendor A)
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: widget.width * 0.2,
                          height: widget.height * 0.06,
                          decoration: BoxDecoration(
                            color: const Color(
                                0xFF003366), // Warna biru (Vendor B)
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      // Bagian isi tangki (Vendor A)
                    ],
                  ),
                  SizedBox(width: widget.width * 0.05),
                  // Informasi Vendor
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Indikator Tangki", style: titleTextBlack),
                      Row(
                        children: [
                          // Kotak warna merah untuk Vendor A
                          Container(
                            width: 16,
                            height: 16,
                            color: const Color(0xFFFF0000),
                          ),
                          const SizedBox(width: 8),
                          Text("Vendor A: (Data Stok MoU)",
                              style: subtitleTextBlack),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          // Kotak warna biru untuk Vendor B
                          Container(
                            width: 16,
                            height: 16,
                            color: const Color(0xFF003366),
                          ),
                          const SizedBox(width: 8),
                          Text("Vendor B: (Data Stok MoU)",
                              style: subtitleTextBlack),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text("(Jumlah Data Stok MoU)", style: subtitleTextBlack),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: widget.height * 0.02,
        ),
        WidgetButtonCustom(
            FullWidth: widget.width * 0.93,
            FullHeight: widget.height * 0.06,
            title: 'Submit',
            onpressed: () async {
              if (pengisian!.selectedIndex == null ||
                  selectGroupRak == null ||
                  selectMixRak == null ||
                  selectTypeGas == null ||
                  formList.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content:
                          Text('Harap lengkapi semua data sebelum submit!')),
                );
                return;
              }

              // Validasi tambahan untuk memastikan setiap form terisi
              for (var form in formList) {
                if (form['komposisi'] == null || form['qty'] == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                            Text('Harap lengkapi semua form sebelum submit!')),
                  );
                  return;
                }
              }
              print("c2h2_production_id = ${widget.id}");
              print("fill_type = ${pengisian!.selectedIndex}");
              print("mix_gas_shelf_group_id = ${selectGroupRak!}");
              print("mix_gas_shelf_id = $selectMixRak");
              print("tube_gas_id = $selectTypeGas");
              print("items = $formList");
              widget.provider.createRakMixGas(
                  context,
                  widget.id,
                  pengisian!.selectedIndex!,
                  selectGroupRak!,
                  selectMixRak!,
                  selectTypeGas!,
                  formList);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ComponentDetailRak(
                    title: widget.title,
                    idStr: widget.idStr,
                  ),
                ),
              );
            },
            bgColor: PRIMARY_COLOR,
            color: PRIMARY_COLOR),
        SizedBox(
          height: widget.height * 0.02,
        ),
      ],
    );
  }
}
