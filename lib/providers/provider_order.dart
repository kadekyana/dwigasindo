import 'package:dio/dio.dart';
import 'package:dwigasindo/const/const_api.dart';
import 'package:dwigasindo/model/modelAllOrder.dart';
import 'package:dwigasindo/model/modelDetailOrder.dart';
import 'package:dwigasindo/model/modelMasterProduk.dart';
import 'package:dwigasindo/model/modelSatuanProduk.dart';
import 'package:dwigasindo/model/modelSummary.dart';
import 'package:dwigasindo/model/modelSummaryOrder.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'provider_auth.dart';

class ProviderOrder extends ChangeNotifier {
  final dio = Dio();
  bool isLoading = false;
  int cekLoad = 0;
  ValueNotifier<bool> visible = ValueNotifier<bool>(false);

  ModelMasterProduk? _produk;

  ModelMasterProduk? get produk => _produk;

  ModelMasterProduk? _produkTrash;

  ModelMasterProduk? get produkTrash => _produkTrash;

  ModelMasterProdukSatuan? _produkSatuan;

  ModelMasterProdukSatuan? get produkSatuan => _produkSatuan;

  ModelSummary? _summary;

  ModelSummary? get summary => _summary;

  ModelAllOrder? _order;

  ModelAllOrder? get order => _order;

  ModelSummaryOrder? _summaryOrder;

  ModelSummaryOrder? get summaryOrder => _summaryOrder;

  String formatDate(String dateTimeString) {
    // Ubah string ke DateTime
    DateTime dateTime = DateTime.parse(dateTimeString);

    // Format DateTime menjadi dd-MM-yyyy
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);

    return formattedDate;
  }

  String getRemarksLabel(String remarks) {
    List<String> values = remarks.split(',');
    List<String> labels = [];

    if (values.contains('1')) labels.add('gas');
    if (values.contains('2')) labels.add('jasa');
    if (values.contains('3')) labels.add('item');

    return labels.join(' , ');
  }

  String formatTime(String dateTimeString) {
    // Parse string menjadi DateTime
    DateTime dateTime = DateTime.parse(dateTimeString);

    // Format waktu sesuai kebutuhan, hanya menampilkan jam, menit, dan detik
    String formattedTime = DateFormat('HH:mm:ss').format(dateTime);

    return formattedTime;
  }

  String formatCurrency(num amount) {
    final format = NumberFormat.currency(
      locale: 'id_ID', // Set locale to Indonesia
      symbol: 'Rp. ', // Set currency symbol
      decimalDigits: 0, // No decimal places for currency
    );
    return format.format(amount); // Format the amount
  }

  Future<void> deleteMasterProduk(BuildContext context, int id) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .deleteRequest(url: "products/delete-by-id/$id", token: token);

    print(response?.data);
    if (response?.data['error'] == null) {
      getMasterProduk(context);
      getMasterProdukTrash(context);
      notifyListeners();
    }
  }

  Future<void> getData(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response =
        await DioServiceAPI().getRequest(url: "products/summary", token: token);

    print(response?.data);
    if (response?.data['error'] == null) {
      final data = ModelSummary.fromJson(response!.data);
      _summary = data;
      notifyListeners();
    }
  }

  Future<void> getMasterProduk(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .getRequest(url: "products/get-all?is_deleted=false", token: token);

    print(response?.data);
    if (response?.data['error'] == null) {
      final data = ModelMasterProduk.fromJson(response!.data);
      _produk = data;
      notifyListeners();
    }
  }

  Future<void> getAllOrder(BuildContext context, int type) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .getRequest(url: "orders?type=$type", token: token);

    print(response?.data);
    if (response?.data['error'] == null) {
      final data = ModelAllOrder.fromJson(response!.data);
      _order = data;
      notifyListeners();
    }
  }

  Future<void> getSummaryOrder(BuildContext context, int type) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response =
        await DioServiceAPI().getRequest(url: "orders/summary", token: token);

    print(response?.data);
    if (response?.data['error'] == null) {
      final data = ModelSummaryOrder.fromJson(response!.data);
      _summaryOrder = data;
      notifyListeners();
    }
  }

  Future<void> searchProduk(BuildContext context, String search) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    //type : 0.all | 1.gas | 2.jasa
    final response = await DioServiceAPI().getRequest(
        url: "products/search_product?search=$search&limit=0&type=0",
        token: token);

    print(response?.data);
    if (response?.data['error'] == null) {
      final data = ModelMasterProduk.fromJson(response!.data);
      _produk = data;
      notifyListeners();
    }
  }

  Future<void> getMasterProdukTrash(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .getRequest(url: "products/get-all?is_deleted=true", token: token);

    print(response?.data);
    if (response?.data['error'] == null) {
      final data = ModelMasterProduk.fromJson(response!.data);
      _produkTrash = data;
      notifyListeners();
    }
  }

  Future<void> getMasterProdukId(BuildContext context, int id) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .getRequest(url: "products/get-by-id/$id", token: token);

    print(response?.data);
    if (response?.data['error'] == null) {
      final data = ModelMasterProdukSatuan.fromJson(response!.data);
      _produkSatuan = data;
      notifyListeners();
    }
  }

  Future<void> createProduk(BuildContext context, String name, int hpp,
      int price, String note, int type, bool isGrade, int? tubeId) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;

    print(type);
    print(tubeId);
    print(isGrade);

    final response = await DioServiceAPI()
        .postRequest(url: 'products/create', token: token, data: {
      "name": name,
      "hpp": hpp,
      "price": price,
      "note": note, // null / string
      "type": type, // 1 = Gas, 2 = Jasa
      "is_grade": isGrade,
      "tube_grade_id": tubeId // if is_grade = true then this field required
    });

    print(response?.data['error']);
    if (response?.data['error'] == null) {
      getMasterProduk(context);
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.success(
          message: 'Berhasil Tambah Item',
        ),
      );
      Navigator.pop(context);
    } else {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: 'Gagal Tambah Item',
        ),
      );
    }
  }

  Future<void> createProdukOrder(
    BuildContext context,
    int customerId,
    int type,
    String? path,
    int approval1,
    int approval2,
    int approval3,
    List<Map<String, dynamic>> items,
    List<Map<String, dynamic>> products,
  ) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;

    final Map<String, dynamic> payload = {
      "customer_id": customerId,
      "type": type,
      "path": path,
      "approval1": approval1,
      "approval2": approval2,
      "approval3": approval3,
      "items": items,
      "products": products,
    };

    final response = await DioServiceAPI().postRequest(
      url: 'products/create',
      token: token,
      data: payload,
    );

    print(response?.data['error']);
    if (response?.data['error'] == null) {
      getAllOrder(context, 1);
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.success(
          message: 'Berhasil Tambah Order',
        ),
      );
      Navigator.pop(context);
    } else {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: 'Gagal Tambah Order',
        ),
      );
    }
  }

  Future<void> updateProduk(
      BuildContext context, int hpp, int price, String note, int id) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;

    final response = await DioServiceAPI()
        .putRequest(url: 'products/update-by-id/$id', token: token, data: {
      "hpp": hpp,
      "price": price,
      "note": note, // null / string
    });

    print(response?.data['error']);
    if (response?.data['error'] == null) {
      getMasterProduk(context);
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.success(
          message: 'Berhasil Ubah Item',
        ),
      );
      Navigator.pop(context);
    } else {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: 'Gagal Ubah Item',
        ),
      );
    }
  }
}
