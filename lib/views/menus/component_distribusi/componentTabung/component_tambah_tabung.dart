import 'dart:async';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/providers/provider_scan.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_button_custom.dart';
import 'package:dwigasindo/widgets/widget_dropdown.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';

class ComponentTambahTabung extends StatefulWidget {
  ComponentTambahTabung({super.key, this.uuid});
  String? uuid;
  @override
  State<ComponentTambahTabung> createState() => _ComponentTambahTabungState();
}

class _ComponentTambahTabungState extends State<ComponentTambahTabung> {
  Timer? _timer;
  TextEditingController tahun = TextEditingController();
  TextEditingController serial = TextEditingController();
  TextEditingController lokasi = TextEditingController();

  SingleSelectController<String?> jenisTabung =
      SingleSelectController<String?>(null);

  SingleSelectController<String?> customer =
      SingleSelectController<String?>(null);

  SingleSelectController<String?> jenisGas =
      SingleSelectController<String?>(null);

  SingleSelectController<String?> supllier =
      SingleSelectController<String?>(null);

  String selectTubeGas = '';
  int? selectCustomer;
  int? selectSupllier;

  int? owner = 0;
  int? nonSingletubeType;
  int? selectnonGrade;
  bool nonGrade = true;
  int? selectedGradeIndex;

  bool isSingle = false;

  List<String>? tubeGrade;
  List<String>? tubeType;
  List<Map<String, dynamic>>? tubeGas;
  List<Map<String, dynamic>>? tubecustomer;
  List<Map<String, dynamic>>? tubesupplier;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final provider = Provider.of<ProviderDistribusi>(context, listen: false);

    // Ambil data dan cek apakah tidak null
    tubeGrade = provider.tubeGrades?.data.map((data) => data.name).toList();
    tubeType = provider.tubeTypes?.data.map((data) => data.name).toList();

    tubeGas = provider.tubeGas?.data
        .map((data) => {'id': data.id, 'name': data.name})
        .toList();

    tubecustomer = provider.customer?.data
        .map((data) => {'id': data.id, 'name': data.name})
        .toList();

    tubesupplier = provider.supllier?.data
        .map((data) => {'id': data.id, 'name': data.name})
        .toList();

    // Cek data supplier dan customer
    print("Supllier data: ${provider.supllier?.data}");
    print("Customer data: ${provider.customer?.data}");
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<ProviderDistribusi>(context);
    final providerS = Provider.of<ProviderScan>(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: WidgetAppbar(
        title: 'Tambah Tabung',
        back: true,
        center: true,
        colorBG: Colors.grey.shade100,
        colorBack: Colors.black,
        colorTitle: Colors.black,
        route: () {
          Navigator.pop(context);
        },
      ),
      body: (provider.isLoadingT == true)
          ? const Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width,
                      height: height * 0.1,
                      child: ListTile(
                        title: const Text(
                          'Kepemilikan*',
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
                              onSelected: (value, index, isSelected) {
                                setState(() {
                                  owner = index + 1;
                                  if (index == 0) {
                                    // Pilihan Assets, set data supplier
                                    tubesupplier = provider.supllier?.data
                                        .map((data) =>
                                            {'id': data.id, 'name': data.name})
                                        .toList();
                                    selectCustomer = null;
                                    supllier.value = null;
                                    customer.value = null;
                                    print(tubecustomer);
                                    print(tubesupplier);
                                  } else {
                                    // Pilihan Pelanggan, set data customer
                                    tubecustomer = provider.customer?.data
                                        .map((data) =>
                                            {'id': data.id, 'name': data.name})
                                        .toList();
                                    selectSupllier = null;
                                    supllier.value = null;
                                    customer.value = null;
                                    print(tubecustomer);
                                    print(tubesupplier);
                                  }
                                  print(
                                      'DATA KLIK : $value - $index - $isSelected');
                                });
                              },
                              buttons: const ['Assets', "Pelanggan"]),
                        ),
                      ),
                    ),
                    (owner == 1)
                        ? SizedBox(
                            width: width,
                            height: height * 0.1,
                            child: ListTile(
                              title: const Text(
                                'Supplier',
                                style: subtitleTextBlack,
                              ),
                              subtitle: WidgetDropdown(
                                items: tubesupplier != null
                                    ? tubesupplier!
                                        .map((item) => item['name'].toString())
                                        .toList()
                                    : [],
                                hintText: 'Tipe',
                                controller: supllier,
                                onChanged: (value) {
                                  if (tubesupplier != null) {
                                    final selecttubeC = tubesupplier!
                                        .firstWhere(
                                            (item) => item['name'] == value);
                                    print("ID VENDOR : ${selecttubeC['id']}");
                                    setState(() {
                                      selectSupllier = selecttubeC['id'];
                                    });
                                  }
                                },
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    (owner == 2)
                        ? SizedBox(
                            width: width,
                            height: height * 0.1,
                            child: ListTile(
                              title: const Text(
                                'Customer',
                                style: subtitleTextBlack,
                              ),
                              subtitle: WidgetDropdown(
                                items: tubecustomer != null
                                    ? tubecustomer!
                                        .map((item) => item['name'].toString())
                                        .toList()
                                    : [],
                                hintText: 'Tipe',
                                controller: customer,
                                onChanged: (value) {
                                  if (tubecustomer != null) {
                                    final selecttubeC = tubecustomer!
                                        .firstWhere(
                                            (item) => item['name'] == value);
                                    print("ID CUSTOMER : ${selecttubeC['id']}");
                                    setState(() {
                                      selectCustomer = selecttubeC['id'];
                                    });
                                  }
                                },
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    SizedBox(
                      width: width,
                      height: height * 0.1,
                      child: ListTile(
                        title: const Text(
                          'Jenis Tabung*',
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
                              onSelected: (value, index, isSelected) {
                                if (value == 'Non Single') {
                                  setState(() {
                                    isSingle = false;
                                  });
                                } else {
                                  setState(() {
                                    isSingle = true;
                                  });
                                }
                                print(
                                    'DATA KLIK : $value - $index - $isSelected');
                              },
                              buttons: const ['Single', "Non Single"]),
                        ),
                      ),
                    ),
                    (!isSingle)
                        ? SizedBox(
                            width: width,
                            height: height * 0.1,
                            child: ListTile(
                              title: const Text(
                                'Jenis Tabung*',
                                style: TextStyle(color: Colors.black),
                              ),
                              subtitle: Align(
                                alignment: Alignment.topLeft,
                                child: GroupButton(
                                  isRadio: true,
                                  options: GroupButtonOptions(
                                      selectedColor: PRIMARY_COLOR,
                                      borderRadius: BorderRadius.circular(8),
                                      // Disable tombol jika "Tidak" dipilih pada "Non Grade"
                                      unselectedColor: Colors.white,
                                      selectedTextStyle:
                                          const TextStyle(color: Colors.white)),
                                  onSelected: (value, index, isSelected) {
                                    setState(() {
                                      nonSingletubeType = index + 1;
                                    });
                                    print(
                                        'Grade Selected: $value - ${index + 1} - $isSelected');
                                  },
                                  buttons: tubeType!,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    SizedBox(
                      width: width,
                      height: height * 0.1,
                      child: ListTile(
                        title: const Text(
                          'Jenis Gas*',
                          style: subtitleTextBlack,
                        ),
                        subtitle: WidgetDropdown(
                          items: tubeGas!
                              .map((item) => item['name'].toString())
                              .toList(),
                          hintText: 'Tipe',
                          controller: jenisGas,
                          onChanged: (value) {
                            final selectedC = tubeGas!
                                .firstWhere((item) => item['name'] == value);
                            setState(() {
                              selectTubeGas = selectedC['id'].toString();
                            });
                          },
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
                        title: const Text(
                          'Non Grade*',
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
                              onSelected: (value, index, isSelected) {
                                if (value == 'Tidak') {
                                  setState(() {
                                    nonGrade = false;
                                  });
                                } else {
                                  setState(() {
                                    nonGrade = true;
                                  });
                                }
                                print(
                                    'DATA KLIK : $value - $index - $isSelected');
                              },
                              buttons: const ['Ya', "Tidak"]),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width,
                      height: height * 0.1,
                      child: ListTile(
                        title: const Text(
                          'Grade*',
                          style: TextStyle(color: Colors.black),
                        ),
                        subtitle: Align(
                          alignment: Alignment.topLeft,
                          child: GroupButton(
                            isRadio: true,
                            options: GroupButtonOptions(
                                selectedColor:
                                    !nonGrade ? Colors.grey : PRIMARY_COLOR,
                                borderRadius: BorderRadius.circular(8),
                                // Disable tombol jika "Tidak" dipilih pada "Non Grade"
                                unselectedColor:
                                    !nonGrade ? Colors.grey : Colors.white,
                                selectedTextStyle: TextStyle(
                                    color: !nonGrade
                                        ? Colors.black
                                        : Colors.white)),
                            onSelected: !nonGrade
                                ? null
                                : (value, index, isSelected) {
                                    setState(() {
                                      selectedGradeIndex = index + 1;
                                    });
                                    print(
                                        'Grade Selected: $value - ${index + 1} - $isSelected');
                                  },
                            buttons: tubeGrade!,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width,
                      height: height * 0.1,
                      child: ListTile(
                        title: const Text(
                          'Tahun Tabung',
                          style: TextStyle(color: Colors.black),
                        ),
                        subtitle: Container(
                          margin: EdgeInsets.only(top: height * 0.01),
                          child: WidgetForm(
                            controller: tahun,
                            alert: '2024',
                            hint: '2024',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    SizedBox(
                      width: width,
                      height: height * 0.1,
                      child: ListTile(
                        title: const Text(
                          'Serial Number',
                          style: TextStyle(color: Colors.black),
                        ),
                        subtitle: Container(
                          margin: EdgeInsets.only(top: height * 0.01),
                          child: WidgetForm(
                            controller: serial,
                            typeInput: TextInputType.number,
                            alert: '1234567',
                            hint: '1234567',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
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
                        title: const Text(
                          'Lokasi Awal',
                          style: TextStyle(color: Colors.black),
                        ),
                        subtitle: Container(
                          margin: EdgeInsets.only(top: height * 0.01),
                          child: WidgetForm(
                            controller: lokasi,
                            alert: 'Denpasar',
                            hint: 'Denpasar',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
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
            ),
      bottomNavigationBar: SizedBox(
        width: width,
        height: height * 0.06,
        child: Align(
          alignment: Alignment.topCenter,
          child: WidgetButtonCustom(
              FullWidth: width * 0.9,
              FullHeight: height * 0.05,
              title: 'Simpan & Print QR Code',
              onpressed: () async {
                print(owner);
                if (owner == 2) {
                  print("A : $selectSupllier");
                  print("B : $selectCustomer");
                } else {
                  print("A : $selectSupllier");
                  print("B : $selectCustomer");
                }

                if (nonGrade == false) {
                  setState(() {
                    selectedGradeIndex = null;
                  });
                } else if (isSingle == true) {
                  setState(() {
                    nonSingletubeType = null;
                  });
                }

                int intTahun = int.parse(tahun.text);
                int intGas = int.parse(selectTubeGas);
                // int intVendor = int.parse(selectSupllier);
                // int intCustomer = int.parse(selectCustomer);

                print(
                    "HASIL RESPONSE :\nowner_ship_type :$owner\nis_has_tube_type : $isSingle\ntube_type_id : $nonSingletubeType\ntube_gas_id : $intGas\nis_has_grade : $nonGrade\nvendor_id : $selectSupllier\ntube_year : $intTahun\nserial_number : ${serial.text}\ncustomer_id : $selectCustomer\nlast_location : ${lokasi.text}");

                providerS.newTubeClear();

                if (providerS.isNew == true) {
                  await provider.createNewTabung(
                      context,
                      widget.uuid!,
                      owner!,
                      isSingle,
                      nonSingletubeType,
                      intGas,
                      nonGrade,
                      selectedGradeIndex,
                      intTahun,
                      serial.text,
                      selectCustomer,
                      selectSupllier,
                      lokasi.text);
                } else {
                  await provider.createTabung(
                      context,
                      owner!,
                      isSingle,
                      nonSingletubeType,
                      intGas,
                      nonGrade,
                      selectedGradeIndex,
                      intTahun,
                      serial.text,
                      selectCustomer,
                      selectSupllier,
                      lokasi.text);
                }
              },
              bgColor: PRIMARY_COLOR,
              color: PRIMARY_COLOR),
        ),
      ),
    );
  }
}
