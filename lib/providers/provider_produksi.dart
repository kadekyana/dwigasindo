import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dwigasindo/const/const_api.dart';
import 'package:dwigasindo/model/modelAllItem.dart';
import 'package:dwigasindo/model/modelAllMixGas.dart';
import 'package:dwigasindo/model/modelAllProduksi.dart';
import 'package:dwigasindo/model/modelAllRak.dart';
import 'package:dwigasindo/model/modelAllTank.dart';
import 'package:dwigasindo/model/modelAllTubeGas.dart';
import 'package:dwigasindo/model/modelAllTubeShelfMixGas.dart';
import 'package:dwigasindo/model/modelAllVendor.dart';
import 'package:dwigasindo/model/modelIsiData.dart';
import 'package:dwigasindo/model/modelIsiRak.dart';
import 'package:dwigasindo/model/modelLoadingTube.dart';
import 'package:dwigasindo/model/modelLoadingTubeMixGas.dart';
import 'package:dwigasindo/model/modelMixGroupRak.dart';
import 'package:dwigasindo/model/modelMixRak.dart';
import 'package:dwigasindo/model/modelTank.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'provider_auth.dart';

class ProviderProduksi extends ChangeNotifier {
  final dio = Dio();
  bool isLoading = false;
  ValueNotifier<bool> visible = ValueNotifier<bool>(false);

  ModelAllProduksi? _allProduksi;

  ModelAllProduksi? get allProduksi => _allProduksi;

  ModelAllRak? _allRak;

  ModelAllRak? get allRak => _allRak;

  ModelIsiRak? _isiRak;

  ModelIsiRak? get isiRak => _isiRak;

  ModelAllMixGas? _allMixGas;

  ModelAllMixGas? get allMixGas => _allMixGas;

  ModelMixGroupRak? _groupRakMix;

  ModelMixGroupRak? get groupRakMix => _groupRakMix;

  ModelMixRak? _mixRak;

  ModelMixRak? get mixRak => _mixRak;

  ModelAllItem? _allItem;

  ModelAllItem? get allItem => _allItem;

  ModelAllTubeGas? _allTubeGas;

  ModelAllTubeGas? get allTubeGas => _allTubeGas;

  ModelAllTank? _allTank;

  ModelAllTank? get allTank => _allTank;

  ModelAllVendor? _allVendor;

  ModelAllVendor? get allVendor => _allVendor;

  ModelAllTubeShelfMixGas? _allTubeShelfMixGas;

  ModelAllTubeShelfMixGas? get allTubeShelfMixGas => _allTubeShelfMixGas;

  ModelIsiData? _isiData;

  ModelIsiData? get isiData => _isiData;

  ModelLoadingTubeMixGas? _tubeMixGas;

  ModelLoadingTubeMixGas? get tubeMixGas => _tubeMixGas;

  ModelTank? _tank;

  ModelTank? get tank => _tank;

  Future<void> getDetailTank(BuildContext context, int id) async {
    isLoading = true;
    notifyListeners();
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .getRequest(url: 'get_stock_card_by_tank/$id', token: token);

    print(response?.data['error']);
    if (response?.data['error'] == null) {
      final data = ModelTank.fromJson(response!.data);
      _tank = data;
      notifyListeners();
    } else {
      Navigator.pop(context);
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> getAllProduksi(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response =
        await DioServiceAPI().getRequest(url: 'c2h2_productions', token: token);

    print(response?.data['error']);
    if (response?.data['error'] == null) {
      final data = ModelAllProduksi.fromJson(response!.data);
      _allProduksi = data;
      notifyListeners();
    } else {
      Navigator.pop(context);
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> getAllMixGas(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .getRequest(url: 'mix_gas_production', token: token);

    print(response?.data['error']);
    if (response?.data['error'] == null) {
      final data = ModelAllMixGas.fromJson(response!.data);
      _allMixGas = data;
      notifyListeners();
    } else {
      Navigator.pop(context);
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> getAllRak(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response =
        await DioServiceAPI().getRequest(url: 'shelves', token: token);

    print(response?.data['error']);
    if (response?.data['error'] == null) {
      final data = ModelAllRak.fromJson(response!.data);
      _allRak = data;
      notifyListeners();
    } else {
      Navigator.pop(context);
    }
    isLoading = false;
    notifyListeners();
  }

  Future<ModelLoadingTube> getTubeLoading(
      BuildContext context, int status) async {
    isLoading = true;
    notifyListeners();
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .getRequest(url: 'tube_loadings/$status', token: token);

    print(response?.data['data']);
    if (response?.data['error'] == null) {
      return ModelLoadingTube.fromJson(response!.data);
    } else {
      isLoading = false;
      notifyListeners();
      throw Exception('Failed to load data');
    }
  }

  Future<ModelLoadingTubeMixGas> getLoadingTubeMixGas(
      BuildContext context, int status, int fill) async {
    isLoading = true;
    notifyListeners();
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .getRequest(url: 'mix_gas_tube_loadings/$status/$fill', token: token);

    print(response?.data['data']);
    if (response?.data['error'] == null) {
      return ModelLoadingTubeMixGas.fromJson(response!.data);
    } else {
      isLoading = false;
      notifyListeners();
      throw Exception('Failed to load data');
    }
  }

  Future<void> createProduksi(BuildContext context, int? type, String? poNum,
      String? name, String customerName, int tubeQty) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;

    final response = await DioServiceAPI()
        .postRequest(url: 'c2h2_productions', token: token, data: {
      "name": name,
      "type": type,
      "po_num": poNum,
      "customer_name": customerName,
      "tube_qty": tubeQty,
    });

    print("NAME : $name");

    print(response?.data);
    if (response?.data['error'] == null) {
      await getAllProduksi(context);
      Navigator.pop(context);
    } else {
      await getAllProduksi(context);
      Navigator.pop(context);
    }
  }

  Future<void> updatePrefillData(
      BuildContext context, String uuid, int sp, int cb, int vent) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;

    final response = await DioServiceAPI().putRequest(
        url: 'mix_gas_tube_loadings/$uuid',
        token: token,
        data: {
          "status_process": sp,
          "prefill_check_body": cb,
          "prefill_vent": vent
        });

    print(response?.data);
    if (response?.data['error'] == null) {
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
    }
  }

  Future<void> createMaintenance(
    BuildContext context,
    int? type,
    String? noTube,
  ) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .postRequest(url: 'maintenances/create', token: token, data: {
      "type": type, // 1 = High pressure, 2 = C2h2
      "tube_no": noTube
    });

    print(response?.data);
    if (response?.data['error'] == null) {
      showTopSnackBar(
        // ignore: use_build_context_synchronously
        Overlay.of(context),
        const CustomSnackBar.success(
          message: 'Berhasil Perbarui Data',
        ),
      );
    } else {
      showTopSnackBar(
        // ignore: use_build_context_synchronously
        Overlay.of(context),
        const CustomSnackBar.error(
          message: 'Gagal Perbarui Data',
        ),
      );
    }
  }

  Future<void> createMixGas(BuildContext context, int? type, String? poNum,
      String? name, String customerName, int tubeQty, int? selectTube) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .postRequest(url: 'mix_gas_production', token: token, data: {
      "name": name,
      "type": type,
      "po_num": poNum,
      "customer_name": customerName,
      "tube_qty": tubeQty,
      "tube_gas_id": selectTube
    });

    print("NAME : $name");

    print(response?.data);
    if (response?.data['error'] == null) {
      await getAllMixGas(context);
      Navigator.pop(context);
    } else {
      await getAllMixGas(context);
      Navigator.pop(context);
    }
  }

  Future<void> getIsiRak(
      BuildContext context, int? idRak, List<int>? status) async {
    isLoading = true;
    notifyListeners();
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .postRequest(url: 'get_tubes_by_shelf/$idRak', token: token, data: {
      'status': status,
    });

    print(response?.data);
    if (response?.data['error'] == null) {
      // await getAllProduksi(context);
      // Navigator.pop(context);
      final data = ModelIsiRak.fromJson(response!.data);
      _isiRak = data;
      isLoading = false;

      notifyListeners();
    } else {
      // await getAllProduksi(context);
      Navigator.pop(context);
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> updateRefillingTube(BuildContext context, String? tubeNo,
      int? condition, int? remainingGas) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI().putRequest(
        url: 'update_tube_shelves_refill/$tubeNo',
        token: token,
        data: {"is_refill": condition, "remaining_gas": remainingGas});

    print(response?.data['error']);
  }

  Future<void> updateDataLoadingTube(BuildContext context, int? tare,
      int? empty, int? filled, int status, String idStr) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .putRequest(url: 'tube_loadings/$idStr', token: token, data: {
      "tare_weight": tare,
      "empty_weight": empty,
      "filled_weight": filled,
      "status_process": status
    });

    print(response?.data);
    if (response?.data['error'] == null) {
      // await getAllProduksi(context);
      // Navigator.pop(context);
    } else {
      // await getAllProduksi(context);
      // Navigator.pop(context);
    }
  }

  void updateStatus(BuildContext context, String idStr, int isActive) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;

    final response = await DioServiceAPI().putRequest(
        url: 'update_c2h2_production_status/$idStr',
        token: token,
        data: {"is_active": isActive});

    print(response?.data);
  }

  void updateStatusOnSubmit(
      BuildContext context, String idStr, int activeState) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;

    final response = await DioServiceAPI().putRequest(
        url: 'update_c2h2_production_status_process/$idStr',
        token: token,
        data: {"active_process": activeState});

    print(response?.data);
  }

  Future<void> deleteTube(BuildContext context, String id) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;

    final response = await DioServiceAPI()
        .deleteRequest(url: 'tube_shelves/$id', token: token);

    print(response?.data['error']);
  }

  Future<void> getAllMixGroupRak(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;

    final response = await DioServiceAPI()
        .getRequest(url: 'mix_gas_shelf_groups', token: token);
    print(response?.data['error']);
    if (response?.data['error'] == null) {
      final data = ModelMixGroupRak.fromJson(response!.data);
      _groupRakMix = data;
      notifyListeners();
    }
  }

  Future<void> getAllMixRak(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;

    final response =
        await DioServiceAPI().getRequest(url: 'mix_gas_shelves', token: token);
    print(response?.data['error']);
    if (response?.data['error'] == null) {
      final data = ModelMixRak.fromJson(response!.data);
      _mixRak = data;
      notifyListeners();
    }
  }

  Future<void> getAllItem(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;

    final response =
        await DioServiceAPI().getRequest(url: 'items', token: token);
    print(response?.data['error']);
    if (response?.data['error'] == null) {
      final data = ModelAllItem.fromJson(response!.data);
      _allItem = data;
      notifyListeners();
    }
  }

  Future<void> getAllTubeGas(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;

    final response =
        await DioServiceAPI().getRequest(url: 'tube_gas', token: token);
    print(response?.data['error']);
    if (response?.data['error'] == null) {
      final data = ModelAllTubeGas.fromJson(response!.data);
      _allTubeGas = data;
      notifyListeners();
    }
  }

  Future<void> getAllTank(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;

    final response =
        await DioServiceAPI().getRequest(url: 'tanks', token: token);
    print(response?.data['error']);
    if (response?.data['error'] == null) {
      final data = ModelAllTank.fromJson(response!.data);
      _allTank = data;
      notifyListeners();
    }
  }

  Future<void> getAllVendor(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;

    final response =
        await DioServiceAPI().getRequest(url: 'vendors', token: token);
    print(response?.data['error']);
    if (response?.data['error'] == null) {
      final data = ModelAllVendor.fromJson(response!.data);
      _allVendor = data;
      notifyListeners();
    }
  }

  Future<void> createRakMixGas(BuildContext context, int id, int fill,
      int group, int rak, int gas, List<Map<String, dynamic>> form) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;

    final List<Map<String, dynamic>> transformedItems = form.map((item) {
      return {
        "item_id": item["komposisi"], // Ubah key 'komposisi' menjadi 'item_id'
        "tank_id": item["tank"], // Ubah key 'tank' menjadi 'tank_id'
        "vendor_id": item["vendor"], // Ubah key 'vendor' menjadi 'vendor_id'
        "qty": item["qty"], // Key 'qty' tetap sama
      };
    }).toList();

    print("Data yang dikirim ke server:");
    print({
      "c2h2_production_id": id,
      "fill_type": fill,
      "mix_gas_shelf_group_id": group,
      "mix_gas_shelf_id": rak,
      "tube_gas_id": gas,
      "items": transformedItems,
    });

    final response = await DioServiceAPI()
        .postRequest(url: "mix_gas_shelf_production", token: token, data: {
      "c2h2_production_id": id,
      "fill_type": fill,
      "mix_gas_shelf_group_id": group,
      "mix_gas_shelf_id": rak,
      "tube_gas_id": gas,
      "items": form.map((item) {
        return {
          "item_id": int.parse(item["komposisi"]
              .toString()), // Ubah key 'komposisi' menjadi 'item_id'
          "tank_id": int.parse(
              item["tank"].toString()), // Ubah key 'tank' menjadi 'tank_id'
          "vendor_id": int.parse(item["vendor"]
              .toString()), // Ubah key 'vendor' menjadi 'vendor_id'
          "qty": int.parse(item["qty"].toString()), // Key 'qty' tetap sama
        };
      }).toList(),
    });

    print(response?.data['error']);
  }

  Future<void> getTubeShelfMixGas(BuildContext context, int id) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;

    final response = await DioServiceAPI()
        .getRequest(url: 'get_mix_gas_tubes_by_shelf/$id', token: token);

    if (response?.data != null) {
      final data = ModelAllTubeShelfMixGas.fromJson(response!.data);
      _allTubeShelfMixGas = data;
      notifyListeners();
    }
  }

  Future<int> checkRakMixGas(BuildContext context, String idStr) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;

    final response = await DioServiceAPI()
        .getRequest(url: "mix_gas_shelf_production/$idStr", token: token);
    final id = response!.data['data']['mix_gas_shelf']['id'];
    print("IN Func : ${response.data['data']['mix_gas_shelf']['id']}");
    if (id != 0) {
      await getTubeShelfMixGas(
          context, response.data['data']['mix_gas_shelf']['id']);
    }
    return id;
  }

  Future<void> createUpdateDataMix(
    BuildContext context,
    String idStr,
    int isRefill,
    int level,
    int isPressure,
    File photoLevelStart, // Tambahkan parameter file untuk foto level awal
    File photoPressureStart, // Tambahkan parameter file untuk foto tekanan awal
  ) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth?.data.accessToken;

    if (token == null) {
      print('Error: Token is null');
      return;
    }

    // Validasi input
    if (idStr.isEmpty || level == 0 || isPressure == 0) {
      print('Error: Required fields are missing');
      return;
    }

    if (!photoLevelStart.existsSync() || !photoPressureStart.existsSync()) {
      print('Error: Photo files do not exist');
      return;
    }

    // FormData formData = FormData.fromMap({
    //   "is_refill": isRefill,
    //   "level_start": level,
    //   "photo_level_start": await MultipartFile.fromFile(photoLevelStart.path,
    //       filename: "photo_level_start.jpg"),
    //   "pressure_start": isPressure,
    //   "photo_pressure_start": await MultipartFile.fromFile(
    //       photoPressureStart.path,
    //       filename: "photo_pressure_start.jpg"),
    // });

    // Logging data untuk debugging
    // print('FormData contents:');
    // print('ID : $idStr');
    // formData.fields.forEach((field) {
    //   print('Field: ${field.key} -> ${field.value}');
    // });
    // formData.files.forEach((file) {
    //   print('File: ${file.key} -> ${file.value.filename}');
    // });

    try {
      final response = await DioServiceAPI().putRequest(
        url: 'mix_gas_tube_shelves_start/$idStr',
        token: token,
        data: {
          "is_refill": isRefill,
          "level_start": level,
          "photo_level_start": "photo.jpg",
          "pressure_start": isPressure,
          "photo_pressure_start": "photo_pressure.jpg"
        },
      );

      if (response?.data['error'] == null) {
        showTopSnackBar(
          // ignore: use_build_context_synchronously
          Overlay.of(context),
          const CustomSnackBar.success(
            message: 'Berhasil Perbarui Data',
          ),
        );
        Navigator.pop(context);
      } else {
        print('Error: Response is null');
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> createUpdateDataMixEnd(
    BuildContext context,
    String idStr,
    int isRefill,
    int level,
    int isPressure,
    File photoLevelStart, // Tambahkan parameter file untuk foto level awal
    File photoPressureStart, // Tambahkan parameter file untuk foto tekanan awal
  ) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth?.data.accessToken;

    if (token == null) {
      print('Error: Token is null');
      return;
    }

    // Validasi input
    if (idStr.isEmpty || level == 0 || isPressure == 0) {
      print('Error: Required fields are missing');
      return;
    }

    if (!photoLevelStart.existsSync() || !photoPressureStart.existsSync()) {
      print('Error: Photo files do not exist');
      return;
    }

    // FormData formData = FormData.fromMap({
    //   "is_refill": isRefill,
    //   "level_start": level,
    //   "photo_level_start": await MultipartFile.fromFile(photoLevelStart.path,
    //       filename: "photo_level_start.jpg"),
    //   "pressure_start": isPressure,
    //   "photo_pressure_start": await MultipartFile.fromFile(
    //       photoPressureStart.path,
    //       filename: "photo_pressure_start.jpg"),
    // });

    // Logging data untuk debugging
    // print('FormData contents:');
    // print('ID : $idStr');
    // formData.fields.forEach((field) {
    //   print('Field: ${field.key} -> ${field.value}');
    // });
    // formData.files.forEach((file) {
    //   print('File: ${file.key} -> ${file.value.filename}');
    // });

    try {
      final response = await DioServiceAPI().putRequest(
        url: 'mix_gas_tube_shelves_end/$idStr',
        token: token,
        data: {
          "is_refill": isRefill,
          "level_end": level,
          "photo_level_end": "photo.jpg",
          "pressure_end": isPressure,
          "photo_pressure_end": "photo_pressure.jpg"
        },
      );

      if (response?.data['error'] == null) {
        showTopSnackBar(
          // ignore: use_build_context_synchronously
          Overlay.of(context),
          const CustomSnackBar.success(
            message: 'Berhasil Perbarui Data',
          ),
        );
        Navigator.pop(context);
      } else {
        print('Error: Response is null');
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> getDataIsi(BuildContext context, String idStr) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;

    final response = await DioServiceAPI()
        .getRequest(url: 'mix_gas_tube_shelves/$idStr', token: token);

    print(response?.data);
    if (response?.data['error'] == null) {
      final data = ModelIsiData.fromJson(response!.data);
      _isiData = data;
      notifyListeners();
    }
  }
}
