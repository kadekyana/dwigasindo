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

class ComponentUpdateTabung extends StatefulWidget {
  ComponentUpdateTabung({super.key, required this.code});
  String code;

  @override
  State<ComponentUpdateTabung> createState() => _ComponentUpdateTabungState();
}

class _ComponentUpdateTabungState extends State<ComponentUpdateTabung> {
  Timer? _timer;
  late TextEditingController tahun;
  late TextEditingController serial;
  late TextEditingController lokasi;

  late GroupButtonController jenisTabung;

  late GroupButtonController jenisTabungBool;

  late SingleSelectController<String?> customer;

  late SingleSelectController<String?> jenisGas;

  late SingleSelectController<String?> supllier;

  late GroupButtonController kepemilikan;

  late GroupButtonController gradeBool;

  late GroupButtonController grade;

  late int selectTubeGas;
  int? selectCustomer;
  int? selectSupllier;

  late int owner;
  int? nonSingletubeType;
  int? selectnonGrade;
  late bool nonGrade;
  int? selectedGradeIndex;

  late bool isSingle;

  List<String>? tubeGrade;
  List<String>? tubeType;
  List<Map<String, dynamic>>? tubeGas;
  List<Map<String, dynamic>>? tubecustomer;
  List<Map<String, dynamic>>? tubesupplier;

  String? _tahun;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final provider = Provider.of<ProviderDistribusi>(context, listen: false);

    // Provider.of<ProviderScan>(context, listen: false)
    //     .getDataCard(context, widget.code);

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

    final providerS = Provider.of<ProviderScan>(context, listen: false);
    providerS.getDataCard(context, widget.code);

    tahun =
        TextEditingController(text: providerS.card?.data?.tubeYear.toString());
    serial = TextEditingController(
        text: providerS.card?.data?.serialNumber.toString());
    lokasi = TextEditingController(text: providerS.card?.data?.lastLocation);

    kepemilikan = GroupButtonController(
        selectedIndex: providerS.card!.data!.ownerShipType! - 1);

    owner = (providerS.card!.data!.ownerShipType!);

    isSingle = providerS.card!.data!.isHasTubeType!;

    jenisTabung = GroupButtonController(
        selectedIndex: (providerS.card?.data?.tubeTypeId != null)
            ? providerS.card?.data?.tubeTypeId - 1
            : null);

    jenisTabungBool = GroupButtonController(
        selectedIndex: (providerS.card?.data?.isHasTubeType == false) ? 1 : 0);

    customer = SingleSelectController<String?>(
        (providerS.card?.data?.customerName == "")
            ? null
            : providerS.card?.data?.customerName);

    final data = tubeGas!
        .firstWhere((item) => item['id'] == providerS.card?.data?.tubeGasId);
    jenisGas = SingleSelectController<String?>(data['name']);
    selectTubeGas = int.parse(data['id'].toString());

    supllier = SingleSelectController<String?>(
        (providerS.card?.data?.vendorName == "")
            ? null
            : providerS.card?.data?.vendorName);

    gradeBool = GroupButtonController(
        selectedIndex: (providerS.card!.data!.isHasGrade == true) ? 0 : 1);

    nonGrade = providerS.card!.data!.isHasGrade!;

    grade = GroupButtonController(
        selectedIndex: (providerS.card?.data?.tubeGradeId != null)
            ? providerS.card?.data?.tubeGradeId - 1
            : null);

    provider.isLoadingT = false;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<ProviderDistribusi>(context);
    final providerS = Provider.of<ProviderScan>(context);

    print("DATA TUBE : ${providerS.card?.data} Cek : ${widget.code}");
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: WidgetAppbar(
        title: 'Edit Tabung',
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
                              controller: kepemilikan,
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
                      height: height * 0.025,
                    ),
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
                              controller: jenisTabungBool,
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
                                  controller: jenisTabung,
                                  options: GroupButtonOptions(
                                      selectedColor: PRIMARY_COLOR,
                                      borderRadius: BorderRadius.circular(8),
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
                              selectTubeGas = selectedC['id'];
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
                              controller: gradeBool,
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
                            controller: grade,
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

                // if (nonGrade == false) {
                //   setState(() {
                //     selectedGradeIndex = null;
                //   });
                // } else if (isSingle == true) {
                //   setState(() {
                //     nonSingletubeType = null;
                //   });
                // }

                // int intTahun = int.parse(tahun.text);
                // int intGas = int.parse(selectTubeGas);
                // int intVendor = int.parse(selectSupllier);
                // int intCustomer = int.parse(selectCustomer);
                print("--------------------------");
                print(
                    "HASIL RESPONSE :\nowner_ship_type :$owner\nis_has_tube_type : $isSingle\ntube_type_id : ${jenisTabung.selectedIndex}\ntube_gas_id : ${jenisGas.value}\nis_has_grade : ${(gradeBool.selectedIndex == 0) ? true : false}\nvendor_id : $selectSupllier\ntube_year : ${tahun.text}\nserial_number : ${serial.text}\ncustomer_id : ${customer.value}\nlast_location : ${lokasi.text}");
                // print(
                //     "HASIL RESPONSE :\nowner_ship_type :$owner\nis_has_tube_type : $isSingle\ntube_type_id : $nonSingletubeType\ntube_gas_id : ${intGas}\nis_has_grade : $nonGrade\nvendor_id : $selectSupllier\ntube_year : ${intTahun}\nserial_number : ${serial.text}\ncustomer_id : ${selectCustomer}\nlast_location : ${lokasi.text}");

                await provider.updateTabung(
                    context,
                    widget.code,
                    owner,
                    isSingle,
                    nonSingletubeType,
                    selectTubeGas,
                    nonGrade,
                    selectedGradeIndex,
                    int.parse(tahun.text),
                    serial.text,
                    selectCustomer,
                    selectSupllier,
                    lokasi.text);
              },
              bgColor: PRIMARY_COLOR,
              color: PRIMARY_COLOR),
        ),
      ),
    );
  }
}
