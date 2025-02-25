import 'dart:async';
import 'dart:developer';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:dwigasindo/providers/provider_printer.dart';
import 'package:dwigasindo/providers/provider_scan.dart';
import 'package:dwigasindo/widgets/widget_appbar.dart';
import 'package:dwigasindo/widgets/widget_dropdown.dart';
import 'package:dwigasindo/widgets/widget_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_thermal_printer/flutter_thermal_printer.dart';
import 'package:flutter_thermal_printer/utils/printer.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';

class ComponentTambahTabung extends StatefulWidget {
  ComponentTambahTabung({super.key, this.uuid});
  String? uuid;
  @override
  State<ComponentTambahTabung> createState() => _ComponentTambahTabungState();
}

class _ComponentTambahTabungState extends State<ComponentTambahTabung> {
  final _flutterThermalPrinterPlugin = FlutterThermalPrinter.instance;
  List<Printer> printers = [];
  Printer? dataP;
  StreamSubscription<List<Printer>>? _devicesStreamSubscription;

  void startScan() async {
    log("Starting printer scan...");
    _devicesStreamSubscription?.cancel();
    await _flutterThermalPrinterPlugin.getPrinters(connectionTypes: [
      ConnectionType.BLE,
      ConnectionType.USB,
    ]);
    _devicesStreamSubscription = _flutterThermalPrinterPlugin.devicesStream
        .listen((List<Printer> event) {
      log("Printers found: ${event.map((e) => e.name).toList()}");
      setState(() {
        printers =
            event.where((e) => e.name != null && e.name!.isNotEmpty).toList();
      });
    });
  }

  stopScan() {
    log("Stopping printer scan...");
    _flutterThermalPrinterPlugin.stopScan();
  }

  Timer? _timer;
  TextEditingController tahun = TextEditingController();
  TextEditingController serial = TextEditingController();
  TextEditingController lokasi = TextEditingController();
  TextEditingController blast = TextEditingController();

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
  bool? isBlast;

  List<String>? tubeGrade;
  List<String>? tubeType;
  List<Map<String, dynamic>>? tubeGas;
  List<Map<String, dynamic>>? tubecustomer;
  List<Map<String, dynamic>>? tubesupplier;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startScan();
    });
    final provider = Provider.of<ProviderDistribusi>(context, listen: false);

    // Ambil data dan cek apakah tidak null
    tubeGrade = provider.tubeGrades?.data.map((data) => data.name).toList();
    tubeType = provider.tubeTypes?.data.map((data) => data.name).toList();

    tubeGas = provider.tubeGas?.data
        .map((data) => {'id': data.id, 'name': data.name})
        .toList();

    tubecustomer = provider.customer!.data!
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
    final providerPrinter = Provider.of<ProviderPrinter>(context);
    return Scaffold(
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
          ? Center(
              child: Container(
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
                    Container(
                      width: width,
                      height: height * 0.1,
                      child: ListTile(
                        title: Text(
                          'Jenis Tambah',
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
                                  if (index == 0) {
                                    isBlast = true;
                                  } else {
                                    isBlast = false;
                                  }
                                });
                              },
                              buttons: ['Blast', "Satuan"]),
                        ),
                      ),
                    ),
                    if (isBlast == true)
                      Container(
                        width: width,
                        height: 100.h,
                        child: ListTile(
                          title: Text(
                            'Total Blast',
                            style: subtitleTextBlack,
                          ),
                          subtitle: Container(
                            margin: EdgeInsets.only(top: height * 0.01),
                            child: WidgetForm(
                              controller: blast,
                              alert: 'Contoh : 20',
                              hint: 'Contoh : 20',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                      ),
                    Container(
                      width: width,
                      height: height * 0.1,
                      child: ListTile(
                        title: Text(
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
                                        ?.map((data) =>
                                            {'id': data.id, 'name': data.name})
                                        .toList();
                                    selectCustomer = null;
                                    supllier.value = null;
                                    customer.value = null;
                                    print(tubecustomer);
                                    print(tubesupplier);
                                  } else {
                                    // Pilihan Pelanggan, set data customer
                                    tubecustomer = provider.customer!.data!
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
                              buttons: ['Assets', "Pelanggan"]),
                        ),
                      ),
                    ),
                    (owner == 1)
                        ? Container(
                            width: width,
                            height: height * 0.1,
                            child: ListTile(
                              title: Text(
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
                        : SizedBox.shrink(),
                    (owner == 2)
                        ? Container(
                            width: width,
                            height: height * 0.1,
                            child: ListTile(
                              title: Text(
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
                        : SizedBox.shrink(),
                    Container(
                      width: width,
                      height: height * 0.1,
                      child: ListTile(
                        title: Text(
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
                              buttons: ['Single', "Non Single"]),
                        ),
                      ),
                    ),
                    (!isSingle)
                        ? Container(
                            width: width,
                            height: height * 0.1,
                            child: ListTile(
                              title: Text(
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
                                      // Disable tombol jika "Tidak" dipilih pada "Non Grade"
                                      unselectedColor: Colors.white,
                                      selectedTextStyle: subtitleText),
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
                        : SizedBox(),
                    Container(
                      width: width,
                      height: height * 0.1,
                      child: ListTile(
                        title: Text(
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
                    Container(
                      width: width,
                      height: height * 0.1,
                      child: ListTile(
                        title: Text(
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
                              buttons: ['Ya', "Tidak"]),
                        ),
                      ),
                    ),
                    Container(
                      width: width,
                      height: height * 0.1,
                      child: ListTile(
                        title: Text(
                          'Grade*',
                          style: subtitleTextBlack,
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
                    Container(
                      width: width,
                      height: height * 0.1,
                      child: ListTile(
                        title: Text(
                          'Tahun Tabung',
                          style: subtitleTextBlack,
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
                    Container(
                      width: width,
                      height: height * 0.1,
                      child: ListTile(
                        title: Text(
                          'Serial Number',
                          style: subtitleTextBlack,
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
                    Container(
                      width: width,
                      height: height * 0.1,
                      child: ListTile(
                        title: Text(
                          'Lokasi Awal',
                          style: subtitleTextBlack,
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
                    ElevatedButton(
                      onPressed: startScan,
                      child: const Text('Scan Printers'),
                    ),
                    Container(
                      width: width,
                      height: 200.h,
                      child: ListView.builder(
                        itemCount: printers.length,
                        itemBuilder: (context, index) {
                          final printer = printers[index];
                          return ListTile(
                            title: Text(printer.name ?? 'No Name'),
                            subtitle: Text(
                                "Connected: ${printer.isConnected ?? false}"),
                            trailing: IconButton(
                              icon: const Icon(Icons.print),
                              onPressed: () async {
                                if (printer.isConnected ?? false) {
                                  if (owner == 2) {
                                    print("A : ${selectSupllier}");
                                    print("B : ${selectCustomer}");
                                  } else {
                                    print("A : ${selectSupllier}");
                                    print("B : ${selectCustomer}");
                                  }

                                  // Atur nilai null sesuai kondisi
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

                                  // Proses pembuatan tabung dan print
                                  if (isBlast == true) {
                                    for (int i = 0;
                                        i < int.parse(blast.text);
                                        i++) {
                                      final dataHasil =
                                          await provider.createTabung(
                                        context,
                                        owner!,
                                        printer,
                                        isSingle,
                                        nonSingletubeType,
                                        intGas,
                                        nonGrade,
                                        selectedGradeIndex,
                                        intTahun,
                                        serial.text,
                                        selectCustomer,
                                        selectSupllier,
                                        lokasi.text,
                                      );
                                      // Panggil print ZPL setelah data tabung berhasil dibuat
                                      // await provider.printZPL(
                                      //     printer,
                                      //     dataHasil['data']['tube_gas_name'],
                                      //     dataHasil['data']['code']);
                                    }
                                    provider.getAllTube(context);
                                    Navigator.pop(context);
                                    provider.countTube();
                                  } else {
                                    final dataHasil =
                                        await provider.createTabung(
                                      context,
                                      owner!,
                                      printer,
                                      isSingle,
                                      nonSingletubeType,
                                      intGas,
                                      nonGrade,
                                      selectedGradeIndex,
                                      intTahun,
                                      serial.text,
                                      selectCustomer,
                                      selectSupllier,
                                      lokasi.text,
                                    );
                                    // Panggil print ZPL setelah data tabung berhasil dibuat
                                    // await provider.printZPL(
                                    //     printer,
                                    //     dataHasil['data']['tube_gas_name'],
                                    //     dataHasil['data']['code']);
                                    await provider.getAllTube(context);
                                    Navigator.pop(context);
                                    await provider.countTube();
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "Printer ${printer.name ?? 'Unknown'} is not connected."),
                                    ),
                                  );
                                }
                              },
                            ),
                            onTap: () async {
                              if (printer.isConnected ?? false) {
                                await _flutterThermalPrinterPlugin
                                    .disconnect(printer);
                                setState(() {});
                              } else {
                                bool connected =
                                    await _flutterThermalPrinterPlugin
                                        .connect(printer);
                                if (connected) {
                                  setState(() {});
                                }
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
// backup printer
// import 'dart:async';
// import 'dart:developer';
// import 'package:animated_custom_dropdown/custom_dropdown.dart';
// import 'package:dwigasindo/const/const_color.dart';
// import 'package:dwigasindo/const/const_font.dart';
// import 'package:dwigasindo/providers/provider_distribusi.dart';
// import 'package:dwigasindo/providers/provider_printer.dart';
// import 'package:dwigasindo/providers/provider_scan.dart';
// import 'package:dwigasindo/widgets/widget_appbar.dart';
// import 'package:dwigasindo/widgets/widget_button_custom.dart';
// import 'package:dwigasindo/widgets/widget_dropdown.dart';
// import 'package:dwigasindo/widgets/widget_form.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_thermal_printer/flutter_thermal_printer.dart';
// import 'package:flutter_thermal_printer/utils/printer.dart';
// import 'package:group_button/group_button.dart';
// import 'package:provider/provider.dart';

// class ComponentTambahTabung extends StatefulWidget {
//   ComponentTambahTabung({super.key, this.uuid});
//   String? uuid;
//   @override
//   State<ComponentTambahTabung> createState() => _ComponentTambahTabungState();
// }

// class _ComponentTambahTabungState extends State<ComponentTambahTabung> {
//   final _flutterThermalPrinterPlugin = FlutterThermalPrinter.instance;
//   List<Printer> printers = [];
//   Printer? dataP;
//   StreamSubscription<List<Printer>>? _devicesStreamSubscription;

//   void startScan() async {
//     log("Starting printer scan...");
//     _devicesStreamSubscription?.cancel();
//     await _flutterThermalPrinterPlugin.getPrinters(connectionTypes: [
//       ConnectionType.BLE,
//       ConnectionType.USB,
//     ]);
//     _devicesStreamSubscription = _flutterThermalPrinterPlugin.devicesStream
//         .listen((List<Printer> event) {
//       log("Printers found: ${event.map((e) => e.name).toList()}");
//       setState(() {
//         printers =
//             event.where((e) => e.name != null && e.name!.isNotEmpty).toList();
//       });
//     });
//   }

//   stopScan() {
//     log("Stopping printer scan...");
//     _flutterThermalPrinterPlugin.stopScan();
//   }

//   Timer? _timer;
//   TextEditingController tahun = TextEditingController();
//   TextEditingController serial = TextEditingController();
//   TextEditingController lokasi = TextEditingController();
//   TextEditingController blast = TextEditingController();

//   SingleSelectController<String?> jenisTabung =
//       SingleSelectController<String?>(null);

//   SingleSelectController<String?> customer =
//       SingleSelectController<String?>(null);

//   SingleSelectController<String?> jenisGas =
//       SingleSelectController<String?>(null);

//   SingleSelectController<String?> supllier =
//       SingleSelectController<String?>(null);

//   String selectTubeGas = '';
//   int? selectCustomer;
//   int? selectSupllier;

//   int? owner = 0;
//   int? nonSingletubeType;
//   int? selectnonGrade;
//   bool nonGrade = true;
//   int? selectedGradeIndex;

//   bool isSingle = false;
//   bool? isBlast;

//   List<String>? tubeGrade;
//   List<String>? tubeType;
//   List<Map<String, dynamic>>? tubeGas;
//   List<Map<String, dynamic>>? tubecustomer;
//   List<Map<String, dynamic>>? tubesupplier;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       startScan();
//     });
//     final provider = Provider.of<ProviderDistribusi>(context, listen: false);

//     // Ambil data dan cek apakah tidak null
//     tubeGrade = provider.tubeGrades?.data.map((data) => data.name).toList();
//     tubeType = provider.tubeTypes?.data.map((data) => data.name).toList();

//     tubeGas = provider.tubeGas?.data
//         .map((data) => {'id': data.id, 'name': data.name})
//         .toList();

//     tubecustomer = provider.customer!.data!
//         .map((data) => {'id': data.id, 'name': data.name})
//         .toList();

//     tubesupplier = provider.supllier?.data
//         .map((data) => {'id': data.id, 'name': data.name})
//         .toList();

//     // Cek data supplier dan customer
//     print("Supllier data: ${provider.supllier?.data}");
//     print("Customer data: ${provider.customer?.data}");
//   }

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//     final provider = Provider.of<ProviderDistribusi>(context);
//     final providerS = Provider.of<ProviderScan>(context);
//     final providerPrinter = Provider.of<ProviderPrinter>(context);
//     return Scaffold(
//       appBar: WidgetAppbar(
//         title: 'Tambah Tabung',
//         back: true,
//         center: true,
//         colorBG: Colors.grey.shade100,
//         colorBack: Colors.black,
//         colorTitle: Colors.black,
//         route: () {
//           Navigator.pop(context);
//         },
//       ),
//       body: (provider.isLoadingT == true)
//           ? Center(
//               child: Container(
//                 width: 50,
//                 height: 50,
//                 child: CircularProgressIndicator(),
//               ),
//             )
//           : SingleChildScrollView(
//               child: SafeArea(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Container(
//                       width: width,
//                       height: height * 0.1,
//                       child: ListTile(
//                         title: Text(
//                           'Jenis Tambah',
//                           style: subtitleTextBlack,
//                         ),
//                         subtitle: Align(
//                           alignment: Alignment.topLeft,
//                           child: GroupButton(
//                               isRadio: true,
//                               options: GroupButtonOptions(
//                                 selectedColor: PRIMARY_COLOR,
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               onSelected: (value, index, isSelected) {
//                                 setState(() {
//                                   if (index == 0) {
//                                     isBlast = true;
//                                   } else {
//                                     isBlast = false;
//                                   }
//                                 });
//                               },
//                               buttons: ['Blast', "Satuan"]),
//                         ),
//                       ),
//                     ),
//                     if (isBlast == true)
//                       Container(
//                         width: width,
//                         height: 100.h,
//                         child: ListTile(
//                           title: Text(
//                             'Total Blast',
//                             style: subtitleTextBlack,
//                           ),
//                           subtitle: Container(
//                             margin: EdgeInsets.only(top: height * 0.01),
//                             child: WidgetForm(
//                               controller: blast,
//                               alert: 'Contoh : 20',
//                               hint: 'Contoh : 20',
//                               border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12)),
//                             ),
//                           ),
//                         ),
//                       ),
//                     Container(
//                       width: width,
//                       height: height * 0.1,
//                       child: ListTile(
//                         title: Text(
//                           'Kepemilikan*',
//                           style: subtitleTextBlack,
//                         ),
//                         subtitle: Align(
//                           alignment: Alignment.topLeft,
//                           child: GroupButton(
//                               isRadio: true,
//                               options: GroupButtonOptions(
//                                 selectedColor: PRIMARY_COLOR,
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               onSelected: (value, index, isSelected) {
//                                 setState(() {
//                                   owner = index + 1;
//                                   if (index == 0) {
//                                     // Pilihan Assets, set data supplier
//                                     tubesupplier = provider.supllier?.data
//                                         ?.map((data) =>
//                                             {'id': data.id, 'name': data.name})
//                                         .toList();
//                                     selectCustomer = null;
//                                     supllier.value = null;
//                                     customer.value = null;
//                                     print(tubecustomer);
//                                     print(tubesupplier);
//                                   } else {
//                                     // Pilihan Pelanggan, set data customer
//                                     tubecustomer = provider.customer!.data!
//                                         .map((data) =>
//                                             {'id': data.id, 'name': data.name})
//                                         .toList();
//                                     selectSupllier = null;
//                                     supllier.value = null;
//                                     customer.value = null;
//                                     print(tubecustomer);
//                                     print(tubesupplier);
//                                   }
//                                   print(
//                                       'DATA KLIK : $value - $index - $isSelected');
//                                 });
//                               },
//                               buttons: ['Assets', "Pelanggan"]),
//                         ),
//                       ),
//                     ),
//                     (owner == 1)
//                         ? Container(
//                             width: width,
//                             height: height * 0.1,
//                             child: ListTile(
//                               title: Text(
//                                 'Supplier',
//                                 style: subtitleTextBlack,
//                               ),
//                               subtitle: WidgetDropdown(
//                                 items: tubesupplier != null
//                                     ? tubesupplier!
//                                         .map((item) => item['name'].toString())
//                                         .toList()
//                                     : [],
//                                 hintText: 'Tipe',
//                                 controller: supllier,
//                                 onChanged: (value) {
//                                   if (tubesupplier != null) {
//                                     final selecttubeC = tubesupplier!
//                                         .firstWhere(
//                                             (item) => item['name'] == value);
//                                     print("ID VENDOR : ${selecttubeC['id']}");
//                                     setState(() {
//                                       selectSupllier = selecttubeC['id'];
//                                     });
//                                   }
//                                 },
//                               ),
//                             ),
//                           )
//                         : SizedBox.shrink(),
//                     (owner == 2)
//                         ? Container(
//                             width: width,
//                             height: height * 0.1,
//                             child: ListTile(
//                               title: Text(
//                                 'Customer',
//                                 style: subtitleTextBlack,
//                               ),
//                               subtitle: WidgetDropdown(
//                                 items: tubecustomer != null
//                                     ? tubecustomer!
//                                         .map((item) => item['name'].toString())
//                                         .toList()
//                                     : [],
//                                 hintText: 'Tipe',
//                                 controller: customer,
//                                 onChanged: (value) {
//                                   if (tubecustomer != null) {
//                                     final selecttubeC = tubecustomer!
//                                         .firstWhere(
//                                             (item) => item['name'] == value);
//                                     print("ID CUSTOMER : ${selecttubeC['id']}");
//                                     setState(() {
//                                       selectCustomer = selecttubeC['id'];
//                                     });
//                                   }
//                                 },
//                               ),
//                             ),
//                           )
//                         : SizedBox.shrink(),
//                     Container(
//                       width: width,
//                       height: height * 0.1,
//                       child: ListTile(
//                         title: Text(
//                           'Jenis Tabung*',
//                           style: subtitleTextBlack,
//                         ),
//                         subtitle: Align(
//                           alignment: Alignment.topLeft,
//                           child: GroupButton(
//                               isRadio: true,
//                               options: GroupButtonOptions(
//                                 selectedColor: PRIMARY_COLOR,
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               onSelected: (value, index, isSelected) {
//                                 if (value == 'Non Single') {
//                                   setState(() {
//                                     isSingle = false;
//                                   });
//                                 } else {
//                                   setState(() {
//                                     isSingle = true;
//                                   });
//                                 }
//                                 print(
//                                     'DATA KLIK : $value - $index - $isSelected');
//                               },
//                               buttons: ['Single', "Non Single"]),
//                         ),
//                       ),
//                     ),
//                     (!isSingle)
//                         ? Container(
//                             width: width,
//                             height: height * 0.1,
//                             child: ListTile(
//                               title: Text(
//                                 'Jenis Tabung*',
//                                 style: subtitleTextBlack,
//                               ),
//                               subtitle: Align(
//                                 alignment: Alignment.topLeft,
//                                 child: GroupButton(
//                                   isRadio: true,
//                                   options: GroupButtonOptions(
//                                       selectedColor: PRIMARY_COLOR,
//                                       borderRadius: BorderRadius.circular(8),
//                                       // Disable tombol jika "Tidak" dipilih pada "Non Grade"
//                                       unselectedColor: Colors.white,
//                                       selectedTextStyle: subtitleText),
//                                   onSelected: (value, index, isSelected) {
//                                     setState(() {
//                                       nonSingletubeType = index + 1;
//                                     });
//                                     print(
//                                         'Grade Selected: $value - ${index + 1} - $isSelected');
//                                   },
//                                   buttons: tubeType!,
//                                 ),
//                               ),
//                             ),
//                           )
//                         : SizedBox(),
//                     Container(
//                       width: width,
//                       height: height * 0.1,
//                       child: ListTile(
//                         title: Text(
//                           'Jenis Gas*',
//                           style: subtitleTextBlack,
//                         ),
//                         subtitle: WidgetDropdown(
//                           items: tubeGas!
//                               .map((item) => item['name'].toString())
//                               .toList(),
//                           hintText: 'Tipe',
//                           controller: jenisGas,
//                           onChanged: (value) {
//                             final selectedC = tubeGas!
//                                 .firstWhere((item) => item['name'] == value);
//                             setState(() {
//                               selectTubeGas = selectedC['id'].toString();
//                             });
//                           },
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: height * 0.02,
//                     ),
//                     Container(
//                       width: width,
//                       height: height * 0.1,
//                       child: ListTile(
//                         title: Text(
//                           'Non Grade*',
//                           style: subtitleTextBlack,
//                         ),
//                         subtitle: Align(
//                           alignment: Alignment.topLeft,
//                           child: GroupButton(
//                               isRadio: true,
//                               options: GroupButtonOptions(
//                                 selectedColor: PRIMARY_COLOR,
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               onSelected: (value, index, isSelected) {
//                                 if (value == 'Tidak') {
//                                   setState(() {
//                                     nonGrade = false;
//                                   });
//                                 } else {
//                                   setState(() {
//                                     nonGrade = true;
//                                   });
//                                 }
//                                 print(
//                                     'DATA KLIK : $value - $index - $isSelected');
//                               },
//                               buttons: ['Ya', "Tidak"]),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       width: width,
//                       height: height * 0.1,
//                       child: ListTile(
//                         title: Text(
//                           'Grade*',
//                           style: subtitleTextBlack,
//                         ),
//                         subtitle: Align(
//                           alignment: Alignment.topLeft,
//                           child: GroupButton(
//                             isRadio: true,
//                             options: GroupButtonOptions(
//                                 selectedColor:
//                                     !nonGrade ? Colors.grey : PRIMARY_COLOR,
//                                 borderRadius: BorderRadius.circular(8),
//                                 // Disable tombol jika "Tidak" dipilih pada "Non Grade"
//                                 unselectedColor:
//                                     !nonGrade ? Colors.grey : Colors.white,
//                                 selectedTextStyle: TextStyle(
//                                     color: !nonGrade
//                                         ? Colors.black
//                                         : Colors.white)),
//                             onSelected: !nonGrade
//                                 ? null
//                                 : (value, index, isSelected) {
//                                     setState(() {
//                                       selectedGradeIndex = index + 1;
//                                     });
//                                     print(
//                                         'Grade Selected: $value - ${index + 1} - $isSelected');
//                                   },
//                             buttons: tubeGrade!,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       width: width,
//                       height: height * 0.1,
//                       child: ListTile(
//                         title: Text(
//                           'Tahun Tabung',
//                           style: subtitleTextBlack,
//                         ),
//                         subtitle: Container(
//                           margin: EdgeInsets.only(top: height * 0.01),
//                           child: WidgetForm(
//                             controller: tahun,
//                             alert: '2024',
//                             hint: '2024',
//                             border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12)),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: height * 0.03,
//                     ),
//                     Container(
//                       width: width,
//                       height: height * 0.1,
//                       child: ListTile(
//                         title: Text(
//                           'Serial Number',
//                           style: subtitleTextBlack,
//                         ),
//                         subtitle: Container(
//                           margin: EdgeInsets.only(top: height * 0.01),
//                           child: WidgetForm(
//                             controller: serial,
//                             typeInput: TextInputType.number,
//                             alert: '1234567',
//                             hint: '1234567',
//                             border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12)),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: height * 0.02,
//                     ),
//                     Container(
//                       width: width,
//                       height: height * 0.1,
//                       child: ListTile(
//                         title: Text(
//                           'Lokasi Awal',
//                           style: subtitleTextBlack,
//                         ),
//                         subtitle: Container(
//                           margin: EdgeInsets.only(top: height * 0.01),
//                           child: WidgetForm(
//                             controller: lokasi,
//                             alert: 'Denpasar',
//                             hint: 'Denpasar',
//                             border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12)),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: height * 0.05,
//                     ),
//                     ElevatedButton(
//                       onPressed: startScan,
//                       child: const Text('Scan Printers'),
//                     ),
//                     Container(
//                       width: width,
//                       height: 200.h,
//                       child: ListView.builder(
//                         itemCount: printers.length,
//                         itemBuilder: (context, index) {
//                           final printer = printers[index];
//                           return ListTile(
//                             title: Text(printer.name ?? 'No Name'),
//                             subtitle: Text(
//                                 "Connected: ${printer.isConnected ?? false}"),
//                             trailing: IconButton(
//                               icon: const Icon(Icons.print),
//                               onPressed: () async {
//                                 if (printer.isConnected ?? false) {
//                                   if (owner == 2) {
//                                     print("A : ${selectSupllier}");
//                                     print("B : ${selectCustomer}");
//                                   } else {
//                                     print("A : ${selectSupllier}");
//                                     print("B : ${selectCustomer}");
//                                   }

//                                   // Atur nilai null sesuai kondisi
//                                   if (nonGrade == false) {
//                                     setState(() {
//                                       selectedGradeIndex = null;
//                                     });
//                                   } else if (isSingle == true) {
//                                     setState(() {
//                                       nonSingletubeType = null;
//                                     });
//                                   }

//                                   int intTahun = int.parse(tahun.text);
//                                   int intGas = int.parse(selectTubeGas);

//                                   // Proses pembuatan tabung dan print
//                                   if (isBlast == true) {
//                                     for (int i = 0;
//                                         i < int.parse(blast.text);
//                                         i++) {
//                                       final dataHasil =
//                                           await provider.createTabung(
//                                         context,
//                                         owner!,
//                                         printer,
//                                         isSingle,
//                                         nonSingletubeType,
//                                         intGas,
//                                         nonGrade,
//                                         selectedGradeIndex,
//                                         intTahun,
//                                         serial.text,
//                                         selectCustomer,
//                                         selectSupllier,
//                                         lokasi.text,
//                                       );
//                                       // Panggil print ZPL setelah data tabung berhasil dibuat
//                                       // await provider.printZPL(
//                                       //     printer,
//                                       //     dataHasil['data']['tube_gas_name'],
//                                       //     dataHasil['data']['code']);
//                                     }
//                                     provider.getAllTube(context);
//                                     Navigator.pop(context);
//                                     provider.countTube();
//                                   } else {
//                                     final dataHasil =
//                                         await provider.createTabung(
//                                       context,
//                                       owner!,
//                                       printer,
//                                       isSingle,
//                                       nonSingletubeType,
//                                       intGas,
//                                       nonGrade,
//                                       selectedGradeIndex,
//                                       intTahun,
//                                       serial.text,
//                                       selectCustomer,
//                                       selectSupllier,
//                                       lokasi.text,
//                                     );
//                                     // Panggil print ZPL setelah data tabung berhasil dibuat
//                                     // await provider.printZPL(
//                                     //     printer,
//                                     //     dataHasil['data']['tube_gas_name'],
//                                     //     dataHasil['data']['code']);
//                                     await provider.getAllTube(context);
//                                     Navigator.pop(context);
//                                     await provider.countTube();
//                                   }
//                                 } else {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                       content: Text(
//                                           "Printer ${printer.name ?? 'Unknown'} is not connected."),
//                                     ),
//                                   );
//                                 }
//                               },
//                             ),
//                             onTap: () async {
//                               if (printer.isConnected ?? false) {
//                                 await _flutterThermalPrinterPlugin
//                                     .disconnect(printer);
//                                 setState(() {});
//                               } else {
//                                 bool connected =
//                                     await _flutterThermalPrinterPlugin
//                                         .connect(printer);
//                                 if (connected) {
//                                   setState(() {});
//                                 }
//                               }
//                             },
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// }
