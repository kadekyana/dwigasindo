import 'package:dio/dio.dart';
import 'package:dwigasindo/const/const_api.dart';
import 'package:dwigasindo/model/modelAllOrder.dart';
import 'package:dwigasindo/model/modelAlokasi.dart';
import 'package:dwigasindo/model/modelCMD.dart';
import 'package:dwigasindo/model/modelCatatanCMD.dart';
import 'package:dwigasindo/model/modelDetailCMD.dart';
import 'package:dwigasindo/model/modelDetailKunjungan.dart';
import 'package:dwigasindo/model/modelDetailLead.dart';
import 'package:dwigasindo/model/modelDetailOrder.dart';
import 'package:dwigasindo/model/modelDistrict.dart';
import 'package:dwigasindo/model/modelDocumentationLeads.dart';
import 'package:dwigasindo/model/modelKunjungan.dart';
import 'package:dwigasindo/model/modelLeads.dart';
import 'package:dwigasindo/model/modelListSales.dart';
import 'package:dwigasindo/model/modelMasterProduk.dart';
import 'package:dwigasindo/model/modelProductCMD.dart';
import 'package:dwigasindo/model/modelProyeksi.dart';
import 'package:dwigasindo/model/modelSummaryLead.dart';
import 'package:dwigasindo/model/modelSummaryOrder.dart';
import 'package:dwigasindo/model/modelSummarySales.dart';
import 'package:dwigasindo/model/modelUsersPic.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'provider_auth.dart';

class ProviderSales extends ChangeNotifier {
  final dio = Dio();
  bool isLoading = false;
  int cekLoad = 0;

  ModelLeads? _leads;

  ModelLeads? get leads => _leads;

  ModelLeads? _leadsTrash;

  ModelLeads? get leadsTrash => _leadsTrash;

  ModelDistrict? _district;

  ModelDistrict? get district => _district;

  ModelSummaryLeads? _summaryLeads;

  ModelSummaryLeads? get summaryLeads => _summaryLeads;

  ModelDocumentationLead? _documentationLead;

  ModelDocumentationLead? get documentationLead => _documentationLead;

  ModelDocumentationLead? _documentationCMD;

  ModelDocumentationLead? get documentationCMD => _documentationCMD;

  ModelDetailLead? _detailLead;

  ModelDetailLead? get detailLead => _detailLead;

  ModelCmd? _cmd;

  ModelCmd? get cmd => _cmd;

  ModelDetailCmd? _detailCMD;

  ModelDetailCmd? get detailCMD => _detailCMD;

  ModelCatatanCmd? _catatanCmd;

  ModelCatatanCmd? get catatanCmd => _catatanCmd;

  ModelProdukCmd? _produkCmd;

  ModelProdukCmd? get produkCmd => _produkCmd;

  ModelMasterProduk? _produk;

  ModelMasterProduk? get produk => _produk;

  ModelProyeksi? _dataProyeksi;

  ModelProyeksi? get dataProyeksi => _dataProyeksi;

  ModelAlokasi? _alokasi;

  ModelAlokasi? get alokasi => _alokasi;

  ModelAllOrder? _order;

  ModelAllOrder? get order => _order;

  ModelSummaryOrder? _summaryOrder;

  ModelSummaryOrder? get summaryOrder => _summaryOrder;

  ModelSummarySales? _summarySales;

  ModelSummarySales? get summarySales => _summarySales;

  ModelKunjungan? _kunjungan;

  ModelKunjungan? get kunjungan => _kunjungan;

  ModelDetailKunjungan? _detailKunjungan;

  ModelDetailKunjungan? get detailKunjugan => _detailKunjungan;

  ModelDetailOrder? _detailOrder;

  ModelDetailOrder? get detailOrder => _detailOrder;

  ModelUsersPic? _modelUsersPic;

  ModelUsersPic? get modelUsersPic => _modelUsersPic;

  ModelListSales? _listSales;

  ModelListSales? get listSales => _listSales;

  String getRemarksLabel(String remarks) {
    List<String> values =
        remarks.split(',').map((e) => e.trim()).toList(); // Hapus spasi
    List<String> labels = [];

    if (values.contains('1')) labels.add('gas');
    if (values.contains('2')) labels.add('jasa');
    if (values.contains('3')) labels.add('item');

    return labels.join(' , ');
  }

  Future<void> getUsersPic(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response =
        await DioServiceAPI().getRequest(url: "users_pluck", token: token);

    print(response?.data);
    if (response?.data['error'] == null) {
      final data = ModelUsersPic.fromJson(response!.data);
      _modelUsersPic = data;
      notifyListeners();
    }
  }

  Future<void> getDetailOrder(BuildContext context, int id) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .getRequest(url: "orders/get-detail-by-id/$id", token: token);

    print(response?.data);
    if (response?.data['error'] == null) {
      final data = ModelDetailOrder.fromJson(response!.data);
      _detailOrder = data;
      notifyListeners();
    }
  }

  Future<void> getDetailKungan(BuildContext context, int id) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI().getRequest(
        url: "visitings/tasks/get-all-task-by-visiting-id/$id", token: token);

    print(response?.data);
    if (response?.data['error'] == null) {
      final data = ModelDetailKunjungan.fromJson(response!.data);
      _detailKunjungan = data;
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

  Future<void> getAllKunjungan(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .getRequest(url: "visitings/get-all", token: token);

    print(response?.data);
    if (response?.data['error'] == null) {
      final data = ModelListSales.fromJson(response!.data);
      _listSales = data;
      notifyListeners();
    }
  }

  Future<void> getAllList(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .getRequest(url: "visitings/tasks/get-all", token: token);

    print(response?.data);
    if (response?.data['error'] == null) {
      final data = ModelKunjungan.fromJson(response!.data);
      _kunjungan = data;
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

  Future<void> getSummaryOrder(BuildContext context) async {
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

  Future<void> getSummarySales(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .getRequest(url: "visitings/summary", token: token);

    print(response?.data);
    if (response?.data['error'] == null) {
      final data = ModelSummarySales.fromJson(response!.data);
      _summarySales = data;
      notifyListeners();
    }
  }

  Future<void> searchProdukGas(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    //type : 0.all | 1.gas | 2.jasa
    final response = await DioServiceAPI().getRequest(
        url: "products/search_product?search=&limit=0&type=1", token: token);

    print(response?.data);
    if (response?.data['error'] == null) {
      final data = ModelMasterProduk.fromJson(response!.data);
      _produk = data;
      notifyListeners();
    }
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

  String convertToApiDateFormat(String date) {
    try {
      List<String> parts = date.split("-");
      if (parts.length != 3)
        return ""; // Jika format salah, kembalikan string kosong

      int day = int.parse(parts[0]);
      int month = int.parse(parts[1]);
      int year = int.parse(parts[2]);

      DateTime formattedDate = DateTime(year, month, day);
      return "${formattedDate.toIso8601String()}Z"; // Format: YYYY-MM-DDTHH:MM:SSZ
    } catch (e) {
      print("❌ Error parsing date: $e");
      return ""; // Kembalikan string kosong jika gagal
    }
  }

  String formatCurrency(num amount) {
    final format = NumberFormat.currency(
      locale: 'id_ID', // Set locale to Indonesia
      symbol: 'Rp. ', // Set currency symbol
      decimalDigits: 0, // No decimal places for currency
    );
    return format.format(amount); // Format the amount
  }

  Future<void> getCMD(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response =
        await DioServiceAPI().getRequest(url: "customers", token: token);

    print(response?.data);
    if (response?.data['error'] == null) {
      final data = ModelCmd.fromJson(response!.data);
      _cmd = data;
      notifyListeners();
    }
  }

  Future<void> getDocumentationLeads(BuildContext context, int idLead) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .getRequest(url: "leads/documentation/$idLead", token: token);

    print(response?.data);
    if (response?.data['error'] == null) {
      final data = ModelDocumentationLead.fromJson(response!.data);
      _documentationLead = data;
      notifyListeners();
    }
  }

  Future<void> getDocumentationCMD(BuildContext context, int id) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .getRequest(url: "crm/documentations/$id", token: token);

    print(response?.data);
    if (response?.data['error'] == null) {
      final data = ModelDocumentationLead.fromJson(response!.data);
      _documentationCMD = data;
      notifyListeners();
    }
  }

  Future<void> getProdukCMD(BuildContext context, int id) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .getRequest(url: "crm/products?type=0&cid=$id", token: token);

    print(response?.data);
    if (response?.data['error'] == null) {
      final data = ModelProdukCmd.fromJson(response!.data);
      _produkCmd = data;
      notifyListeners();
    }
  }

  Future<void> getAlokasi(BuildContext context, int id) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI().getRequest(
        url: "crm/projections/get-all-allocation/$id", token: token);

    print(response?.data);
    if (response?.data['error'] == null) {
      final data = ModelAlokasi.fromJson(response!.data);
      _alokasi = data;
      notifyListeners();
    }
  }

  Future<void> getSummaryLeads(BuildContext context) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .getRequest(url: "leads/summary-lead", token: token);

    print(response?.data);
    if (response?.data['error'] == null) {
      final data = ModelSummaryLeads.fromJson(response!.data);
      _summaryLeads = data;
      notifyListeners();
    }
  }

  Future<void> getDistrict(BuildContext context, String search) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .getRequest(url: "districts?search=$search&limit=0", token: token);

    print(response?.data);
    if (response?.data['error'] == null) {
      final data = ModelDistrict.fromJson(response!.data);
      _district = data;
      notifyListeners();
    }
  }

  Future<void> getLeads(BuildContext context, int status) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .getRequest(url: "leads/by-status?status=$status", token: token);

    print(response?.data);
    if (response?.data['error'] == null) {
      final data = ModelLeads.fromJson(response!.data);
      _leads = data;
      notifyListeners();
    }
  }

  Future<void> getCatatanCmd(BuildContext context, int id) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response =
        await DioServiceAPI().getRequest(url: "crm/notes/$id", token: token);

    print(response?.data);
    if (response?.data['error'] == null) {
      final data = ModelCatatanCmd.fromJson(response!.data);
      _catatanCmd = data;
      notifyListeners();
    }
  }

  Future<void> getLeadsTrash(BuildContext context, int status) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .getRequest(url: "leads/by-status?status=$status", token: token);

    print(response?.data);
    if (response?.data['error'] == null) {
      final data = ModelLeads.fromJson(response!.data);
      _leadsTrash = data;
      notifyListeners();
    }
  }

  Future<void> getDetailLead(BuildContext context, int id) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .getRequest(url: "leads/follow_up/$id", token: token);

    print(response?.data);
    if (response?.data['error'] == null) {
      final data = ModelDetailLead.fromJson(response!.data);
      _detailLead = data;
      notifyListeners();
    }
  }

  Future<void> getDetailCMD(BuildContext context, int id) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response =
        await DioServiceAPI().getRequest(url: "customers/$id", token: token);

    print(response?.data);
    if (response?.data['error'] == null) {
      final data = ModelDetailCmd.fromJson(response!.data);
      _detailCMD = data;
      notifyListeners();
    }
  }

  Future<void> getProyeksi(BuildContext context, int id) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .getRequest(url: "crm/projections/get-all/$id", token: token);

    print(response?.data);
    if (response?.data['error'] == null) {
      final data = ModelProyeksi.fromJson(response!.data);
      _dataProyeksi = data;
      notifyListeners();
    }
  }

  Future<void> updateStatusLead(BuildContext context, int id, int type) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI().putRequest(
        url: "leads/update-status/$id", token: token, data: {"type": type});

    print(response?.data);
    if (response?.data['error'] == null) {
      getLeads(context, 0);
      notifyListeners();
    }
  }

  Future<void> updateLead(BuildContext context, int id) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI().putRequest(
        url: "leads/update-lead-status/$id", token: token, data: {});

    print(response?.data);
    if (response?.data['error'] == null) {
      getLeads(context, 0);
      Navigator.pop(context);
      notifyListeners();
    }
  }

  Future<void> closingDeal(BuildContext context, int id) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .putRequest(url: "leads/closing-deal/$id", token: token, data: {});

    print(response?.data);
    if (response?.data['error'] == null) {
      getLeads(context, 0);
      Navigator.pop(context);
      notifyListeners();
    }
  }

  Future<void> uploadDoc(BuildContext context, int id, String filePath) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI().uploadFile(
      url: "leads/documentation/$id",
      token: token,
      filePath: filePath,
      data: {"path": filePath},
    );

    print(response?.data);
    if (response?.data['error'] == null) {
      getDocumentationLeads(context, id);
      notifyListeners();
    }
  }

  Future<void> createLead(BuildContext context, String name, String pic,
      String phone, int id, int type, int coorporation) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response =
        await DioServiceAPI().postRequest(url: "leads", token: token, data: {
      "name": name,
      "pic": pic,
      "phone": phone,
      "district_id": id,
      "type": type, // 1 = low, 2 = med , 3 = high
      "type_coorporation": coorporation,
    });

    print(response?.data);
    if (response?.data['error'] == null) {
      getLeads(context, 0);
      Navigator.pop(context);
      notifyListeners();
    }
  }

  Future<void> createTambahProdukCostumer(
      BuildContext context,
      int id,
      int type,
      int? itemId,
      int? productId,
      double hpp,
      double price,
      String note) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .postRequest(url: "crm/products", token: token, data: {
      "customer_id": id,
      "type": type,
      "item_id": itemId, // when type 1 / 2 use this
      "product_id": productId, // when type 3  use this
      "hpp": hpp,
      "price": price,
      "note": note // can null
    });

    print(response?.data);
    if (response?.data['error'] == null) {
      getProdukCMD(context, id);
      Navigator.pop(context);
      notifyListeners();
    }
  }

  Future<void> createTugasKunjungan(
      BuildContext context,
      int visiting,
      int type,
      int? cusId,
      int? leadId,
      String lokasi,
      String note,
      int ap1,
      int ap2) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .postRequest(url: "visitings/create", token: token, data: {
      "type_visiting":
          visiting, // 1 = Prospek, 2 = Exising Customer, 3 = Komplain, 4 = Claim
      "type": type, // 1 = Lead, 2 = Customer
      "customer_id": cusId,
      "lead_id": leadId,
      "location": lokasi,
      "notes": note,
      "approval1_id": ap1,
      "approval2_id": ap2
    });

    print(response?.data);
    if (response?.data['error'] == null) {
      getAllList(context);
      getAllKunjungan(context);
      Navigator.pop(context);
      notifyListeners();
    }
  }

  Future<void> createTugas(BuildContext context, int id, int task, double long,
      double lang, String note) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .postRequest(url: "visitings/tasks/create", token: token, data: {
      "visiting_id": id,
      "task_type":
          task, // 1 = check in, 2 = catatan, 3 = check out, 4 = disposisi
      "long": long,
      "lat": lang,
      "note": note
    });

    print(response?.data);
    if (response?.data['error'] == null) {
      getDetailKungan(context, id);
      Navigator.pop(context);
      notifyListeners();
    }
  }

  Future<void> createNote(
    BuildContext context,
    int id,
    String note,
  ) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI().postRequest(
        url: "crm/notes/create",
        token: token,
        data: {"note": note, "customer_id": id});

    print(response?.data);
    if (response?.data['error'] == null) {
      getCatatanCmd(context, id);
      Navigator.pop(context);
      notifyListeners();
    }
  }

  Future<void> createProyeksi(
      BuildContext context,
      int id,
      int proId,
      double harga,
      double losses,
      double limbah,
      double penolong,
      double listrik,
      double volume,
      int jenisVolume,
      int tenaga,
      double trasnport,
      double hp,
      double total,
      double margin,
      int jenisMargin,
      double pemakaian,
      double cashback,
      int jenisCashback,
      double investasi,
      double beli,
      double to,
      double cradle,
      int umur) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;
    final response = await DioServiceAPI()
        .postRequest(url: "crm/projections/create", token: token, data: {
      "customer_id": id,
      "product_id": proId,
      "liquid_price": harga,
      "loses_production": losses,
      "waste": limbah,
      "auxiliary_material": penolong,
      "electricity_maintenance": listrik,
      "volume": volume,
      "volume_type": jenisVolume,
      "worker": tenaga,
      "transport_price": trasnport,
      "vgl_o2_price": hp,
      "total_cost": total,
      "margin": margin,
      "margin_type": jenisMargin,
      "used_monthly": pemakaian,
      "cashback": cashback,
      "cashback_type": jenisCashback,
      "tube_investation": investasi,
      "tube_hpp": beli,
      "tube_to": to,
      "cradle_to": cradle,
      "age_economy_monthly": umur
    });

    print(response?.data);
    if (response?.data['error'] == null) {
      print("Acc jika berhasil");
      getProyeksi(context, id);
      Navigator.pop(context);
    } else {
      print("Gagal");
    }
  }

  Future<void> createCustomer(
    BuildContext context,
    String name,
    String address,
    String code,
    String npwp,
    int districtId,
    double radius,
    bool isLimitPlatform,
    double limitPlatform,
    int typeCorporation,
    int typeDelivery,
    String deliveryRequestBy,
    String deliveryRequestPhone,
    int typePayment,
    int typeInvoice,
    int paymentTermType,
    int paymentTerm,
    String tubePrefix,
    bool isProyeksiProfit,
    String cooperationSince,
    List<Map<String, dynamic>> pics,
    List<Map<String, dynamic>> addressesList,
    int ap1,
    int ap2,
    int ap3,
    int ap4,
    int ap5,
    int ap6,
  ) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;

    final response = await DioServiceAPI()
        .postRequest(url: "customers", token: token, data: {
      "name": name,
      "address": address,
      "code": code,
      "npwp": npwp,
      "district_id": districtId,
      "radius": radius,
      "is_limit_platform": isLimitPlatform,
      "limit_platform": limitPlatform,
      "type_coorporation": typeCorporation, // 1 = perusahaan, 2 = perorangan
      "type_delivery": typeDelivery,
      "delivery_request_by": deliveryRequestBy,
      "delivery_request_phone": deliveryRequestPhone,
      "type_payment": typePayment,
      "type_invoice": typeInvoice,
      "payment_term_type": paymentTermType,
      "payment_term": paymentTerm,
      "tube_prefix": tubePrefix,
      "is_proyeksi_profit": isProyeksiProfit,
      "cooperation_since": convertToApiDateFormat(cooperationSince),
      "approval1": ap1,
      "approval2": ap2,
      "approval3": ap3,
      "approval4": ap4,
      "approval5": ap5,
      "approval6": ap6,
      "pics": pics,
      "addresses_list": addressesList
    });

    print(response?.data);
    if (response?.data['error'] == null) {
      // If successful, you may want to refresh data, show a success message, or navigate
      // For example, calling another function to update the customer list:
      getCMD(context);
      Navigator.pop(context);
      notifyListeners();
    }
  }

  Future<void> createFollowUp(
      BuildContext context,
      int status,
      String note,
      List<Map<String, dynamic>> items,
      List<Map<String, dynamic>> products,
      int id) async {
    try {
      final auth = Provider.of<ProviderAuth>(context, listen: false);
      final token = auth.auth?.data.accessToken;

      if (token == null) {
        throw Exception("Token tidak ditemukan, harap login kembali.");
      }

      final data = {
        "status": status,
        "note": note,
        "items": items,
        "products": products
      };

      final response = await DioServiceAPI().postRequest(
        url: "leads/follow_up/$id",
        token: token,
        data: data,
      );

      if (response?.data['error'] == null) {
        Navigator.pop(context);
        debugPrint("Follow-up berhasil dibuat: ${response?.data}");
      } else {
        throw Exception("Gagal membuat follow-up: ${response?.data['error']}");
      }
    } catch (e) {
      debugPrint("Error createFollowUp: $e");
    }
  }

  Future<void> updateCustomer(
      BuildContext context,
      int id,
      String name,
      String address,
      String code,
      String npwp,
      int districtId,
      double radius,
      bool isLimitPlatform,
      double limitPlatform,
      int typeCorporation,
      int typeDelivery,
      String deliveryRequestBy,
      String deliveryRequestPhone,
      int typePayment,
      int typeInvoice,
      int paymentTermType,
      int paymentTerm,
      String tubePrefix,
      bool isProyeksiProfit,
      String cooperationSince,
      List<Map<String, dynamic>> pics,
      List<Map<String, dynamic>> addressesList) async {
    final auth = Provider.of<ProviderAuth>(context, listen: false);
    final token = auth.auth!.data.accessToken;

    final response = await DioServiceAPI()
        .putRequest(url: "customers/$id", token: token, data: {
      "name": name,
      "address": address,
      "code": code,
      "npwp": npwp,
      "district_id": districtId,
      "radius": radius,
      "is_limit_platform": isLimitPlatform,
      "limit_platform": limitPlatform,
      "type_coorporation": typeCorporation, // 1 = perusahaan, 2 = perorangan
      "type_delivery": typeDelivery,
      "delivery_request_by": deliveryRequestBy,
      "delivery_request_phone": deliveryRequestPhone,
      "type_payment": typePayment,
      "type_invoice": typeInvoice,
      "payment_term_type": paymentTermType,
      "payment_term": paymentTerm,
      "tube_prefix": tubePrefix,
      "is_proyeksi_profit": isProyeksiProfit,
      "cooperation_since": convertToApiDateFormat(cooperationSince),
      "approval1": 1,
      "approval2": 1,
      "approval3": 1,
      "approval4": 1,
      "approval5": 1,
      "approval6": 1,
      "pics": pics,
      "addresses_list": addressesList
    });

    print(response?.data);
    if (response?.data['error'] == null) {
      // If successful, you may want to refresh data, show a success message, or navigate
      // For example, calling another function to update the customer list:
      getCMD(context);
      Navigator.pop(context);
      notifyListeners();
    }
  }

  // Future<void> searchProduk(BuildContext context, String search) async {
  //   final auth = Provider.of<ProviderAuth>(context, listen: false);
  //   final token = auth.auth!.data.accessToken;
  //   //type : 0.all | 1.gas | 2.jasa
  //   final response = await DioServiceAPI().getRequest(
  //       url: "products/search_product?search=$search&limit=0&type=0",
  //       token: token);

  //   print(response?.data);
  //   if (response?.data['error'] == null) {
  //     final data = ModelMasterProduk.fromJson(response!.data);
  //     _produk = data;
  //     notifyListeners();
  //   }
  // }

  // Future<void> createProduk(BuildContext context, String name, int hpp,
  //     int price, String note, int type, bool isGrade, int? tubeId) async {
  //   final auth = Provider.of<ProviderAuth>(context, listen: false);
  //   final token = auth.auth!.data.accessToken;

  //   print(type);
  //   print(tubeId);
  //   print(isGrade);

  //   final response = await DioServiceAPI()
  //       .postRequest(url: 'products/create', token: token, data: {
  //     "name": name,
  //     "hpp": hpp,
  //     "price": price,
  //     "note": note, // null / string
  //     "type": type, // 1 = Gas, 2 = Jasa
  //     "is_grade": isGrade,
  //     "tube_grade_id": tubeId // if is_grade = true then this field required
  //   });

  //   print(response?.data['error']);
  //   if (response?.data['error'] == null) {
  //     getMasterProduk(context);
  //     showTopSnackBar(
  //       Overlay.of(context),
  //       const CustomSnackBar.success(
  //         message: 'Berhasil Tambah Item',
  //       ),
  //     );
  //     Navigator.pop(context);
  //   } else {
  //     showTopSnackBar(
  //       Overlay.of(context),
  //       const CustomSnackBar.error(
  //         message: 'Gagal Tambah Item',
  //       ),
  //     );
  //   }
  // }

  // Future<void> updateProduk(
  //     BuildContext context, int hpp, int price, String note, int id) async {
  //   final auth = Provider.of<ProviderAuth>(context, listen: false);
  //   final token = auth.auth!.data.accessToken;

  //   final response = await DioServiceAPI()
  //       .putRequest(url: 'products/update-by-id/$id', token: token, data: {
  //     "hpp": hpp,
  //     "price": price,
  //     "note": note, // null / string
  //   });

  //   print(response?.data['error']);
  //   if (response?.data['error'] == null) {
  //     getMasterProduk(context);
  //     showTopSnackBar(
  //       Overlay.of(context),
  //       const CustomSnackBar.success(
  //         message: 'Berhasil Ubah Item',
  //       ),
  //     );
  //     Navigator.pop(context);
  //   } else {
  //     showTopSnackBar(
  //       Overlay.of(context),
  //       const CustomSnackBar.error(
  //         message: 'Gagal Ubah Item',
  //       ),
  //     );
  //   }
  // }
}
