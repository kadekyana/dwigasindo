import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dio/dio.dart';
import 'package:dwigasindo/const/const_api.dart';
import 'package:dwigasindo/model/modelAllBPTI.dart';
import 'package:dwigasindo/model/modelAllBPTK.dart';
import 'package:dwigasindo/model/modelAllCostumer.dart';
import 'package:dwigasindo/model/modelAllTubeGas.dart';
import 'package:dwigasindo/model/modelAllTubeGrade.dart';
import 'package:dwigasindo/model/modelAllTubeType.dart';
import 'package:dwigasindo/model/modelAllVendor.dart';
import 'package:dwigasindo/model/modelCradle.dart';
import 'package:dwigasindo/model/modelOneBPTK.dart';
import 'package:dwigasindo/model/modelSupplier.dart';
import 'package:dwigasindo/model/modelTube.dart';
import 'package:dwigasindo/model/modelVerifikasiBPTK.dart';
import 'package:dwigasindo/providers/provider_auth.dart';
import 'package:dwigasindo/views/menus/component_distribusi/componentBPTK/component_bpti.dart';
import 'package:dwigasindo/views/menus/component_distribusi/componentBPTK/component_bptk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_thermal_printer/flutter_thermal_printer.dart';
import 'package:flutter_thermal_printer/utils/printer.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ProviderDistribusi extends ChangeNotifier {
  // controller tambah BPTK
  final dio = Dio();
  bool isLoading = false;
  bool isLoadingC = false;
  bool isLoadingD = false;
  bool isLoadingT = false;
  bool isLoadingTube = false;
  bool isLoadingVer = false;
  bool isLoadingTI = false;

  int count = 0;
  int countT = 0;
  int maxcount = 1;
  int tabungP = 0;
  int tabungA = 0;

  // bptk
  ModelAllBptk? _bptk;
  ModelAllBptk? get bptk => _bptk;

  ModelOneBptk? _oneBptk;
  ModelOneBptk? get oneBptk => _oneBptk;

  // customer
  ModelAllCostumer? _customer;
  ModelAllCostumer? get customer => _customer;

  // tube grade
  ModelAllTubeGrades? _tubeGrades;
  ModelAllTubeGrades? get tubeGrades => _tubeGrades;

  // tube type
  ModelAllTubeType? _tubeTypes;
  ModelAllTubeType? get tubeTypes => _tubeTypes;

  // tube gas
  ModelAllTubeGas? _tubeGas;
  ModelAllTubeGas? get tubeGas => _tubeGas;

  // tube
  ModelTube? _tube;
  ModelTube? get tube => _tube;

  // verifikasi BPTK
  ModelVerifikasiBptk? _verifikasiBptk;
  ModelVerifikasiBptk? get verifikasiBptk => _verifikasiBptk;

  // BPTI
  ModelAllBpti? _allBpti;
  ModelAllBpti? get allBpti => _allBpti;

  // Supplier
  ModelSupplier? _supplier;
  ModelSupplier? get supllier => _supplier;

  // Cradle
  ModelCradle? _cradle;
  ModelCradle? get cradle => _cradle;

  ModelAllVendor? _vendors;
  ModelAllVendor? get vendors => _vendors;

  Future<void> getDataVendor(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response =
        await DioServiceAPI().getRequest(url: "vendors", token: token);

    print(response?.data);
    if (response?.data['error'] == null) {
      final data = ModelAllVendor.fromJson(response!.data);
      _vendors = data;
      notifyListeners();
    }
  }

  Future<void> createVendor(BuildContext context, String nama, String alamat,
      int category, int type, int city) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response =
        await DioServiceAPI().postRequest(url: "vendors", token: token, data: {
      "name": "Supplier PT ABD",
      "address": "BDO",
      "vendor_category_id": 1,
      "type": 0,
      "city_id": 1

      // PIC, no telp
    });

    print(response?.data);
    if (response?.data['error'] == null) {
      final data = ModelAllVendor.fromJson(response!.data);
      _vendors = data;
      notifyListeners();
    }
  }

  //clear data
  Future<void> clearVerifikaisBPTK() async {
    _verifikasiBptk = null;
    notifyListeners();
  }

  // clear loading
  Future<void> clearCount(String type) async {
    if (type == 'count') {
      count = 0;
      notifyListeners();
    } else {
      countT = 0;
      notifyListeners();
    }
  }

  String getGasName(int? tubeGasId) {
    final gas = tubeGas!.data.firstWhere(
      (gas) => gas.id == tubeGasId,
      orElse: () {
        return tubeGas?.error;
      },
    );
    return gas.name;
  }

  String? getGrade(int tubeGrade) {
    final grade = tubeGrades?.data.firstWhere(
      (grade) => grade.id == tubeGrade,
      orElse: () {
        return tubeGrades?.error;
      },
    );
    return grade?.name;
  }

  String formatTime(String? dateTimeString) {
    // Parse string menjadi DateTime
    DateTime dateTime = DateTime.parse(dateTimeString!);

    // Format waktu sesuai kebutuhan, hanya menampilkan jam, menit, dan detik
    String formattedTime = DateFormat('HH:mm:ss').format(dateTime);

    return formattedTime;
  }

  String? getOwner(int owner) {
    String data;
    if (owner == 1) {
      data = 'Asset';
      notifyListeners();
      return data;
    } else if (owner == 2) {
      data = 'Pelanggan';
      notifyListeners();
      return data;
    } else {
      data = "-";
      notifyListeners();
      return data;
    }
  }

  String? getProduct(bool product) {
    String data;
    if (product == true) {
      data = 'Client';
      notifyListeners();
      return data;
    } else if (product == false) {
      data = 'Massal';
      notifyListeners();
      return data;
    }
    return null;
  }

  Future<void> createBPTK(String id, String no, BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    isLoading = true;
    notifyListeners();
    final data = int.parse(id);

    final response = await DioServiceAPI().postRequest(
        url: 'bptks',
        token: token,
        data: {"customer_id": data, "vehicle_number": no});

    if (response?.data['error'] == null) {
      Navigator.pop(context);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ComponentBPTK(),
        ),
      );

      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.success(
          message: 'Buat BPTK Berhasil',
        ),
      );
    } else {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: 'Buat BPTK GagalSilahkan Coba Kembali',
        ),
      );
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> editBptk(
      String id, String no, String uuid, BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    isLoading = true;
    notifyListeners();
    final data = int.parse(id);

    final response = await DioServiceAPI().putRequest(
        url: 'bptks/$uuid',
        token: token,
        data: {"customer_id": data, "vehicle_number": no});

    if (response?.data['error'] == null) {
      Navigator.pop(context);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ComponentBPTK(),
        ),
      );

      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.success(
          message: 'Buat BPTK Berhasil',
        ),
      );
    } else {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: 'Buat BPTK GagalSilahkan Coba Kembali',
        ),
      );
      isLoading = false;
      notifyListeners();
    }
  }

  String formatDate(String? dateTimeString) {
    // Ubah string ke DateTime
    DateTime dateTime = DateTime.parse(dateTimeString!);

    // Format DateTime menjadi dd-MM-yyyy
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);

    return formattedDate;
  }

  Future<void> getAllBPTK(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    isLoading = true;
    notifyListeners();

    final response =
        await DioServiceAPI().getRequest(url: 'bptks', token: token);

    if (response!.data['error'] == null) {
      final data = ModelAllBptk.fromJson(response.data);
      print("RESPONSE : $response");
      _bptk = data;
      notifyListeners();
    } else {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: 'Gagal Mendapat BPTK',
        ),
      );
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> getAllCradle(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;

    final response =
        await DioServiceAPI().getRequest(url: 'cradles', token: token);

    if (response!.data['error'] == null) {
      final data = ModelCradle.fromJson(response.data);
      print("RESPONSE : $response");
      _cradle = data;
      notifyListeners();
    } else {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: 'Gagal Mendapat Cradle',
        ),
      );
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> createCradle(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;

    final response = await DioServiceAPI()
        .postRequest(url: 'cradles', token: token, data: {});

    if (response!.data['error'] == null) {
      getAllCradle(context);
      notifyListeners();
    } else {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: 'Gagal Mendapat Cradle',
        ),
      );
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> createCradleDetails(
      BuildContext context, int id, int tubeId) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;

    final response = await DioServiceAPI().postRequest(
        url: 'cradle-details',
        token: token,
        data: {"tube_id": tubeId, "cradle_id": id});

    if (response!.data['error'] == null) {
      getAllCradle(context);
      notifyListeners();
    } else {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: 'Gagal Mendapat Cradle',
        ),
      );
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> detailBPTK(BuildContext context, String uuid) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    isLoadingD = true;
    notifyListeners();

    final response =
        await DioServiceAPI().getRequest(url: 'bptks/$uuid', token: token);

    if (response?.data != null) {
      final data = ModelOneBptk.fromJson(response!.data);
      print(data.data);
      _oneBptk = data;
      notifyListeners();
    } else {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: 'Gagal Mendapat BPTK',
        ),
      );
    }

    isLoadingD = false;
    notifyListeners();
  }

  Future<void> deleteDetail(
      BuildContext context, String noBptk, int tube, String reason) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;

    final response = await DioServiceAPI()
        .putRequest(url: 'bptks_detail/$noBptk', token: token, data: {
      "id_detail": tube,
      "reason": reason,
    });

    if (response?.data != null) {
      print(response!.data);
      Navigator.pop(context);
    } else {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: 'Gagal Menghapus Tabung',
        ),
      );
    }
  }

  Future<void> deleteTube(BuildContext context, String noBptk) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;

    final response =
        await DioServiceAPI().deleteRequest(url: 'tubes/$noBptk', token: token);

    if (response?.data != null) {
      print(response!.data);
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.success(
          message: 'Berhasil Menghapus Tabung',
        ),
      );
      getAllTube(context);
    } else {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: 'Gagal Menghapus Tabung',
        ),
      );
    }
  }

  Future<void> deleteCradle(BuildContext context, String idCradle) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;

    final response = await DioServiceAPI().deleteRequest(
      url: 'cradles/$idCradle',
      token: token,
    );

    if (response?.data != null) {
      print(response!.data);
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.success(
          message: 'Berhasil Menghapus Cradle',
        ),
      );
      getAllCradle(context);
      Navigator.pop(context);
    } else {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: 'Gagal Menghapus Cradle',
        ),
      );
    }
  }

  Future<void> deleteDetailBPTI(
      BuildContext context, String noBPTI, int tube, String reason) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;

    final response = await DioServiceAPI()
        .putRequest(url: 'bptis_detail/$noBPTI', token: token, data: {
      "id_detail": tube,
      "reason": reason,
    });

    if (response?.data != null) {
      print(response!.data);
      Navigator.pop(context);
    } else {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: 'Gagal Menghapus Tabung',
        ),
      );
    }
  }

  Future<void> getAllCostumer(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    // isLoadingC = true;
    // notifyListeners();

    final response =
        await DioServiceAPI().getRequest(url: 'customers', token: token);

    if (response!.data['error'] == null) {
      final data = ModelAllCostumer.fromJson(response.data);
      print("RESPONSE : $response");
      _customer = data;
      notifyListeners();
    } else {
      // showTopSnackBar(
      //   Overlay.of(context),
      //   const CustomSnackBar.success(
      //     message: 'Gagal Mendapat Customer',
      //   ),
      // );
      print('error get customer');
    }
    // isLoadingC = false;
    // notifyListeners();
  }

  Future<void> getAllSupplier(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    // isLoadingC = true;
    // notifyListeners();

    final response =
        await DioServiceAPI().getRequest(url: 'vendors', token: token);

    if (response!.data['error'] == null) {
      final data = ModelSupplier.fromJson(response.data);
      // print("RESPONSE : ${response}");
      _supplier = data;
      notifyListeners();
    } else {
      // showTopSnackBar(
      //   Overlay.of(context),
      //   const CustomSnackBar.success(
      //     message: 'Gagal Mendapat Customer',
      //   ),
      // );
      print('error get customer');
    }
    // isLoadingC = false;
    // notifyListeners();
  }

  Future<void> deleteTabung(BuildContext context, String uuid) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;

    final response =
        await DioServiceAPI().deleteRequest(url: 'tube/$uuid', token: token);
    print(response?.data);
  }

  Future<void> getAllTubeGrade(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    // isLoading = true;
    // notifyListeners();
    final response =
        await DioServiceAPI().getRequest(url: 'tube_grades', token: token);

    if (response!.data['error'] == null) {
      final data = ModelAllTubeGrades.fromJson(response.data);
      // print("RESPONSE : ${data.data}");
      _tubeGrades = data;
      notifyListeners();
    } else {
      // showTopSnackBar(
      //   Overlay.of(context),
      //   const CustomSnackBar.success(
      //     message: 'Gagal Mendapat Tube Grade',
      //   ),
      // );
      print('error get tube');
    }
    // isLoading = false;
    // notifyListeners();
  }

  Future<void> getAllTubeType(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    // isLoading = true;
    // notifyListeners();
    final response =
        await DioServiceAPI().getRequest(url: 'tube_types', token: token);

    if (response!.data['error'] == null) {
      final data = ModelAllTubeType.fromJson(response.data);
      // print("RESPONSE : ${data}");
      _tubeTypes = data;
      notifyListeners();
    } else {
      // showTopSnackBar(
      //   Overlay.of(context),
      //   const CustomSnackBar.success(
      //     message: 'Gagal Mendapat Tube Types',
      //   ),
      // );
      print('error get tube type');
    }
    // isLoading = false;
    // notifyListeners();
  }

  Future<void> getAllTube(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;

    final response =
        await DioServiceAPI().getRequest(url: 'tubes', token: token);

    if (response!.data['error'] == null) {
      final data = ModelTube.fromJson(response.data);
      // print("RESPONSE : ${data.data?.length}");
      _tube = data;
      notifyListeners();
    } else {
      print("error get");
    }
    Future.delayed(const Duration(seconds: 1), () {
      isLoadingTube = false;
      notifyListeners();
    });
  }

  Future<void> countTube() async {
    for (var item in tube!.data!) {
      if (item.ownerShipType == 1) {
        tabungA++;
        notifyListeners();
      } else if (item.ownerShipType == 2) {
        tabungP++;
        notifyListeners();
      } else {
        print("");
      }
    }
  }

  Future<void> countClear() async {
    tabungP = 0;
    tabungA = 0;
    notifyListeners();
    print('Berhasil Clear');
  }

  Future<void> getAllTubeGas(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    // isLoading = true;
    // notifyListeners();
    final response =
        await DioServiceAPI().getRequest(url: 'tube_gas', token: token);

    if (response!.data['error'] == null) {
      final data = ModelAllTubeGas.fromJson(response.data);
      // print("RESPONSE : ${data}");
      _tubeGas = data;
      notifyListeners();
    } else {
      // showTopSnackBar(
      //   Overlay.of(context),
      //   const CustomSnackBar.success(
      //     message: 'Gagal Mendapat Tube Gas',
      //   ),
      // );
      print('error get tube gas');
    }
    // isLoading = false;
    // notifyListeners();
  }

  //Tambah Tabung
  Future<dynamic> createTabung(
    BuildContext context,
    int owner,
    Printer printer,
    bool isSingle,
    int? nonSingletubeType,
    int idjenisGas,
    bool nonGrade,
    int? selectedGradeIndex,
    int? tahun,
    String? serial,
    int? intCustomer,
    int? intVendor,
    String? lokasi,
  ) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    isLoading = true;
    notifyListeners();

    final response = await DioServiceAPI().postRequest(
      url: "tubes",
      token: token,
      data: {
        "photo": '',
        "owner_ship_type": owner,
        "is_has_tube_type": isSingle,
        "tube_type_id": nonSingletubeType,
        "tube_gas_id": idjenisGas,
        "is_has_grade": nonGrade,
        "tube_grade_id": selectedGradeIndex,
        "vendor_id": intVendor,
        "tube_year": tahun,
        "serial_number": serial,
        "customer_id": intCustomer,
        "last_location": lokasi,
      },
    );

    if (response?.data != null) {
      if (response?.data['data']['owner_ship_type'] == 1) {
        await printZPL(printer, response?.data['data']['tube_gas_name'],
            response?.data['data']['code']);
      } else {
        await printZPLCustomer(printer, response?.data['data']['code']);
      }
      await countClear();
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.success(
          message: 'Berhasil Membuat Tube Gas',
        ),
      );
      return response!.data;
    } else {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: 'Gagal Membuat Tube Gas',
        ),
      );
    }
  }

// Fungsi untuk mencetak label menggunakan ZPL
  Future<void> printZPL(
      Printer printer, String name, String serialNumber) async {
    final flutterThermalPrinterPlugin = FlutterThermalPrinter.instance;

    String zplData = '''
^XA
^CF0,25^FO340,68^FD$name^FS
^CFB,15^FO340,93^FDIndustrial Grade 2^FS
^AN,15^FO340,107^FDNo telp^FS
^AN,15^FO400,107^FD:^FS
^AN,15^FO410,107^FD021 - 89117509^FS
^AN,15^FO340,123^FDNo wa^FS
^AN,15^FO400,123^FD:^FS
^AN,15^FO410,123^FD0812 8000 0429^FS
^AN,15^FO340,137^FDEmail^FS
^AN,15^FO400,137^FD:^FS
^AN,15^FO410,137^FDinfo@dwigasindo.co.id^FS
^FO225,5
^BQN,2,5
^FD5xx$serialNumber^FS
^CF0,18
^FB130,1,0,C
^FO215,123
^FD$serialNumber^FS
^CF0N,10
^FB130,1,0,C
^FO213,143
^FDPT. Dwigasindo Abadi^FS
^FO340,15
^BY2
^BCN,50,N,N,N,A^FD$serialNumber^FS
^XZ
  ''';

    try {
      log("Mengirim data ZPL ke printer: ${printer.name}");
      await flutterThermalPrinterPlugin.printData(
        printer,
        zplData.codeUnits,
      );
      log("Cetak ZPL berhasil.");
    } catch (e) {
      log("Error saat mencetak ZPL: $e");
    }
  }

  Future<void> printZPLCustomer(Printer printer, String serialNumber) async {
    final flutterThermalPrinterPlugin = FlutterThermalPrinter.instance;

    String zplData = '''
^XA

^FO8,0
^BQN,2,6
^FD5xx$serialNumber^FS,,

^FO145,10
^BY3
^BCN,80,Y,N,N,A^FD$serialNumber^FS


^XZ
  ''';

    try {
      log("Mengirim data ZPL ke printer: ${printer.name}");
      await flutterThermalPrinterPlugin.printData(
        printer,
        zplData.codeUnits,
      );
      log("Cetak ZPL berhasil.");
    } catch (e) {
      log("Error saat mencetak ZPL: $e");
    }
  }

  Future<void> createNewTabung(
      BuildContext context,
      String uuid,
      int owner,
      bool isSingle,
      int? nonSingletubeType,
      int idjenisGas,
      bool nonGrade,
      int? selectedGradeIndex,
      int? tahun,
      String? serial,
      int? intCustomer,
      int? intVendor,
      String? lokasi) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;

    isLoading = true;
    notifyListeners();

    final response = await DioServiceAPI().postRequest(
      url: "bptk_fill_tube_verify/$uuid",
      token: token,
      data: {
        "photo": '',
        "owner_ship_type": owner,
        "is_has_tube_type": isSingle,
        "tube_type_id": nonSingletubeType,
        "tube_gas_id": idjenisGas,
        "is_has_grade": nonGrade,
        "tube_grade_id": selectedGradeIndex,
        "vendor_id": intVendor,
        "tube_year": tahun,
        "serial_number": serial,
        "customer_id": intCustomer,
        "last_location": lokasi,
      },
    );

    print("Hasil Create ${response?.data}");
    if (response?.data != null) {
      await countClear();

      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.success(
          message: 'Berhasil Membuat Tube Gas',
        ),
      );

      isLoadingTube = true;
      Navigator.pop(context);
      await getAllTube(context);
      await countTube();
      await getAllTubeGrade(context);
      await getAllTubeType(context);
      await getAllTubeGas(context);
      await getAllCostumer(context);
      await getAllSupplier(context);
      isLoadingTube = false;
      return response?.data;
    } else {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: 'Gagal Membuat Tube Gas',
        ),
      );
    }
  }

  //Tambah Tabung
  Future<void> updateTabung(
      BuildContext context,
      String uuid,
      int owner,
      bool isSingle,
      int? nonSingletubeType,
      int idjenisGas,
      bool nonGrade,
      int? selectedGradeIndex,
      int? tahun,
      String? serial,
      int? intCustomer,
      int? intVendor,
      String? lokasi) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    isLoading = true;
    notifyListeners();

    final response = await DioServiceAPI().putRequest(
      url: "tubes/$uuid",
      token: token,
      data: {
        "photo": '',
        "owner_ship_type": owner,
        "is_has_tube_type": isSingle,
        "tube_type_id": nonSingletubeType,
        "tube_gas_id": idjenisGas,
        "is_has_grade": nonGrade,
        "tube_grade_id": selectedGradeIndex,
        "vendor_id": intVendor,
        "tube_year": tahun,
        "serial_number": serial,
        "customer_id": intCustomer,
        "last_location": lokasi,
      },
    );

    if (response?.data != null) {
      await countClear();
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.success(
          message: 'Berhasil Edit Tube Gas',
        ),
      );
      isLoadingTube = true;
      Navigator.pop(context);
      await getAllTube(context);
      await countTube();
      await getAllTubeGrade(context);
      await getAllTubeType(context);
      await getAllTubeGas(context);
      await getAllCostumer(context);
      await getAllSupplier(context);
      isLoadingTube = false;
    } else {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: 'Gagal Edit Tube Gas',
        ),
      );
    }
  }

  // verifikasi by BPTK

  Future<void> getVerifikasiBPTK(BuildContext context, String noBptk) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    print(countT);

    final response = await DioServiceAPI()
        .postRequest(url: "verification_bptk/$noBptk", token: token, data: {
      "status": [0, 1],
    });

    // print(response?.data);
    if (response?.data != null) {
      final data = ModelVerifikasiBptk.fromJson(response!.data);
      _verifikasiBptk = data;
      notifyListeners();
    } else {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: 'Gagal Memuat Data Verifikasi',
        ),
      );
    }
    Future.delayed(const Duration(seconds: 1), () {
      isLoadingVer = false;
      notifyListeners();
    });
  }

  // Create BPTI
  Future<void> createBPTI(BuildContext context, int? idBpti, int? idCus) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    isLoadingVer = true;
    notifyListeners();
    // Data map untuk dikirim ke API
    Map<String, dynamic> requestData = {
      "type": 1, // Type default
      if (idBpti != null) "bptk_id": idBpti, // Hanya kirim jika tidak null
      if (idCus != null) "customer_id": idCus, // Hanya kirim jika tidak null
    };

    final response = await DioServiceAPI().postRequest(
      url: 'bptis',
      token: token,
      data: requestData, // Kirim data yang sudah difilter
    );

    if (response?.data != null) {
      // Navigasi kembali ke halaman BPTI
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const ComponentBPTI()));
    } else {
      // Tampilkan snack bar error
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: 'Gagal Membuat BPTI',
        ),
      );
    }
    isLoadingVer = false;
    notifyListeners();
  }

  // getAll BPTI
  Future<void> getAllBPTI(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    isLoadingTI = true;
    notifyListeners();
    final response =
        await DioServiceAPI().getRequest(url: "bptis", token: token);

    if (response?.data != null) {
      final data = ModelAllBpti.fromJson(response!.data);
      print(data.data!.length);
      _allBpti = data;
    } else {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: 'Gagal Memuat BPTI',
        ),
      );
    }
    Future.delayed(const Duration(seconds: 1), () {
      isLoadingTI = false;
      notifyListeners();
    });
  }

  //dropdwon
  String _selectedItem = 'Select item';

  String get selectedItem => _selectedItem;

  void setSelectedItem(String newValue) {
    _selectedItem = newValue;
    notifyListeners();
  }

  // Tambah tabung
  SingleSelectController<String?> jenisTabung =
      SingleSelectController<String?>(null);
  SingleSelectController<String?> jenisGas =
      SingleSelectController<String?>(null);

  // progres bar
  double _progress = 0.96;

  double get progress => _progress;

  List<String> dataBPTK = ['Tanggal', 'Jenis Gas', 'Sumber TK', 'Driver'];
  List<Map<String, String>> dataBPTK1 = [
    {"tipe": 'BPTK', 'hari': '100', 'bulan': '100'},
    {'tipe': 'BPTI', 'hari': '', 'bulan': '100'}
  ];
  List<Map<String, String>> Tabung = [
    {"tipe": 'Total Tabung', 'hari': '1000', 'bulan': '1000'},
    {'tipe': 'Tabung Asset', 'hari': '', 'bulan': '100'},
    {'tipe': 'Tabung Pelanggan', 'hari': '', 'bulan': '100'},
    {'tipe': 'Tabung Akhir', 'hari': '', 'bulan': '100'},
  ];

  List<Map<String, String>> dataVerifikasi = [
    {'warna': "verifikasi"},
    {'warna': "belum"},
    {'warna': "hapus"},
  ];

  List<Map<String, String>> dataVerifikasiSurat = [
    {'warna': "sedang"},
    {'warna': "selesai"},
    {'warna': "kendala"},
  ];

  List<Map<String, String>> dataScan = [
    {'warna': "verifikasi"},
    {'warna': "hapus"},
  ];

  List<Map<String, Object>> basicData = [
    {'jenis': 'Tabung Asset', 'total': 150},
    {'jenis': 'Tabung Pelanggan', 'total': 150},
  ];

  final List<Map<String, dynamic>> data = [
    {
      "date": "28-09-2024",
      "items": [
        {
          "tipe": "BPTI-0002",
          "nama": "CV Solusi Teknologi Bangsa",
          "total": 13
        },
        {"tipe": "BPTI-0003", "nama": "CV Solusi Teknologi Bangsa", "total": 7},
      ]
    },
    {
      "date": "29-09-2024",
      "items": [
        {
          "tipe": "BPTI-0001",
          "nama": "CV Solusi Teknologi Bangsa",
          "total": 16
        },
      ]
    },
    {
      "date": "30-09-2024",
      "items": [
        {
          "tipe": "BPTI-0001",
          "nama": "CV Solusi Teknologi Bangsa",
          "total": 10
        },
        {
          "tipe": "BPTI-0002",
          "nama": "CV Solusi Teknologi Bangsa",
          "total": 20
        },
        {
          "tipe": "BPTI-0003",
          "nama": "CV Solusi Teknologi Bangsa",
          "total": 18
        },
      ]
    },
  ];

  // Set untuk menyimpan item yang dipilih
  Set<String> selectedItems = <String>{}; // Untuk menyimpan item yang dicentang

  // Daftar untuk menyimpan item yang dipilih
  List<Map<String, dynamic>> selectedItemsList = [];

  void onItemChanged(
      String itemId, bool isSelected, Map<String, dynamic> item) {
    if (isSelected) {
      selectedItems.add(itemId); // Tambahkan ke daftar centang
      selectedItemsList.add(item); // Tambahkan ke list terpilih
    } else {
      selectedItems.remove(itemId); // Hapus dari daftar centang
      selectedItemsList.removeWhere((element) =>
          element['tipe'] == item['tipe']); // Hapus dari list terpilih
    }
    notifyListeners(); // Perbarui UI
  }

  void clearSelectedItems() {
    selectedItems.clear();
    selectedItemsList.clear();
    notifyListeners();
  }

  void setProgress(double newProgress) {
    if (newProgress >= 0 && newProgress <= 1) {
      _progress = newProgress;
      notifyListeners();
    }
  }

  void clearProgress() {
    _progress = 0;
    notifyListeners();
  }
}
