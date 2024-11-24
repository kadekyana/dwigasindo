import 'package:dio/dio.dart';
import 'package:dwigasindo/const/const_api.dart';
import 'package:dwigasindo/model/modelAllLocation.dart';
import 'package:dwigasindo/model/modelAllUnit.dart';
import 'package:dwigasindo/model/modelAllWarehouse.dart';
import 'package:dwigasindo/model/modelSupplier.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../model/modelAllCategory.dart';
import '../model/modelAllItem.dart';
import '../model/modelMutasi.dart';
import 'provider_auth.dart';

class ProviderItem extends ChangeNotifier {
  final dio = Dio();
  bool isLoading = false;
  ValueNotifier<bool> visible = ValueNotifier<bool>(false);

  ModelAllItem? _allItem;

  ModelAllItem? get allItem => _allItem;

  // tube grade
  ModelAllCategory? _allCategory;
  ModelAllCategory? get allcategory => _allCategory;

  ModelAllLocation? _location;
  ModelAllLocation? get location => _location;

  ModelAllUnit? _allUnit;
  ModelAllUnit? get units => _allUnit;

  ModelSupplier? _supplier;
  ModelSupplier? get supplier => _supplier;

  ModelAllWarehouse? _warehouse;
  ModelAllWarehouse? get warehouse => _warehouse;

  ModelMutasi? _mutasi;
  ModelMutasi? get mutasi => _mutasi;

  String? getCategory(int idCategory) {
    final category = allcategory?.data.firstWhere(
      (category) => category.id == idCategory,
      orElse: () {
        return allItem?.error;
      },
    );
    return category?.name;
  }

  String formatDate(String dateTimeString) {
    // Ubah string ke DateTime
    DateTime dateTime = DateTime.parse(dateTimeString);

    // Format DateTime menjadi dd-MM-yyyy
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);

    return formattedDate;
  }

  String formatTime(String dateTimeString) {
    // Parse string menjadi DateTime
    DateTime dateTime = DateTime.parse(dateTimeString);

    // Format waktu sesuai kebutuhan, hanya menampilkan jam, menit, dan detik
    String formattedTime = DateFormat('HH:mm:ss').format(dateTime);

    return formattedTime;
  }

  Future<void> getAllCategory(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response =
        await DioServiceAPI().getRequest(url: "categories", token: token);

    print(response?.data['error']);
    if (response?.data['error'] == null) {
      final data = ModelAllCategory.fromJson(response!.data);
      _allCategory = data;
      notifyListeners();
    }
  }

  Future<void> getAllLocation(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response =
        await DioServiceAPI().getRequest(url: "locations", token: token);

    print(response?.data['error']);
    if (response?.data['error'] == null) {
      final data = ModelAllLocation.fromJson(response!.data);
      _location = data;
      notifyListeners();
    }
  }

  Future<void> getAllUnit(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response =
        await DioServiceAPI().getRequest(url: "units", token: token);

    print(response?.data['error']);
    if (response?.data['error'] == null) {
      final data = ModelAllUnit.fromJson(response!.data);
      _allUnit = data;
      notifyListeners();
    }
  }

  Future<void> getAllVendor(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response =
        await DioServiceAPI().getRequest(url: "vendors", token: token);

    print(response?.data['error']);
    if (response?.data['error'] == null) {
      final data = ModelSupplier.fromJson(response!.data);
      _supplier = data;
      notifyListeners();
    }
  }

  Future<void> getAllItem(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response =
        await DioServiceAPI().getRequest(url: 'items', token: token);

    print(response?.data['error']);
    if (response?.data['error'] == null) {
      final data = ModelAllItem.fromJson(response!.data);
      _allItem = data;
      notifyListeners();
    } else {
      Navigator.pop(context);
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> createItem(
      BuildContext context,
      String kode,
      String nama,
      int idCategory,
      int lokasi,
      int idUnit,
      int stock,
      int price,
      int limit,
      int idVendor,
      int isRawMaterial) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response =
        await DioServiceAPI().postRequest(url: 'items', token: token, data: {
      "code": kode,
      "name": nama,
      "category_id": idCategory,
      "location_id": lokasi,
      "unit_id": idUnit,
      "stock": stock,
      "price": price,
      "limit_stock": limit,
      "vendor_id": idVendor,
      "photo": null,
      "is_raw_material": isRawMaterial
    });

    print(response?.data['error']);
    if (response?.data['error'] == null) {
      getAllItem(context);
      Navigator.pop(context);
    }
  }

  Future<void> createPenyesuaian(
      BuildContext context,
      int itemId,
      String operator,
      int quantity,
      String keterangan,
      int pic,
      int warehouseId) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;

    final response = await DioServiceAPI()
        .postRequest(url: 'item_adjustments', token: token, data: {
      'item_id': itemId,
      'operator': operator,
      'quantity': quantity,
      'note': keterangan,
      "pic_verified_by": pic,
      "pic_acknowledged_by": pic,
      "pic_approved_by": pic
    });
    final responseMutation = await DioServiceAPI()
        .postRequest(url: 'item_mutations', token: token, data: {
      "item_id": itemId,
      "warehouse_id": warehouseId,
      "operator": operator,
      "quantity": quantity
    });

    print("${response?.data['error']} && ${responseMutation?.data['error']}");
    if (response?.data['error'] == null &&
        responseMutation?.data['error'] == null) {
      Navigator.pop(context);
      await getAllItem(context);
    } else {
      print('error update');
    }
  }

  Future<void> getAllWarehouse(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response =
        await DioServiceAPI().getRequest(url: "warehouses", token: token);

    if (response?.data['error'] == null) {
      final data = ModelAllWarehouse.fromJson(response!.data);
      _warehouse = data;
      notifyListeners();
    }
  }

  Future<void> getMutasi(BuildContext context, String uuid) async {
    isLoading = true;
    notifyListeners();

    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .getRequest(url: 'item_mutation_by_item_id/$uuid', token: token);

    if (response?.data['error'] == null) {
      final data = ModelMutasi.fromJson(response!.data);
      _mutasi = data;
      isLoading = false;
      notifyListeners();
    } else {
      Navigator.pop(context);
      isLoading = false;
      notifyListeners();
    }
  }

//   Future<void> updateSuratJalan(BuildContext context, String uuid, int type,
//       int? driverId, String? name, String vehicleNumber, int customer) async {
//     if (type == 0) {
//       name = null;
//     }
//     final auth = Provider.of<ProviderAuth>(context, listen: false);
//     final token = auth.auth!.data.accessToken;
//     final response = await DioServiceAPI()
//         .putRequest(url: 'delivery_notes/$uuid', token: token, data: {
//       "type": type,
//       "driver_id": driverId,
//       "name": name,
//       "vehicle_number": vehicleNumber,
//       "customer_id": 1,
//     });

//     print("NAME : $name");

//     print(response?.data);
//     if (response?.data['error'] == null) {
//       await getAllSuratJalan(context);
//       Navigator.pop(context);
//     } else {
//       await getAllSuratJalan(context);
//       Navigator.pop(context);
//     }
//   }
}
